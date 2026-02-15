# namelist

Attribute mapping reference for the `namelist` qualifier.

Related MQSC commands: `ALTER NAMELIST`, `DEFINE NAMELIST`, `DELETE NAMELIST`, `DISPLAY NAMELIST`

## Request key map

| Friendly name | MQSC parameter |
| --- | --- |
| `command_scope` | `CMDSCOPE` |
| `description` | `DESCR` |
| `ignore_state` | `IGNSTATE` |
| `like` | `LIKE` |
| `namelist_type` | `NLTYPE` |
| `names` | `NAMES` |
| `queue_sharing_group_disposition` | `QSGDISP` |

## Response key map

| MQSC parameter | Friendly name |
| --- | --- |
| `ALTDATE` | `alteration_date` |
| `ALTTIME` | `alteration_time` |
| `DESCR` | `description` |
| `NAMCOUNT` | `name_count` |
| `NAMELIST` | `namelist_name` |
| `NAMES` | `names` |

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
