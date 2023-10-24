with
    fonta_vendadetalhe as (
        select
        cast(salesorderdetailid as int) as id_vendadetalhe,
        cast(salesorderid as int) as id_venda,
        cast(orderqty as int) as quantidade_vendadetalhe,
        cast(productid as int) as id_produto,
        cast(unitprice as decimal) as preco_unidade,
        cast(unitpricediscount as decimal) as disconto_unidade,
        from {{ source("sap_adw", 'salesorderdetail') }}
    )

select *
from fonta_vendadetalhe