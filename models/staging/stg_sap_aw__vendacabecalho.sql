with 
    fonte_vendacabecalho as (
        select 
            cast(salesorderid as int) as id_venda,
            cast(DATE(orderdate) as date) as data_venda,
            cast(customerid as int) as id_cliente,
            cast(billtoaddressid as int) as id_endereco,
            cast(creditcardid as int) as id_cartao,
            cast(totaldue as decimal) as total_venda,
            cast(status as int) as status_venda
        from {{ source("sap_adw", 'salesorderheader') }}
    )

select *
from fonte_vendacabecalho