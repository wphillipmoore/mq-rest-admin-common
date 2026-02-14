The library is organized around four core components:

**Session**
: The main entry point. Owns authentication, base URL construction,
  request/response handling, and diagnostic state. Provides generated
  command methods for all MQSC commands.

**Command methods**
: ~144 generated MQSC command methods. Each method is a thin wrapper that
  calls the internal command dispatcher with the correct command verb and
  qualifier.

**Ensure methods**
: 16 idempotent `ensure` methods for declarative object management. Each
  method checks current state with DISPLAY, then DEFINE, ALTER, or no-ops
  as needed. Returns an ensure result indicating what action was taken.
  The queue manager variant is a special singleton (no name, no DEFINE).

**Mapping pipeline**
: Bidirectional attribute translation between developer-friendly names and
  native MQSC parameter names. Includes key mapping (attribute names),
  value mapping (enumerated values), and key-value mapping (combined
  name+value translations).

**Exception hierarchy**
: Structured error types for transport failures, malformed responses,
  authentication errors, and MQSC command errors.
