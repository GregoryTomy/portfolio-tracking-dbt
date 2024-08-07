{{ config(materialized="ephemeral") }}

with
    source_data as (
        select
            security_code as security_code,  -- TEXT
            security_name as security_name,  -- TEXT
            sector as sector_name,  -- TEXT
            industry as industry_name,  -- TEXT
            country as country_code,  -- TEXT
            exchange as exchange_code,  -- TEXT
            load_ts as load_ts,  -- TIMESTAMP_NTZ
            'seed.ABC_Bank_SECURITY_INFO' as record_source

        from {{ source("seeds", "ABC_Bank_SECURITY_INFO") }}
    ),

    default_record as (
        select
            '-1' as security_code,
            'Missing' as security_name,
            'Missing' as sector_name,
            'Missing' as industry_name,
            '-1' as country_code,
            '-1' as exchange_code,
            '2020-01-01' as load_ts_utc,
            'System.DefaultKey' as record_source
    ),

    with_default_records as (
        select *
        from source_data
        union all
        select *
        from default_record
    ),

    hashed as (
        select
            {{ dbt_utils.generate_surrogate_key(["security_code"]) }} as security_hkey,
            {{
                dbt_utils.generate_surrogate_key(
                    [
                        "security_code",
                        "security_name",
                        "sector_name",
                        "industry_name",
                        "country_code",
                        "exchange_code",
                    ]
                )
            }} as security_hdiff,
            * exclude load_ts,
            load_ts as load_ts_utc  -- renaming it in the hashed column
        from with_default_records
    )

select *
from hashed
