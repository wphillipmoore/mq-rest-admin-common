# mq-rest-admin-common

Shared documentation fragments and canonical mapping data for the
mq-rest-admin project family.

## What this repository provides

- **Documentation fragments** — language-neutral explanations of architecture,
  mapping pipeline, design decisions, and high-level patterns (ensure, sync)
  that are composed into per-language documentation sites.
- **Canonical mapping data** — the single source of truth for
  `mapping-data.json`, which defines the bidirectional attribute mappings
  between developer-friendly names and native MQSC parameters.
- **Qualifier mapping reference** — auto-generated documentation for all
  41 MQSC qualifier mappings.

## Documentation sections

- [Design](design/index.md) — design rationale, runCommandJSON endpoint,
  nested object flattening
- [Mappings](mappings/index.md) — per-qualifier attribute mapping reference
  (41 qualifiers)
- [AI Engineering](ai-engineering.md) — transparency statement and
  AI-assisted development practices
- [Development](development/local-mq-container.md) — local MQ container
  setup for integration testing

## Language implementations

- [mq-rest-admin-java](https://github.com/wphillipmoore/mq-rest-admin-java) — Java
- [mq-rest-admin-python](https://github.com/wphillipmoore/mq-rest-admin-python) — Python
- [mq-rest-admin-go](https://github.com/wphillipmoore/mq-rest-admin-go) — Go
