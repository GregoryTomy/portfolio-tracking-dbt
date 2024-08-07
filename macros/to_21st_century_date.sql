/*
Fix for export from excel to csv error that produced dates with only two digits for the year.
Snowflake interpeted them as dates from the first century and not the 21st.
*/

{% macro to_21st_century_date(date_column_name) %}
case
    when {{date_column_name}} >= '0100-01-01'::date
        then {{date_column_name}}
        else dateadd(year, 2000, {{date_column_name}})
end

{% endmacro %}