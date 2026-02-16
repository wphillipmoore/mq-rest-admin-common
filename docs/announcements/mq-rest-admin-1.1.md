# mq-rest-admin 1.1 announcement

General-purpose announcement for the mq-rest-admin 1.1 series.
Adapt tone and length per channel; the core message stays the same.

---

## Short version (Reddit, Hacker News, forum posts)

**mq-rest-admin: IBM MQ administration libraries now available in
Python, Java, and Go**

Earlier this year I released pymqrest, a Python library for
administering IBM MQ queue managers through the REST API. Since then
the project has grown into a family of libraries covering three
languages, all sharing the same design and the same canonical mapping
data.

The 1.1 release brings Python, Java, and Go to feature parity:

- **Python** (`pymqrest`) &mdash; `pip install pymqrest`. snake_case
  methods, httpx transport with async support, 100% branch coverage.
- **Java** (`mq-rest-admin`) &mdash; Maven Central. camelCase methods,
  `java.net.http.HttpClient` transport, zero runtime dependencies beyond
  Gson.
- **Go** (`mqrest`) &mdash; Go standard library only. PascalCase
  methods, `context.Context` on all I/O, zero external dependencies.

All three wrap the `runCommandJSON` REST endpoint. No C client library
to install, no platform-specific binaries,
nothing to compile. Each library provides:

- **130+ command methods** covering the full MQSC verb set (DISPLAY,
  DEFINE, ALTER, DELETE, START, STOP, CLEAR, and more)
- **Automatic attribute mapping** between terse MQSC tokens
  (`CURDEPTH`, `DEFPSIST`) and idiomatic names for each language
- **Idempotent ensure methods** for 16 object types: define if missing,
  alter only what changed, skip when already correct
- **Flexible authentication**: mutual TLS client certificates, LTPA
  token, and HTTP Basic

Under the hood, all three libraries consume the same `mapping-data.json`
from the shared `mq-rest-admin-common` repository. When a mapping is
added or corrected, every language picks it up. Same coverage, same
version, same behaviour.

**What's next**: Ruby and Rust ports are already under way (repos are
public). The shared architecture and mapping data make new language
ports tractable &mdash; the mapping pipeline, command coverage, and
ensure semantics are already defined. If you'd like to see
mq-rest-admin in another language, open an issue on the common repo.
We'd love to hear what you need.

