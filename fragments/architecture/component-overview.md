The library is organized around four core components:

**Session**
: The main entry point. Owns authentication, base URL construction,
  request/response handling, and diagnostic state. Provides generated
  command methods for all MQSC commands. A single session represents a
  connection to one queue manager's REST API.

**Command methods**
: ~144 generated MQSC command methods. Each method is a thin wrapper that
  calls the internal command dispatcher with the correct command verb and
  qualifier. Method names follow the pattern `verb_qualifier` (or
  `verbQualifier` in camelCase languages), mapping directly to MQSC
  commands. For example, `DISPLAY QUEUE` becomes `display_queue` /
  `displayQueue`, and `DEFINE QLOCAL` becomes `define_qlocal` /
  `defineQlocal`.

**Ensure methods**
: 16 idempotent ensure methods for declarative object management. Each
  method checks current state with DISPLAY, then DEFINE, ALTER, or no-ops
  as needed. Returns an ensure result indicating what action was taken.
  The queue manager variant is a special singleton (no name, no DEFINE).
  Only changed attributes are sent in ALTER commands, preserving
  `ALTDATE`/`ALTTIME` audit timestamps.

**Mapping pipeline**
: Bidirectional attribute translation between developer-friendly names and
  native MQSC parameter names. Includes key mapping (attribute names),
  value mapping (enumerated values), and key-value mapping (combined
  name+value translations). The mapping tables were bootstrapped from
  IBM MQ 9.4 documentation and cover all standard MQSC attributes.

**Exception hierarchy**
: Structured error types for transport failures, malformed responses,
  authentication errors, MQSC command errors, and polling timeouts.
  All exceptions carry diagnostic context including the full MQ response
  payload when available.
