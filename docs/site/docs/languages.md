# Language Libraries

The mq-rest-admin project provides implementations in three languages.
Each library wraps the IBM MQ administrative REST API with the same
design — qualifier-based attribute mapping, method-per-command API,
and shared `mapping-data.json` — adapted to idiomatic conventions
for its language.

## Java

**Repository**: [mq-rest-admin-java](https://github.com/wphillipmoore/mq-rest-admin-java)
| **Documentation**: [wphillipmoore.github.io/mq-rest-admin-java](https://wphillipmoore.github.io/mq-rest-admin-java/)

- Maven coordinates: `io.github.wphillipmoore:mq-rest-admin`
- Zero runtime dependencies beyond Gson
- `java.net.http.HttpClient` transport
- camelCase method names (`displayQueue()`, `defineQlocal()`)

## Python

**Repository**: [mq-rest-admin-python](https://github.com/wphillipmoore/mq-rest-admin-python)
| **Documentation**: [wphillipmoore.github.io/mq-rest-admin-python](https://wphillipmoore.github.io/mq-rest-admin-python/)

- PyPI package: `pymqrest`
- `httpx` transport with async support
- snake_case method names (`display_queue()`, `define_qlocal()`)

## Go

**Repository**: [mq-rest-admin-go](https://github.com/wphillipmoore/mq-rest-admin-go)
| **Documentation**: [wphillipmoore.github.io/mq-rest-admin-go](https://wphillipmoore.github.io/mq-rest-admin-go/)

- Zero external dependencies (Go standard library only)
- `context.Context` integration for all I/O methods
- PascalCase method names (`DisplayQueue()`, `DefineQlocal()`)