- **Common (mapping data & docs)**: [GitHub](https://github.com/wphillipmoore/mq-rest-admin-common)
- **Python**: [GitHub](https://github.com/wphillipmoore/mq-rest-admin-python) | [Docs](https://wphillipmoore.github.io/mq-rest-admin-python/1.1/)
- **Java**: [GitHub](https://github.com/wphillipmoore/mq-rest-admin-java) | [Docs](https://wphillipmoore.github.io/mq-rest-admin-java/1.1/)
- **Go**: [GitHub](https://github.com/wphillipmoore/mq-rest-admin-go) | [Docs](https://wphillipmoore.github.io/mq-rest-admin-go/1.1/)
- **Ruby** (WIP): [GitHub](https://github.com/wphillipmoore/mq-rest-admin-ruby)
- **Rust** (WIP): [GitHub](https://github.com/wphillipmoore/mq-rest-admin-rust)

For the backstory on how this started, see:
[Building pymqrest](https://the-infrastructure-mindset.ghost.io/building-pymqrest-ai-production-library/)

---

## Medium version (LinkedIn, IBM community, mailing lists)

**Announcing mq-rest-admin 1.1: IBM MQ administration libraries for
Python, Java, and Go**

I'm pleased to announce the 1.1 release of the mq-rest-admin project
family &mdash; a set of libraries for administering IBM MQ queue
managers through the REST API, now available in three languages.

### From one library to three

When I released pymqrest earlier this year, it was a single Python
library. I wanted to see the same approach available across as many
modern languages as possible. The 1.1 release delivers on that:
Python, Java, and Go now share feature parity, all built on the same
architecture and the same canonical mapping data.

### One mapping, every language

At the heart of the project is `mapping-data.json`, maintained in the
shared `mq-rest-admin-common` repository. This single file defines the
bidirectional mappings between terse MQSC attribute tokens (`CURDEPTH`,
`MAXDEPTH`, `DEFPSIST`) and readable `snake_case` names
(`current_queue_depth`, `max_queue_depth`, `default_persistence`). The
attribute mappings are language-neutral &mdash; every library uses the
same `snake_case` names. Method names follow each language's conventions
(`display_queue()` in Python, `displayQueue()` in Java,
`DisplayQueue()` in Go), but the mapped attributes are identical across
all three. When a mapping is added or corrected, every library picks it
up automatically.

### What each library provides

All three libraries wrap the `runCommandJSON` REST endpoint. There is no C client dependency &mdash; everything runs over
HTTPS.

- **130+ command methods** covering the full MQSC verb set
- **Automatic attribute mapping** with opt-out at session or per-call
  level
- **Idempotent ensure methods** for 16 object types: define if missing,
  alter only what changed, no-op when already correct
- **Flexible authentication**: mutual TLS client certificates, LTPA
  token login, and HTTP Basic

### Language-specific highlights

**Python** (`pymqrest`)

- Install: `pip install pymqrest`
- snake_case method names (`display_queue()`, `ensure_qlocal()`)
- httpx transport with async support
- 100% branch coverage, strict mypy + ty typing

**Java** (`mq-rest-admin`)

- Maven Central: `io.github.wphillipmoore:mq-rest-admin`
- camelCase method names (`displayQueue()`, `ensureQlocal()`)
- `java.net.http.HttpClient` transport
- Zero runtime dependencies beyond Gson

**Go** (`mqrest`)

- Go standard library only, zero external dependencies
- PascalCase method names (`DisplayQueue()`, `EnsureQlocal()`)
- `context.Context` integration for all I/O methods

### What's coming next

Ruby and Rust ports are already under way &mdash; both repositories are
public on GitHub. The shared architecture makes adding new languages
straightforward: the mapping data, command coverage, and ensure
semantics are defined once in the common repository and consumed by each
language implementation.

If your language isn't covered yet, I'd genuinely like to hear about it.
Open an issue on the
[common repository](https://github.com/wphillipmoore/mq-rest-admin-common)
and let us know what you need. The mapping data and design patterns are
ready &mdash; a new port is more tractable than you might think.

### A bit of history

Some of you may remember the Perl5 MQSeries module on CPAN. I
maintained that library years ago, and this project picks up a thread I
left a long time ago. Seeing it grow from a single Python library to a
multi-language family has been deeply satisfying.

For the full backstory, see:
[Building pymqrest](https://the-infrastructure-mindset.ghost.io/building-pymqrest-ai-production-library/)

### Links

- **Common (mapping data & docs)**: [GitHub](https://github.com/wphillipmoore/mq-rest-admin-common)
- **Python**: [GitHub](https://github.com/wphillipmoore/mq-rest-admin-python) | [PyPI](https://pypi.org/project/pymqrest/) | [Docs](https://wphillipmoore.github.io/mq-rest-admin-python/1.1/)
- **Java**: [GitHub](https://github.com/wphillipmoore/mq-rest-admin-java) | [Docs](https://wphillipmoore.github.io/mq-rest-admin-java/1.1/)
- **Go**: [GitHub](https://github.com/wphillipmoore/mq-rest-admin-go) | [Docs](https://wphillipmoore.github.io/mq-rest-admin-go/1.1/)
- **Ruby** (WIP): [GitHub](https://github.com/wphillipmoore/mq-rest-admin-ruby)
- **Rust** (WIP): [GitHub](https://github.com/wphillipmoore/mq-rest-admin-rust)

Feedback, bug reports, and contributions are welcome across all
repositories.

---

## Micro version (Twitter/X, Mastodon, Bluesky)

mq-rest-admin 1.1: IBM MQ administration libraries now in Python, Java,
and Go. Same REST-based approach, same mapping data, no C client needed.
Ruby and Rust ports in progress. Want another language? Open an issue.

<https://github.com/wphillipmoore/mq-rest-admin-common>

---

## Channel-specific notes

**Reddit** (r/Python, r/java, r/golang, r/ibm, r/sysadmin): Use the
short version. Crosspost to language-specific subreddits with a note
about the relevant library. r/Python readers already saw the pymqrest
1.0.0 announcement; frame this as an update with the multi-language
expansion.

**Hacker News** (Show HN): Use the short version. Title format:
"Show HN: mq-rest-admin &mdash; IBM MQ admin libraries for Python, Java,
and Go (no C client needed)".

**LinkedIn**: Use the medium version. The multi-language expansion and
personal history angle work well here.

**IBM Community / MQ forums**: Use the medium version. This audience
knows MQ deeply and will appreciate the technical specifics about shared
mapping data and the `runCommandJSON` approach.

**Language-specific forums** (discuss.python.org, Java community,
Go forums): Use the short version, emphasising the relevant language.
Link to the language-specific repo and docs.
