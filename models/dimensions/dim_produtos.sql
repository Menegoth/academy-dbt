with
    stg_produtos as (
        select *
        from {{ ref('stg_sap_aw__produtos') }}
    ),

    criar_chave as (
        select
            row_number() over(order by id_produto) as pk_produto,
            *
        from stg_produtos
    )

select * 
from criar_chave