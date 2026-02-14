The ensure pattern provides idempotent, declarative object management. Instead
of separately checking whether an object exists and then deciding whether to
create or modify it, a single ensure call handles the entire lifecycle:

1. **DISPLAY** the target object to check current state.
2. If the object **does not exist**: **DEFINE** it with the specified attributes.
3. If the object **exists but differs**: **ALTER** it to match the desired state.
4. If the object **already matches**: no-op.

The return value indicates which action was taken:

| Result | Meaning |
| --- | --- |
| Created | Object did not exist; DEFINE was issued |
| Altered | Object existed but attributes differed; ALTER was issued |
| Unchanged | Object already matched the desired state |

### Queue manager variant

Queue manager objects are singletons — they always exist and cannot be created
or deleted. The queue manager ensure method only supports ALTER (or no-op) and
never issues DEFINE.

### Idempotency guarantee

Ensure methods are safe to call repeatedly. Running the same ensure call twice
in succession always produces `Unchanged` on the second invocation. This makes
them suitable for configuration-as-code workflows where the desired state is
declared and applied on every run.
