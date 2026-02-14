Mappings are organized by **qualifier** (e.g. `queue`, `channel`, `qmgr`), not
by command. A single qualifier's mapping tables serve all commands that operate
on that object type. For example, the `queue` qualifier covers `DISPLAY QUEUE`,
`DEFINE QLOCAL`, `DELETE QALIAS`, and all other queue-related commands.

This design avoids duplicating mapping data across commands and reflects how
MQSC attributes are shared across command verbs.
