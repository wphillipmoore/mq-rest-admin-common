# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

<!-- include: docs/standards-and-conventions.md -->
<!-- include: docs/repository-standards.md -->

## Project Overview

This is the shared common repository for the mq-rest-admin project family, serving two roles:

1. **Documentation fragments**: Language-neutral documentation fragments consumed by the per-language repos (Java, Python, Go) via their documentation toolchains
2. **Canonical mapping data**: Single source of truth for `mapping-data.json`, the MQ REST API attribute mapping definitions consumed by all language implementations

**Project name**: mq-rest-admin-common

**Status**: Active

**Canonical Standards**: This repository follows standards at https://github.com/wphillipmoore/standards-and-conventions (local path: `../standards-and-conventions` if available)

## Development Commands

This is a documentation-only repository. There are no build or test commands.

### Environment Setup

```bash
cd ../standard-tooling && uv sync                                                # Install standard-tooling
export PATH="../standard-tooling/.venv/bin:../standard-tooling/scripts/bin:$PATH" # Put tools on PATH
git config core.hooksPath ../standard-tooling/scripts/lib/git-hooks               # Enable git hooks
```

### Validation

```bash
markdownlint '**/*.md'    # Lint all Markdown files
```

## Architecture

### Fragment Organization

```text
fragments/
  architecture/           # Core architecture concepts
  mapping-pipeline/       # Attribute mapping pipeline
  design/                 # Design decisions and rationale
  concepts/               # High-level patterns (ensure, sync)
```

Fragments contain language-neutral concept explanations, diagrams, and tables.
They do NOT contain language-specific code examples, documentation tool syntax,
or references to specific library names.

### mapping-data.json

The root-level `mapping-data.json` is the canonical source for MQ REST API
attribute mapping definitions. It contains:

- **commands**: MQSC command → qualifier mapping (e.g., `"ALTER CHANNEL"` → `"channel"`)
- **qualifiers**: Per-qualifier mapping tables with four map types:
  - `request_key_map`: Friendly name → MQSC parameter (outbound)
  - `request_value_map`: Friendly value → MQSC value (outbound)
  - `response_key_map`: MQSC parameter → friendly name (inbound)
  - `response_value_map`: MQSC value → friendly value (inbound)
  - `request_key_value_map`: Composite key-value transforms (e.g., replace/noreplace)
  - `response_parameter_macros`: Parameter groups expanded at runtime
- **version**: Schema version (currently `1`)

### How Consuming Repos Integrate

- **Java**: Copies `mapping-data.json` into `src/main/resources/` (via CI or manual sync)
- **Python**: References via local clone or CI checkout
- **Go**: Uses `go:embed` or symlink from local clone
- **Documentation sites**: Each language repo clones this repository and uses its
  documentation tool's include mechanism (`pymdownx.snippets`, MyST `{include}`)

## Local MQ Environment

Each language repo (Python, Java, Go, Ruby, Rust) includes thin wrapper
scripts for managing a local MQ container environment. The actual Docker
Compose configuration is owned by the
[mq-rest-admin-dev-environment](https://github.com/wphillipmoore/mq-rest-admin-dev-environment)
repository, which must be cloned as a sibling directory.

### Prerequisite

```bash
git clone https://github.com/wphillipmoore/mq-rest-admin-dev-environment.git ../mq-rest-admin-dev-environment
```

### Lifecycle scripts (in each language repo)

```bash
./scripts/dev/mq_start.sh    # Start containerized MQ queue managers
./scripts/dev/mq_seed.sh     # Seed deterministic test objects (DEV.* prefix)
./scripts/dev/mq_verify.sh   # Verify REST-based MQSC responses
./scripts/dev/mq_stop.sh     # Stop the queue managers
./scripts/dev/mq_reset.sh    # Reset to clean state (removes data volumes)
```

Each language repo sets its own `COMPOSE_PROJECT_NAME` and unique port
assignments to avoid collisions when running multiple environments
simultaneously. Override the dev-environment path with `MQ_DEV_ENV_PATH`.

### Integration test gate

Integration tests are gated by the `MQ_REST_ADMIN_RUN_INTEGRATION`
environment variable. When unset, integration tests are skipped. CI sets
this automatically; for local runs, start MQ first, then export the variable:

```bash
./scripts/dev/mq_start.sh
./scripts/dev/mq_seed.sh
export MQ_REST_ADMIN_RUN_INTEGRATION=true
# Run integration tests (language-specific command)
```

### Container details

- Queue managers: `QM1` and `QM2`
- Admin credentials: `mqadmin` / `mqadmin`
- Read-only credentials: `mqreader` / `mqreader`
- Object prefix: `DEV.*`
- Ports are language-specific (see each repo's `scripts/dev/mq_start.sh`)

## Key References

**Sibling repositories**:
- `../mq-rest-admin-python` — Python implementation
- `../mq-rest-admin-java` — Java implementation
- `../mq-rest-admin-go` — Go implementation

**External Documentation**:
- IBM MQ 9.4 administrative REST API
- MQSC command reference
