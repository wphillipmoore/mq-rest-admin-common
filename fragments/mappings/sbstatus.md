# sbstatus

Attribute mapping reference for the `sbstatus` qualifier.

Related MQSC commands: `DISPLAY SBSTATUS`

## Request key map

| Friendly name | MQSC parameter |
| --- | --- |
| `command_scope` | `CMDSCOPE` |
| `durable` | `DURABLE` |
| `subscription_type` | `SUBTYPE` |

## Response key map

| MQSC parameter | Friendly name |
| --- | --- |
| `ACTCONN` | `active_connection` |
| `DURABLE` | `durable` |
| `LMSGDATE` | `last_message_date` |
| `LMSGTIME` | `last_message_time` |
| `MCASTREL` | `multicast_reliability_indicator` |
| `NUMMSGS` | `number_of_messages` |
| `RESMDATE` | `resume_date` |
| `RESMTIME` | `resume_time` |
| `SUBID` | `subscription_id` |
| `SUBTYPE` | `subscription_type` |
| `SUBUSER` | `subscription_user_id` |
| `TOPICSTR` | `topic_string` |

---

*Auto-generated from `mapping-data.json` by `scripts/dev/generate_mapping_docs.py`.*
