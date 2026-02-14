The MQ REST API supports routing MQSC commands from a local **gateway** queue
manager to a remote **target** queue manager over MQ channels. This is the same
mechanism used by `runmqsc -w` and the MQ Console.

When a gateway queue manager is configured on the session:

- The URL path targets the **remote** queue manager:
  `POST /admin/action/qmgr/{TARGET_QM}/mqsc`
- The `ibm-mq-rest-gateway-qmgr` HTTP header names the **local** queue manager
  that routes the command.

When no gateway is configured (the default), no gateway header is sent and the
REST API talks directly to the queue manager in the URL. This makes the feature
purely additive — existing sessions are unaffected.

```text
Client                     Gateway QM (QM1)              Target QM (QM2)
  │                              │                              │
  │  POST /qmgr/QM2/mqsc        │                              │
  │  Header: gateway-qmgr=QM1   │                              │
  │─────────────────────────────>│   MQSC via MQ channel        │
  │                              │─────────────────────────────>│
  │                              │<─────────────────────────────│
  │<─────────────────────────────│                              │
```
