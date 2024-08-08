/*
This generic test checks if there is a hash collision - two different sets 
of values producing the same hash.

hash_fields: all the fields used to build the hash.
*/

-- macro supporting the no_hash_collisions test
{% macro as_sql_list(hashed_fields_list) %}
    {{ hashed_fields_list | join(", ") }}
{% endmacro %}

{% test no_hash_collisions(model, column_name, hash_fields) %}

    with
        all_tuples as (
            select distinct {{ column_name }} as hash, {{ hash_fields }}
            from {{ model }}
        ),

        validation_errors as (
            select hash, count(*) from all_tuples group by hash having count(*) > 1
        )

    select *
    from validation_errors
{% endtest %}
