select
    accountid       as account_code,    -- text
    symbol          as security_code,   -- text
    description     as security_name,   -- text
    exchange        as exchange_code,   -- text
    report_date     as report_date,     -- date
    quantity        as quantity,        -- number
    cost_base       as cost_base,       -- number
    position_value  as position_value,  -- number
    currency        as currecy_code     -- text

from {{source("abc_bank", "abc_bank_position")}}