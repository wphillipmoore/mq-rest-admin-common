# pubsub

Attribute mapping reference for the `pubsub` qualifier.

Related MQSC commands: `DISPLAY PUBSUB`

## Request key map

| Friendly name | MQSC parameter |
| --- | --- |
| `command_scope` | `CMDSCOPE` |
| `type` | `TYPE` |

## Response key map

| MQSC parameter | Friendly name |
| --- | --- |
| `QMNAME` | `queue_manager_name` |
| `STATUS` | `status` |
| `SUBCOUNT` | `subscription_count` |
| `TPCOUNT` | `topic_node_count` |

---

*Auto-generated from `mapping-data.json` by `scripts/dev/generate_mapping_docs.py`.*
