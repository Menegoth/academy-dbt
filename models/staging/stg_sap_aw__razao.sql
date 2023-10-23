with
    fonte_razoes as (
        select
            cast(salesreasonid as int) as id_razao,
            cast(name as string) as nome_razao
        from {{ source('sap_adw', 'salesreason') }}
    )

select *
from fonte_razoes