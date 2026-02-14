## Problem statement

Most MQSC commands return a flat list of parameter objects — one map per matched
MQ object. However, two commands return a **nested** structure when queried with
`TYPE(HANDLE)`:

- `DISPLAY CONN TYPE(HANDLE)` — connection handles
- `DISPLAY QSTATUS TYPE(HANDLE)` — queue status handles

In these responses each `commandResponse` item represents a parent entity (a
connection or a queue) that may own multiple handles. The per-handle attributes
are nested inside an `objects` array, while parent-scoped attributes sit
alongside it.

Without intervention this would force every caller to detect and unpack the
nesting manually. The library instead applies transparent flattening so that all
commands — nested or not — return uniform flat maps.

## Raw API response format

A `DISPLAY CONN TYPE(HANDLE)` response with two handles looks like this:

```json
{
  "commandResponse": [
    {
      "completionCode": 0,
      "reasonCode": 0,
      "parameters": {
        "conn": "A1B2C3D4E5F6",
        "extconn": "G7H8I9J0K1L2",
        "objects": [
          {"objname": "MY.QUEUE", "hstate": "ACTIVE", "openopts": 8225},
          {"objname": "MY.OTHER.QUEUE", "hstate": "INACTIVE", "openopts": 8193}
        ]
      }
    }
  ],
  "overallCompletionCode": 0,
  "overallReasonCode": 0
}
```

| Level | Keys | Description |
| --- | --- | --- |
| Parent | `conn`, `extconn` | Connection-scoped attributes shared by all handles |
| Nested | `objname`, `hstate`, `openopts` | Per-handle attributes inside `objects` |

## Flattening algorithm

The flattening function processes the parameter objects list **after** extraction
from the response but **before** attribute mapping:

1. For each parameter map, check whether an `objects` key exists and its value
   is a list.
2. If **yes**: collect all other keys into a shared map, then for each
   map-typed entry in `objects`, merge shared + nested item to produce a flat
   output row. Non-map entries in `objects` are silently skipped.
3. If **no** (the key is absent, or the value is not a list): pass the item
   through unchanged.

Nested-item keys override any same-named parent keys in the merge.

## Flattened result

After flattening, the example above produces two flat maps:

```json
[
  {
    "conn": "A1B2C3D4E5F6",
    "extconn": "G7H8I9J0K1L2",
    "objname": "MY.QUEUE",
    "hstate": "ACTIVE",
    "openopts": 8225
  },
  {
    "conn": "A1B2C3D4E5F6",
    "extconn": "G7H8I9J0K1L2",
    "objname": "MY.OTHER.QUEUE",
    "hstate": "INACTIVE",
    "openopts": 8193
  }
]
```

## Edge cases

| Scenario | Behaviour |
| --- | --- |
| Empty `objects` list | Parent produces **no** output rows |
| `objects` value is not a list (e.g. a string) | Item passes through unchanged |
| Mixed flat and nested items in the same response | Both handled correctly |
| Non-map entries inside `objects` array | Silently skipped |
| Single nested entry | Produces one flat map |

## Where flattening occurs in the pipeline

```text
HTTP response
  → JSON parse
  → extract commandResponse items
  → collect parameter maps
  → flatten nested objects          ← here
  → normalise attribute case
  → map response (if mapping enabled)
  → return to caller
```

Flattening happens before attribute mapping so that the mapping layer sees a
uniform list of flat maps regardless of the original response shape.
