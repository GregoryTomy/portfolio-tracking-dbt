with
    current_from_snapshot as (
        {{ current_from_snapshot(snap_ref=ref("SNAP_ABC_BANK_SECURITY_INFO"))}}
    )

select *
from current_from_snapshot
