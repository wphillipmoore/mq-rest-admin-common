# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/)
and this project adheres to [Semantic Versioning](https://semver.org/).

## [1.2.1] - 2026-03-02

### Bug fixes

- add name_required to DELETE QLOCAL/QREMOTE/QALIAS/QMODEL (#131)

### Documentation

- align nav structure with language repos (#111)
- add central port allocation table for all language repos (#125)
- document local MQ environment scripts for AI agents (#139)

### Features

- add generation metadata and missing ALTER/DEFINE entries to mapping-data.json (#129)
- add cross-repo documentation links fragment (#132)

## [1.2.0] - 2026-02-27

### Bug fixes

- correct snippets base_path resolution for fragment includes (#33)
- run mike from repo root and add language libraries page (#34)
- restore 4 missing mapping entries from Python source (#41)
- set docs default version to latest on main deploy
- correct Go package name from mqrest to mqrestadmin (#55)
- allow commits on release/* branches in library-release model (#56)
- add standards-gates CI workflow (#57)
- correct VERSION file to use semver format (#74)
- update add-to-project action to v1.0.2 (#87)

### CI

- auto-add issues to GitHub Project (#60)
- add CI workflow with docs-only detection and shellcheck (#67)

### Documentation

- rewrite sync-pattern fragment to match actual implementation
- expand QA guardrails and add quality gates reference
- add Trivy and Semgrep to quality gates documentation
- add Ruby and Rust placeholders to language implementations (#43)
- update version to 1.1 and link to versioned docs sites
- draft mq-rest-admin 1.1 multi-language announcement
- fix inaccurate community feedback claim in announcement
- fix incorrect claim about per-language attribute mappings
- drop incorrect MQ 9.4 version reference for runCommandJSON
- add synchronous start/stop methods to announcement features
- reword shared architecture claim in announcement
- add LinkedIn-sized medium version of 1.1 announcement (#58)
- rename mq-dev-environment references to mq-rest-admin-dev-environment (#64)
- ban MEMORY.md usage in CLAUDE.md (#78)
- ban heredocs in shell commands (#79)
- replace stale script references with st-* commands (#101)
- add testing platforms page documenting z/OS coverage gap (#104)

### Features

- add git hooks and lint scripts from canonical standards (#15)
- bootstrap MkDocs site and GitHub Pages workflow (#17)
- add shared documentation fragments, docs site, and mike deployment (#30)
- add category prefixes to job names (#77)
- adopt validate_local.sh dispatch architecture (#80)

### Refactoring

- use shared docs-deploy composite action (#70)
- remove docs-only detection and add tier-1 validation scripts (#103)
