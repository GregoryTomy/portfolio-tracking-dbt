{% macro current_from_snapshot(snap_ref, output_load_ts=true) %}

    select
        * exclude (dbt_scd_id, dbt_valid_from, dbt_valid_to, dbt_updated_at)
        {% if output_load_ts %}
        , dbt_updated_at as snap_load_ts_utc
        {% endif %}
    from {{ snap_ref }}
    where dbt_valid_to is null

{% endmacro %}
