with
    stg_produtos as (
        select 
        id_produto as fk_produto,
        nome_produto
        from {{ ref('stg_sap_aw__produtos') }}
    ),

    criar_chave as (
        select
            row_number() over(order by fk_produto) as sk_produto,
            *
        from stg_produtos
    )

select * 
from criar_chave