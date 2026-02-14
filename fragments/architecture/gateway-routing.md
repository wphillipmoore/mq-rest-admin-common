The MQ REST API is available on all supported IBM MQ platforms (Linux, AIX,
Windows, z/OS, and IBM i). The library is developed and tested against the
**Linux** implementation.

In enterprise environments, a **gateway queue manager** can route MQSC commands
to remote queue managers via MQ channels — the same mechanism used by
`runmqsc -w` and the MQ Console.

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

### Prerequisites

- The gateway queue manager must have a running REST API.
- MQ channels must be configured between the gateway and target queue managers.
- A QM alias (QREMOTE with empty RNAME) must map the target QM name to the
  correct transmission queue on the gateway.
