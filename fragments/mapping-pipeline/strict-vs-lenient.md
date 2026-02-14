**Strict mode** (default): Any attribute name or value that cannot be mapped
raises an error. This catches typos and unsupported attributes early.

**Lenient mode**: Unknown attribute names and values pass through unchanged.
This is useful when working with attributes not yet covered by the mapping
tables.

The mode is set at session creation and applies to all mapping operations.

### Qualifier resolution

When a command is executed, the mapping qualifier is resolved by:

1. Looking up the command key (e.g. `"DISPLAY QUEUE"`) in the command metadata
   for an explicit qualifier.
2. Falling back to a default map (e.g. `QLOCAL` → `queue`,
   `CHANNEL` → `channel`).
3. As a last resort, lowercasing the MQSC qualifier.

This means `DEFINE QLOCAL`, `DEFINE QREMOTE`, and `DISPLAY QUEUE` all resolve
to the `queue` qualifier and share the same mapping tables.
