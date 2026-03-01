A containerized IBM MQ environment provides two queue managers for
development and integration testing.

## Prerequisites

- Docker Desktop or compatible Docker Engine.
- IBM MQ container image access (license acceptance required).
- The `mq-rest-admin-dev-environment` repository cloned as a sibling directory
  (`../mq-rest-admin-dev-environment`), or set `MQ_DEV_ENV_PATH` to its location.

## Configuration

The Docker Compose file in the `mq-rest-admin-dev-environment` repository runs two
queue managers on a shared network (`mq-dev-net`):

| Setting | QM1 | QM2 |
| --- | --- | --- |
| Queue manager | `QM1` | `QM2` |
| MQ listener port | `1414` | `1415` |
| REST API port | `9443` | `9444` |
| Container name | `mq-dev-qm1` | `mq-dev-qm2` |

!!! note "Port allocation"
    Each language repo exports unique ports so that multiple repos can run
    integration tests concurrently without conflicts.  The table below is the
    **single source of truth** for port assignments.

### Port allocation table

**Local development ports** (used by `scripts/dev/mq_start.sh`):

| Language | QM1 REST | QM2 REST | QM1 MQ | QM2 MQ |
|----------|----------|----------|--------|--------|
| Python   | 9443     | 9444     | 1414   | 1415   |
| Java     | 9453     | 9454     | 1424   | 1425   |
| Go       | 9463     | 9464     | 1434   | 1435   |
| Ruby     | 9473     | 9474     | 1444   | 1445   |
| Rust     | 9483     | 9484     | 1454   | 1455   |

**CI ports** (per-version matrix, each version adds +2 from the language
base):

| Language | V1 REST     | V2 REST     | V3 REST     | V1 MQ       | V2 MQ       | V3 MQ       |
|----------|-------------|-------------|-------------|-------------|-------------|-------------|
| Python   | 9447 / 9448 | 9449 / 9450 | 9451 / 9452 | 1418 / 1419 | 1420 / 1421 | 1422 / 1423 |
| Java     | 9453 / 9454 | 9455 / 9456 | 9457 / 9458 | 1426 / 1427 | 1428 / 1429 | 1430 / 1431 |
| Go       | 9465 / 9466 | 9467 / 9468 | —           | 1436 / 1437 | 1438 / 1439 | —           |
| Ruby     | 9475 / 9476 | 9477 / 9478 | 9479 / 9480 | 1446 / 1447 | 1448 / 1449 | 1450 / 1451 |
| Rust     | 9485 / 9486 | 9487 / 9488 | —           | 1456 / 1457 | 1458 / 1459 | —           |

Port ranges follow a **+10 offset** per language from the Python base (9443 /
1414).  CI versions start at the language base + 4 for REST and + 4 for MQ,
incrementing by 2 per additional version.

Both queue managers share the same credentials:

| Setting | Value |
| --- | --- |
| Admin credentials | `mqadmin` / `mqadmin` |
| Read-only credentials | `mqreader` / `mqreader` |
| QM1 REST base URL | `https://localhost:9443/ibmmq/rest/v2` |
| QM2 REST base URL | `https://localhost:9444/ibmmq/rest/v2` |

## Quick start

Start both queue managers:

```bash
./scripts/dev/mq_start.sh
```

Seed deterministic test objects on both QMs (all prefixed with `DEV.`):

```bash
./scripts/dev/mq_seed.sh
```

Verify REST-based MQSC responses on both QMs:

```bash
./scripts/dev/mq_verify.sh
```

## Seed objects

QM1 receives the full set of test objects (queues, channels, topics,
namelists, listeners, processes) plus cross-QM objects for communicating
with QM2. QM2 receives a smaller set of objects plus the reciprocal
cross-QM definitions.

The seed scripts are maintained in the `mq-rest-admin-dev-environment` repository
at `seed/base-qm1.mqsc` and `seed/base-qm2.mqsc`. Both use `REPLACE`
so they can be re-run at any time without side effects.

## Lifecycle scripts

| Script | Purpose |
| --- | --- |
| `scripts/dev/mq_start.sh` | Start both queue managers and wait for REST readiness |
| `scripts/dev/mq_seed.sh` | Seed deterministic test objects on both QMs |
| `scripts/dev/mq_verify.sh` | Verify REST-based MQSC responses on both QMs |
| `scripts/dev/mq_stop.sh` | Stop both queue managers |
| `scripts/dev/mq_reset.sh` | Reset to clean state (removes data volumes) |

## Environment variables

| Variable | Default | Description |
| --- | --- | --- |
| `MQ_REST_BASE_URL` | `https://localhost:9443/ibmmq/rest/v2` | QM1 REST API base URL |
| `MQ_REST_BASE_URL_QM2` | `https://localhost:9444/ibmmq/rest/v2` | QM2 REST API base URL |
| `MQ_ADMIN_USER` | `mqadmin` | Admin username |
| `MQ_ADMIN_PASSWORD` | `mqadmin` | Admin password |
| `MQ_IMAGE` | `icr.io/ibm-messaging/mq:latest` | Container image |
| `MQ_DEV_ENV_PATH` | `../mq-rest-admin-dev-environment` | Path to mq-rest-admin-dev-environment project |

## Gateway routing

The two-QM local setup supports gateway routing out of the box. The seed
scripts create QM aliases and sender/receiver channels so each queue manager
can route MQSC commands to the other.

### curl example

Query QM2's queue manager attributes through QM1's REST API:

```bash
curl -k -u mqadmin:mqadmin \
  -H "Content-Type: application/json" \
  -H "ibm-mq-rest-csrf-token: local" \
  -H "ibm-mq-rest-gateway-qmgr: QM1" \
  -d '{"type": "runCommandJSON", "command": "DISPLAY", "qualifier": "QMGR"}' \
  https://localhost:9443/ibmmq/rest/v2/admin/action/qmgr/QM2/mqsc
```

## Reset workflow

To return to a completely clean state (removes both data volumes):

```bash
./scripts/dev/mq_reset.sh
```

## Troubleshooting

If the REST API is not reachable, ensure the embedded web server is
binding to all interfaces:

```bash
docker compose -f ../mq-rest-admin-dev-environment/config/docker-compose.yml exec -T qm1 \
    setmqweb properties -k httpHost -v "*"
```

Then restart the containers and retry the verification workflow.
