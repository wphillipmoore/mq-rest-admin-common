## The problem with ALTER

Every `alter` call sends an `ALTER` command to the queue manager, even when
every specified attribute already matches the current state. MQ updates
`ALTDATE` and `ALTTIME` on every `ALTER`, regardless of whether any values
actually changed. This makes `ALTER` unsuitable for declarative configuration
management where idempotency matters — running the same configuration twice
should not corrupt audit timestamps.

## The ensure pattern

The ensure methods implement a declarative upsert pattern:

1. **DEFINE** the object when it does not exist.
2. **ALTER** only the attributes that differ from the current state.
3. **Do nothing** when all specified attributes already match, preserving
   `ALTDATE` and `ALTTIME`.

Each call returns an ensure result indicating what action was taken: created
(object did not exist, was defined), updated (object existed, attributes were
altered), or unchanged (object existed, no changes needed).

When an update is needed, the result also indicates which attribute names
triggered the ALTER.

## Comparison logic

The ensure methods compare only the attributes the caller passes in request
parameters against the current state returned by `DISPLAY`. Attributes not
specified by the caller are ignored.

Comparison is:

- **Case-insensitive** — `"ENABLED"` matches `"enabled"`.
- **Type-normalizing** — integer `5000` matches string `"5000"`.
- **Whitespace-trimming** — `" YES "` matches `"YES"`.

An attribute present in the request parameters but absent from the `DISPLAY`
response is treated as changed and included in the `ALTER`.

## Selective ALTER

When an update is needed, only the changed attributes are sent in the `ALTER`
command. Attributes that already match are excluded from the request. This
minimizes the scope of each `ALTER` to the strict delta.

## Available methods

Each method targets a specific MQ object type with the correct MQSC qualifier
triple (DISPLAY / DEFINE / ALTER):

| Method | Object type | DISPLAY | DEFINE | ALTER |
| --- | --- | --- | --- | --- |
| ensure qmgr | Queue manager | `QMGR` | — | `QMGR` |
| ensure qlocal | Local queue | `QUEUE` | `QLOCAL` | `QLOCAL` |
| ensure qremote | Remote queue | `QUEUE` | `QREMOTE` | `QREMOTE` |
| ensure qalias | Alias queue | `QUEUE` | `QALIAS` | `QALIAS` |
| ensure qmodel | Model queue | `QUEUE` | `QMODEL` | `QMODEL` |
| ensure channel | Channel | `CHANNEL` | `CHANNEL` | `CHANNEL` |
| ensure authinfo | Auth info | `AUTHINFO` | `AUTHINFO` | `AUTHINFO` |
| ensure listener | Listener | `LISTENER` | `LISTENER` | `LISTENER` |
| ensure namelist | Namelist | `NAMELIST` | `NAMELIST` | `NAMELIST` |
| ensure process | Process | `PROCESS` | `PROCESS` | `PROCESS` |
| ensure service | Service | `SERVICE` | `SERVICE` | `SERVICE` |
| ensure topic | Topic | `TOPIC` | `TOPIC` | `TOPIC` |
| ensure sub | Subscription | `SUB` | `SUB` | `SUB` |
| ensure stgclass | Storage class | `STGCLASS` | `STGCLASS` | `STGCLASS` |
| ensure comminfo | Comm info | `COMMINFO` | `COMMINFO` | `COMMINFO` |
| ensure cfstruct | CF structure | `CFSTRUCT` | `CFSTRUCT` | `CFSTRUCT` |

Response parameters are not exposed — the ensure logic always requests `["all"]`
internally so it can compare the full current state.

### Queue manager (singleton)

The queue manager ensure method has no name parameter because the queue manager
is a singleton that always exists. It can only return updated or unchanged
(never created).

This makes it ideal for asserting queue manager-level settings such as
statistics, monitoring, events, and logging attributes without corrupting
`ALTDATE`/`ALTTIME` on every run.

## Attribute mapping

The ensure methods participate in the same mapping pipeline as all other command
methods. Pass developer-friendly attribute names in request parameters and the
mapping layer translates them to MQSC names for the DISPLAY, DEFINE, and ALTER
commands automatically.

## Idempotency guarantee

Ensure methods are safe to call repeatedly. Running the same ensure call twice
in succession always produces "unchanged" on the second invocation. This makes
them suitable for configuration-as-code workflows where the desired state is
declared and applied on every run.
