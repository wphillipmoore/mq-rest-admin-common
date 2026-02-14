All MQSC operations go through a single REST endpoint:

```text
POST /ibmmq/rest/v2/admin/action/qmgr/{qmgr}/mqsc
```

The `runCommandJSON` payload specifies the MQSC verb, qualifier, object name,
parameters, and response parameters. This design means the library needs
exactly one HTTP method and one URL pattern to cover all MQSC commands.
