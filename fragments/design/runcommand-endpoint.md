## Payload structure

The IBM MQ administrative REST API provides a `runCommandJSON` endpoint that
accepts MQSC commands as structured JSON:

```text
POST /ibmmq/rest/v2/admin/action/qmgr/{qmgr}/mqsc
```

The request payload has this shape:

```json
{
  "type": "runCommandJSON",
  "command": "DISPLAY",
  "qualifier": "QLOCAL",
  "name": "MY.QUEUE",
  "parameters": {
    "DESCR": "Updated description"
  },
  "responseParameters": ["all"]
}
```

| Field | Required | Description |
| --- | --- | --- |
| `type` | Yes | Always `"runCommandJSON"` |
| `command` | Yes | MQSC verb: `DISPLAY`, `DEFINE`, `DELETE`, `ALTER`, etc. |
| `qualifier` | Yes | Object type: `QLOCAL`, `CHANNEL`, `QMGR`, etc. |
| `name` | No | Object name or pattern. Omitted for queue manager commands. |
| `parameters` | No | Request attributes as key-value pairs. |
| `responseParameters` | No | List of attribute names to return. |

## Response structure

The response contains an array of command results:

```json
{
  "commandResponse": [
    {
      "completionCode": 0,
      "reasonCode": 0,
      "parameters": {
        "queue": "MY.QUEUE",
        "curdepth": 0,
        "maxdepth": 5000
      }
    }
  ],
  "overallCompletionCode": 0,
  "overallReasonCode": 0
}
```

Each item in `commandResponse` represents one matched object and carries its
own completion/reason code pair plus a `parameters` map.

## Error handling

Errors are indicated by non-zero completion and reason codes at two levels:

**Overall codes**: `overallCompletionCode` and `overallReasonCode` on the
top-level response. A non-zero overall code means the command itself failed.

**Per-item codes**: Each `commandResponse` item has `completionCode` and
`reasonCode`. These indicate per-object errors (e.g. object not found in a
wildcard display).

For `DISPLAY` commands with no matches, MQ returns an error response with
reason code 2085 (MQRC_UNKNOWN_OBJECT_NAME). The library intentionally treats
this as an empty list rather than an exception.

## CSRF tokens

The MQ REST API requires a CSRF token header for non-GET requests. The library
sends `ibm-mq-rest-csrf-token` with a default value. This can be overridden at
session creation or omitted entirely.

## Authentication

The library supports HTTP Basic authentication as the primary method. The
`Authorization` header is constructed from the username and password provided at
session creation. Additional authentication methods (client certificates, LTPA
tokens) may be supported depending on the language implementation.
