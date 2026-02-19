# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Documentation Strategy

This repository uses two complementary approaches for AI agent guidance:

- **AGENTS.md**: Generic AI agent instructions using include directives to force documentation indexing. Contains canonical standards references, shared skills loading, and user override support.
- **CLAUDE.md** (this file): Claude Code-specific guidance with prescriptive commands, architecture details, and development workflows optimized for `/init`.

### Integration Approach

**For Claude Code** (`/init` command):
1. Read CLAUDE.md (this file) first for optimized quick-start guidance
2. Process include directives to load repository standards
3. Reference AGENTS.md for shared skills and canonical standards location
4. Apply layered standards: canonical → project-specific → user overrides

**For other AI agents** (Codex, generic LLMs):
1. Read AGENTS.md first as the primary entry point
2. Process include directives to load all referenced documentation
3. Resolve canonical standards repo path (local or GitHub)
4. Load shared skills from standards repo
5. Apply user overrides from `~/AGENTS.md` if present

**Key differences**:
- **CLAUDE.md**: Prescriptive, command-focused, optimized for `/init`
- **AGENTS.md**: Declarative, include-directive-driven, forces full documentation indexing

Both files share the same underlying standards via include directives, ensuring consistency across all AI agents working in this repository.

### Best Practices for Dual-File Approach

**What goes in AGENTS.md**:
- Include directives for documentation indexing
- Canonical standards repository references
- Shared skills loading instructions
- User override mechanisms
- Minimal, declarative content

**What goes in CLAUDE.md**:
- Claude Code-specific quick-start commands
- Detailed architecture and design patterns
- Implementation notes and common workflows
- Integration guidance between the two files
- More verbose, prescriptive content

**What goes in neither (use includes instead)**:
- Repository standards (keep in `docs/repository-standards.md`)
- Canonical standards (reference external repo)
- Project-specific conventions (keep in referenced docs)

**Maintenance strategy**:
- Update standards in source files, not in AGENTS.md or CLAUDE.md
- Use include directives to pull in shared content
- Keep AGENTS.md minimal and CLAUDE.md focused on Claude Code workflows
- Test both entry points when updating documentation structure

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

## Documentation Indexing Strategy

This repository uses `<!-- include: path/to/file.md -->` directives to force documentation indexing. When you encounter these directives:

1. **Read the referenced files** to understand the full context
2. **Apply layered standards** in order:
   - Canonical standards (from `standards-and-conventions` repo)
   - Project-specific standards (`docs/repository-standards.md`)
   - User overrides (`~/AGENTS.md` if present)
3. **Load shared skills** from `<standards-repo-path>/skills/**/SKILL.md`

The include directives appear in:
- `AGENTS.md` - Includes repository standards and conventions
- `CLAUDE.md` - Includes same standards for Claude Code
- `docs/standards-and-conventions.md` - Includes canonical standards reference

This approach ensures all AI agents (Codex, Claude, etc.) have access to the same foundational documentation.

## Documentation Structure

- `README.md` - Project overview and quick start
- `AGENTS.md` - Generic AI agent instructions with include directives
- `CLAUDE.md` - This file, Claude Code-specific guidance
- `docs/repository-standards.md` - Project-specific standards (included from AGENTS.md)
- `docs/standards-and-conventions.md` - Canonical standards reference (includes external repo)

## Commit and PR Scripts

**NEVER use raw `git commit`** — always use `scripts/dev/commit.sh`.
**NEVER use raw `gh pr create`** — always use `scripts/dev/submit-pr.sh`.

### Committing

```bash
scripts/dev/commit.sh --type feat --message "add new mapping fragment" --agent claude
scripts/dev/commit.sh --type docs --message "update mapping documentation" --agent claude
```

- `--type` (required): `feat|fix|docs|style|refactor|test|chore|ci|build`
- `--message` (required): commit description
- `--agent` (required): `claude` or `codex` — resolves the correct `Co-Authored-By` identity
- `--scope` (optional): conventional commit scope
- `--body` (optional): detailed commit body

### Submitting PRs

```bash
scripts/dev/submit-pr.sh --issue 42 --summary "Add new mapping fragment for X"
scripts/dev/submit-pr.sh --issue 42 --linkage Ref --summary "Update docs" --docs-only
```

- `--issue` (required): GitHub issue number (just the number)
- `--summary` (required): one-line PR summary
- `--linkage` (optional, default: `Fixes`): `Fixes|Closes|Resolves|Ref`
- `--title` (optional): PR title (default: most recent commit subject)
- `--notes` (optional): additional notes
- `--docs-only` (optional): applies docs-only testing exception
- `--dry-run` (optional): print generated PR without executing

## Key References

**Canonical Standards**: https://github.com/wphillipmoore/standards-and-conventions
- Local path (preferred): `../standards-and-conventions`
- Load all skills from: `<standards-repo-path>/skills/**/SKILL.md`

**Sibling repositories**:
- `../mq-rest-admin-python` — Python implementation
- `../mq-rest-admin-java` — Java implementation
- `../mq-rest-admin-go` — Go implementation

**External Documentation**:
- IBM MQ 9.4 administrative REST API
- MQSC command reference

**User Overrides**: `~/AGENTS.md` (optional, applied if present and readable)
