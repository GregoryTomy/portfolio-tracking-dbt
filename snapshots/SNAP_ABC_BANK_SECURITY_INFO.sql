{% snapshot SNAP_ABC_BANK_SECURITY_INFO %}

    {{
        config(
            unique_key="security_hkey",
            strategy="check",
            check_cols=["security_hdiff"],
        )
    }}

    select *
    from {{ ref("STG_ABC_BANK_SECURITY_INFO") }}

{% endsnapshot %}
