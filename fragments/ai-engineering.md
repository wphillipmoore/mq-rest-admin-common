## Transparency statement

The mq-rest-admin project is an AI-assisted engineering effort. Significant
portions of each language implementation were developed collaboratively between
a human engineer and AI coding agents. This page documents what was
AI-generated, what was human-designed, and how quality was maintained.

### Tools used

- **Claude Code** (Anthropic) — interactive pair-programming agent
- **Codex** (OpenAI) — autonomous task execution agent

## What was AI-generated

**Mapping data bootstrap**: The canonical `mapping-data.json` was originally
bootstrapped from IBM MQ 9.4 documentation using an AI-assisted extraction
pipeline. The pipeline parsed MQSC and PCF command references to propose
`snake_case` attribute names, value mappings, and command metadata for all
48 qualifiers. The automated output was then reviewed, customized, and
rationalized by hand. `mapping-data.json` is now maintained directly as the
sole authoritative source — the extraction pipeline is archived in the Python
repository at `docs/archive/extraction/`.

**Command method generation**: The ~144 MQSC command wrapper methods in each
language implementation are generated from the command definitions in
`mapping-data.json`. Each method is a thin wrapper with the correct verb,
qualifier, and return type.

**Mapping documentation**: The 48 qualifier mapping pages in the documentation
were generated from the same mapping data source.

**Implementation code**: Much of the session, mapping, transport, and test
code was written through AI-assisted pair programming, with the AI agent
proposing implementations and the human engineer reviewing, refining, and
directing the design.

## What was human-designed

**Architecture and API design**: The overall design — single-endpoint via
`runCommandJSON`, qualifier-based mapping, method naming conventions,
return shape rules, error handling strategy — was conceived and directed
by the human engineer.

**Quality standards**: The requirement for comprehensive test coverage and
the validation gate pipeline were human-defined standards. Each language
implementation enforces its own quality tooling as a CI hard gate.

**Design decisions**: Key choices like the mapping opt-out mechanism,
strict vs lenient modes, the transport abstraction, and error handling
patterns were human decisions refined through discussion.

## Quality assurance

The AI-assisted development process maintains quality through:

**Test coverage**: All production code is covered by unit tests. Coverage
is enforced as a CI hard gate in each language implementation.

**Static analysis**: Each implementation runs language-appropriate linters
and static analysis tools as CI hard gates.

**Validation pipeline**: Each repository provides a single command that runs
the same checks as CI, including formatting, linting, tests, and coverage.

**Integration testing**: Containerized IBM MQ queue managers provide real
MQSC command validation. Integration tests verify that mapping assumptions
hold against actual MQ responses.

## The `Co-Authored-By` convention

Commits that involved AI assistance include a `Co-Authored-By` trailer
identifying the agent used:

```text
Co-Authored-By: wphillipmoore-claude <255925739+wphillipmoore-claude@users.noreply.github.com>
Co-Authored-By: wphillipmoore-codex <255923655+wphillipmoore-codex@users.noreply.github.com>
```

This provides a transparent, auditable record of AI involvement in the
project's git history.
