
-- test data has, in each row, input data for the macro to be tested and the expected result
with 
test_data as (
    select 
        '0021-09-23'::date as source_date,
        '2021-09-23'::date as expected_date
    union
    select '1021-09-24', '1021-09-24'
    union
    select '2021-09-25', '2021-09-25'
    union
    select '-0021-09-26', '1979-09-26'
)

select
    {{to_21st_century_date('source_date')}} as ok_date,
    expected_date,
    ok_date = expected_date as matching
from test_data
where not matching
