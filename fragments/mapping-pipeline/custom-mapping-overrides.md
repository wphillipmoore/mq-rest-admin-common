The built-in mapping tables cover all standard MQSC attributes, but sites may
use different naming conventions. The mapping overrides mechanism lets you layer
sparse changes on top of the built-in data without replacing it.

### How merging works

Overrides are merged at the **key level** within each sub-map. You only specify
the entries you want to change. A single override entry doesn't affect the
hundreds of other mappings.

When an override is applied:

1. The built-in mapping data is deep-copied (the original is never mutated).
2. The specified qualifier's sub-map is updated: the entry for the overridden
   key changes to the new value.
3. All other entries in that sub-map (and all other sub-maps) remain unchanged.

### Supported override keys

The top level of overrides accepts two keys:

- **commands**: Override command-level metadata (e.g. which qualifier a command
  resolves to). Each command entry is shallow-merged.
- **qualifiers**: Override qualifier mapping tables. Each qualifier supports
  five sub-maps:
  - request key map — developer-friendly → MQSC key mapping for requests
  - request value map — value translations for request attributes
  - request key-value map — combined key+value translations for requests
  - response key map — MQSC → developer-friendly key mapping for responses
  - response value map — value translations for response attributes

### Adding new qualifiers

You can add mappings for qualifiers not yet covered by the built-in data by
providing a complete qualifier entry in the overrides.

### Validation

The override structure is validated at session construction time. Invalid shapes
raise errors immediately, so problems are caught before any commands are sent.

### Opting out

Mapping can be disabled entirely or selectively:

- **Session-level**: Disable mapping when creating the session.
- **Per-call**: Disable mapping for a single command invocation.

When mapping is disabled, attributes pass through in their native MQSC form.
