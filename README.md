# mq-rest-admin-common

Shared documentation fragments for the mq-rest-admin project family.

## Purpose

This repository contains language-neutral documentation fragments that are
composed into per-language documentation sites for:

- [mq-rest-admin-java](https://github.com/wphillipmoore/mq-rest-admin-java) — Java (MkDocs + Material)
- [mq-rest-admin-python](https://github.com/wphillipmoore/mq-rest-admin-python) — Python (Sphinx + MyST)
- [mq-rest-admin-go](https://github.com/wphillipmoore/mq-rest-admin-go) — Go (future)

## Fragment structure

```
fragments/
  architecture/           # Core architecture concepts
  mapping-pipeline/       # Attribute mapping pipeline
  design/                 # Design decisions and rationale
  concepts/               # High-level patterns (ensure, sync)
```

## What fragments contain

- Concept explanations (the "what" and "why")
- Language-neutral diagrams and tables
- MQ REST API protocol documentation

## What fragments do NOT contain

- Language-specific code examples or class names
- Sphinx or MkDocs-specific cross-reference syntax
- References to specific library names (use generic terms like "the session object")

## How consuming sites include fragments

Each language repo clones this repository (via CI or local symlink) and uses its
documentation tool's include mechanism to compose fragments with language-specific
framing:

- **Java (MkDocs)**: `pymdownx.snippets` with `--8<--` syntax
- **Python (Sphinx)**: MyST `{include}` directive
