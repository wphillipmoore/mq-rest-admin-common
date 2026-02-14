IBM MQ uses multiple naming conventions depending on the interface:

**MQSC names** (e.g. `CURDEPTH`, `DEFPSIST`)
: Short, uppercase tokens used in MQSC commands and the REST API's
  `runCommandJSON` endpoint.

**PCF names** (e.g. `CurrentQDepth`, `DefPersistence`)
: CamelCase names from the Programmable Command Formats. Not used directly
  by the library at runtime, but they formed the intermediate namespace
  during the original extraction process that bootstrapped the mapping tables.

**Developer-friendly names** (e.g. `current_depth`, `default_persistence`)
: Human-readable names for use in application code.

The mapping pipeline translates between MQSC and developer-friendly names. PCF
names were used as an intermediate reference during the original extraction
process but do not appear at runtime.
