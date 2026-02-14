## The fire-and-forget problem

All MQSC `START` and `STOP` commands are fire-and-forget — they return
immediately without waiting for the object to reach its target state. In
practice, tooling that provisions infrastructure needs to wait until a channel
is `RUNNING` or a listener is `STOPPED` before proceeding to the next step.
Writing polling loops by hand is error-prone and clutters business logic with
retry mechanics.

## The sync pattern

The sync methods wrap fire-and-forget START/STOP commands with a polling loop
that issues `DISPLAY *STATUS` until the object reaches a stable state or the
timeout expires.

Each call returns a sync result describing what happened:

- **Operation**: STARTED, STOPPED, or RESTARTED.
- **Polls**: Number of status polls issued.
- **Elapsed time**: Wall-clock seconds from command to confirmation.

## Configuration

Polling behaviour is controlled by two parameters:

| Parameter | Default | Description |
| --- | --- | --- |
| Timeout | 30 seconds | Maximum wait before raising a timeout error |
| Poll interval | 1 second | Seconds between status polls |

## Timeout on expiry

If the object does not reach the target state within the configured timeout, a
timeout error is raised. The error includes the object name, the attempted
operation, and the elapsed time — enabling callers to handle partial progress
or escalate to an operator.

## Restart convenience

The restart methods perform a synchronous stop followed by a synchronous start.
Each phase gets the full timeout independently — the worst case is twice the
configured timeout.

The returned result reports **total** polls and **total** elapsed time across
both phases.

## Available object types

The sync pattern is available for object types that have start/stop semantics:

| Object type | START/STOP qualifier | Status qualifier |
| --- | --- | --- |
| Channel | `CHANNEL` | `CHSTATUS` |
| Listener | `LISTENER` | `LSSTATUS` |
| Service | `SERVICE` | `SVSTATUS` |

Each object type supports start, stop, and restart — nine methods in total.

## Channel stop edge case

When a channel stops, its `CHSTATUS` record may disappear entirely — the
`DISPLAY CHSTATUS` response returns no rows. The sync methods treat an empty
status result as successfully stopped for channels. Listener and service status
records are always present, so empty results are not treated as stopped for
those object types.

## Status detection

The polling loop checks the `STATUS` attribute in the `DISPLAY *STATUS`
response. The target values are:

- **Start**: `RUNNING`
- **Stop**: `STOPPED`

The status key is checked using both the mapped developer-friendly name and the
raw MQSC name, so polling works correctly regardless of whether attribute
mapping is enabled or disabled.
