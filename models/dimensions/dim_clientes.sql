with 
    stg_clientes as (
        select *
        from {{ ref('stg_sap_aw__cliente') }}
    ),

    stg_lojas as (
        select *
        from {{ ref('stg_sap_aw__loja') }}
    ),

    join_tabelas as (
        select
            --CLIENTE
            stg_clientes.id_cliente,
            --stg_clientes.id_loja,
            --LOJA
            stg_lojas.id_loja,
            stg_lojas.nome_loja,
        from stg_clientes
        left join stg_lojas on
            stg_clientes.id_loja = stg_lojas.id_loja
    ),
    
    criar_chave as (
        select
            row_number() over(order by id_cliente) as pk_cliente,
            *
        from join_tabelas
    )

select *
from criar_chave

