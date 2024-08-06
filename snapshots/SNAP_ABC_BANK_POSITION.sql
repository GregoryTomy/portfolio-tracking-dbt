{% snapshot SNAP_ABC_BANK_POSITION %}

    /*
We have used the check strategy as we do not trust the REPORT_DATE column
to work as a good timestamp for the timestamp strategy.

We have also enabled tracking of deletions from the source.  
*/
    {{
        config(
            unique_key="position_hkey",
            strategy="check",
            check_cols=["position_hdiff"],
            invalidate_hard_deletes=True,
        )
    }}
›
    select *
    from {{ ref("STG_ABC_BANK_POSITION") }}

{% endsnapshot %}
