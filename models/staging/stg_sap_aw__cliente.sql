with
    fonte_clientes as (
        select
            cast(customerid as int) as id_cliente,
            cast(storeid as int) as id_loja
        from {{ source("sap_adw", 'customer') }}
    )

select * 
from fonte_clientes