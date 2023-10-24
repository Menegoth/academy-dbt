with 
    fonte_razaocabecalho as (
        select
            cast(salesorderid as int) as id_venda,
            cast(salesreasonid as int) as id_razao
        from {{ source('sap_adw', 'salesorderheadersalesreason') }}
    )

select * 
from fonte_razaocabecalho