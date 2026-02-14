Response attributes are translated after receiving the MQ REST response:

1. **Key mapping**: Each MQSC parameter name from the response is looked up in
   the qualifier's response key map. If found, the key is replaced with the
   developer-friendly name.

2. **Value mapping**: Enumerated MQSC values are translated to
   developer-friendly values via the response value map (e.g. `"YES"` →
   `"yes"`).

### Response parameter mapping

When the caller specifies response parameters (the list of attributes to
return), those names are also mapped from developer-friendly names to MQSC
before being sent in the request. This allows callers to request specific
attributes using their preferred naming convention.

Response parameter macros (like `CFCONLOS` for channel status) are recognized
and passed through without mapping.

### WHERE keyword mapping

The `where` parameter on DISPLAY methods accepts a filter expression like
`"current_depth GT 100"`. The first token (the keyword) is mapped from the
developer-friendly name to the MQSC name. The rest of the expression is passed
through unchanged.
