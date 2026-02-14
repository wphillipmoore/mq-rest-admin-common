Every MQSC command follows the same path through the system:

```text
Method call (e.g. displayQueue / display_queue)
  → command dispatcher
    → Map request attributes (friendly names → MQSC)
    → Map response parameter names
    → Map WHERE keyword
    → Build runCommandJSON payload
    → Transport POST
    → Parse JSON response
    → Extract commandResponse items
    → Flatten nested objects
    → Map response attributes (MQSC → friendly names)
  → Return result
```

### Build phase

1. The command method calls the internal dispatcher with the MQSC verb (e.g.
   `DISPLAY`), qualifier (e.g. `QUEUE`), and user-supplied parameters.
2. If mapping is enabled, request attributes are translated from friendly names
   to MQSC parameter names via the qualifier's request key map and request
   value map.
3. Response parameter names are mapped similarly.
4. A `WHERE` clause keyword, if provided, is mapped through the same qualifier
   key maps.
5. The `runCommandJSON` payload is assembled and sent via the transport.

### Parse phase

1. The JSON response is parsed and validated.
2. Error codes (`overallCompletionCode`, `overallReasonCode`, per-item
   `completionCode`/`reasonCode`) are checked. Errors raise a command
   exception.
3. The `parameters` dict is extracted from each `commandResponse` item.
4. Nested `objects` lists (e.g. from `DISPLAY CONN TYPE(HANDLE)`) are
   flattened into the parent parameter set.
5. If mapping is enabled, response attributes are translated from MQSC to
   friendly names.
