{{ config(materialized="ephemeral") }}

with
    source_data as (
        select
            accountid as account_code,
            -- text
            symbol as security_code,
            -- text
            description as security_name,
            -- text
            exchange as exchange_code,
            -- text
            {{ to_21st_century_date("report_date") }} as report_date,
            -- date
            quantity,
            -- number
            cost_base,
            -- number
            position_value,
            -- number
            currency as currecy_code,
            -- text
            'source_data.abc_bank_position' as record_source
        from {{ source("abc_bank", "abc_bank_position") }}
    ),

    hashed as (
        select
            {{ dbt_utils.generate_surrogate_key(["account_code", "security_code"]) }}
            as position_hkey,

            {{
                dbt_utils.generate_surrogate_key(
                    [
                        "account_code",
                        "security_code",
                        "security_name",
                        "exchange_code",
                        "report_date",
                        "quantity",
                        "cost_base",
                        "position_value",
                        "currecy_code",
                    ]
                )
            }} as position_hdiff,
            *,
            '{{ run_started_at }}' as load_ts_utc
        from source_data
    )

select *
from hashed
