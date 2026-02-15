# clusqmgr

Attribute mapping reference for the `clusqmgr` qualifier.

Related MQSC commands: `DISPLAY CLUSQMGR`

## Request key map

| Friendly name | MQSC parameter |
| --- | --- |
| `channel_name` | `CHANNEL` |
| `cluster_name` | `CLUSTER` |
| `command_scope` | `CMDSCOPE` |

## Response key map

| MQSC parameter | Friendly name |
| --- | --- |
| `CLUSDATE` | `cluster_date` |
| `CLUSTIME` | `cluster_time` |
| `DEFTYPE` | `definition_type` |
| `QMID` | `queue_manager_id` |
| `QMTYPE` | `queue_manager_type` |
| `STATUS` | `channel_status` |
| `SUSPEND` | `suspend` |
| `VERSION` | `version` |
| `XMITQ` | `transmission_queue_name` |

---

*Auto-generated from `mapping-data.json` by `scripts/dev/generate_mapping_docs.py`.*
