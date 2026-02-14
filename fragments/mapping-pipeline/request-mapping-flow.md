When mapping is enabled, request attributes are translated before sending to
the MQ REST API:

1. **Key mapping**: Each developer-friendly attribute name is looked up in the
   qualifier's request key map. If found, the key is replaced with the MQSC
   parameter name.

2. **Value mapping**: For attributes with enumerated values, the qualifier's
   request value map translates developer-friendly values to MQSC values
   (e.g. `"yes"` → `"YES"`).

3. **Key-value mapping**: Some attributes require both key and value to change
   simultaneously. The request key-value map handles cases where a single
   attribute expands to a different MQSC key+value pair (e.g.
   `channel_type="server_connection"` → `CHLTYPE("SVRCONN")`).
