# process

Attribute mapping reference for the `process` qualifier.

Related MQSC commands: `ALTER PROCESS`, `DEFINE PROCESS`, `DELETE PROCESS`, `DISPLAY PROCESS`

## Request key map

| Friendly name | MQSC parameter |
| --- | --- |
| `application_id` | `APPLICID` |
| `application_type` | `APPLTYPE` |
| `command_scope` | `CMDSCOPE` |
| `description` | `DESCR` |
| `environment_data` | `ENVRDATA` |
| `ignore_state` | `IGNSTATE` |
| `like` | `LIKE` |
| `queue_sharing_group_disposition` | `QSGDISP` |
| `user_data` | `USERDATA` |

## Response key map

| MQSC parameter | Friendly name |
| --- | --- |
| `ALTDATE` | `alteration_date` |
| `ALTTIME` | `alteration_time` |
| `APPLICID` | `application_id` |
| `APPLTYPE` | `application_type` |
| `DESCR` | `description` |
| `ENVRDATA` | `environment_data` |
| `PROCESS` | `process_name` |
| `USERDATA` | `user_data` |

## Request key-value map

### noreplace

| Friendly value | MQSC key | MQSC value |
| --- | --- | --- |
| `yes` | `REPLACE` | `NO` |

### replace

| Friendly value | MQSC key | MQSC value |
| --- | --- | --- |
| `no` | `REPLACE` | `NO` |
| `yes` | `REPLACE` | `YES` |

---

*Auto-generated from `mapping-data.json` by `scripts/dev/generate_mapping_docs.py`.*
