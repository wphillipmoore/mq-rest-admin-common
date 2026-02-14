The sync pattern provides bulk declarative configuration management. Given a
list of desired object definitions, sync compares them against the current state
of the queue manager and applies the minimum set of changes to reach the desired
state.

### Operations

For each object in the desired state:

- **Create**: Object does not exist on the queue manager — issue DEFINE.
- **Alter**: Object exists but attributes differ — issue ALTER.
- **Unchanged**: Object already matches — no action needed.

Objects that exist on the queue manager but are **not** in the desired state
list can optionally be deleted (controlled by a configuration flag).

### Configuration options

| Option | Description |
| --- | --- |
| Object type | The MQSC qualifier to sync (e.g. `QLOCAL`, `CHANNEL`) |
| Desired state | List of object definitions with name and attributes |
| Delete extras | Whether to delete objects not in the desired list |
| Name filter | Pattern to limit which existing objects are compared |

### Result

The sync result contains a summary of all operations performed:

- Number of objects created, altered, unchanged, and deleted
- Per-object details for diagnostic review
- Any errors encountered during the process
