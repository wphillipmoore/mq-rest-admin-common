## Why wrap the REST API

IBM MQ provides an administrative REST API, but working with it directly
requires constructing JSON payloads with MQSC-specific parameter names,
handling CSRF tokens, parsing nested response structures, and interpreting
completion/reason code pairs.

The library wraps this complexity behind methods that map 1:1 to MQSC commands,
translate attribute names to developer-friendly conventions, and surface errors
as exceptions with full diagnostic context.

## Single-endpoint design

All MQSC operations go through a single REST endpoint:

```text
POST /ibmmq/rest/v2/admin/action/qmgr/{qmgr}/mqsc
```

The `runCommandJSON` payload structure carries the command verb, qualifier,
object name, and parameters:

```json
{
  "type": "runCommandJSON",
  "command": "DISPLAY",
  "qualifier": "QLOCAL",
  "name": "MY.QUEUE",
  "responseParameters": ["all"]
}
```

This means the library needs exactly one HTTP method, one URL pattern, and one
payload schema to cover the entire MQSC command surface.

## Method naming conventions

Command methods follow the pattern `<verb>_<qualifier>` (or `<verb><Qualifier>`
in camelCase languages) in lowercase with spaces converted to underscores or
camelCase boundaries:

| MQSC command | Method name pattern |
| --- | --- |
| `DISPLAY QUEUE` | `display_queue` / `displayQueue` |
| `DEFINE QLOCAL` | `define_qlocal` / `defineQlocal` |
| `DELETE CHANNEL` | `delete_channel` / `deleteChannel` |
| `ALTER QMGR` | `alter_qmgr` / `alterQmgr` |

This convention provides a predictable, discoverable API without inventing new
abstractions over the MQSC command set.

## Return shape decisions

**DISPLAY commands** return a list of attribute maps. An empty list means no
objects matched — this is not an error. The caller can iterate without checking
for null/None.

**Queue manager singletons** (display queue manager status, etc.) return a
single attribute map or null/None. These commands always return zero or one
result, so a list would be misleading.

**Non-DISPLAY commands** (DEFINE, DELETE, ALTER, etc.) return nothing on success
and raise an exception on failure.

## Attribute mapping complexity

The mapping layer is the most complex part of the library. This complexity
exists because IBM MQ uses terse uppercase tokens (`CURDEPTH`, `DEFPSIST`,
`CHLTYPE`) that are unfriendly in application code. The mapping pipeline
translates these to readable names (`current_depth`, `default_persistence`,
`channel_type`) and back.

The translation is not a simple case conversion. The mapping tables were
originally bootstrapped from IBM MQ 9.4 documentation, then customized and
rationalized. They contain:

- **Key maps**: Attribute name translations (e.g. `CURDEPTH` ↔ `current_depth`).
- **Value maps**: Enumerated value translations (e.g. `"YES"` ↔ `"yes"`,
  `"SVRCONN"` ↔ `"server_connection"`).
- **Key-value maps**: Cases where both key and value change together.
