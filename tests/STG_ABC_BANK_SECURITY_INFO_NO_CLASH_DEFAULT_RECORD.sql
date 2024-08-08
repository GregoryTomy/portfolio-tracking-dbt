/*
Creating a singular test for learning purposes.
This tes will check that the security code we have used for 
our default record (-1) does not clash with a value coming 
from the data source.
*/

select *
from {{ref("STG_ABC_BANK_SECURITY_INFO")}}
where security_code = '-1'
    and record_source != 'System.DefaultKey'