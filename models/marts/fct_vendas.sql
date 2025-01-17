with
    stg_vendacabecalho as (
        select *
        from {{ ref('stg_sap_aw__vendacabecalho') }}
    ),

    stg_vendadetalhe as (
        select *
        from {{ ref('stg_sap_aw__vendadetalhe') }}
    ),

    stg_cartao as (
        select *
        from {{ ref('stg_sap_aw__cartao') }}
    ),

    stg_vendarazaocabecalho as (
        select *
        from {{ ref('stg_sap_aw__vendarazaocabecalho') }}
    ),

    stg_razao as (
        select *
        from {{ ref('stg_sap_aw__razao') }}
    ),

    join_tabelas as (
        select
            --VENDACABECALHO,
            stg_vendacabecalho.id_venda as fk_venda,
            stg_vendacabecalho.data_venda,
            stg_vendacabecalho.id_cliente as fk_cliente,
            stg_vendacabecalho.id_endereco as fk_endereco,
            stg_vendacabecalho.status_venda,
            --stg_vendacabecalho.id_cartao,
            stg_vendacabecalho.total_venda,
            --VENDADETALHE,
            stg_vendadetalhe.id_vendadetalhe as fk_vendadetalhe,
            --stg_vendadetalhe.id_venda,
            stg_vendadetalhe.quantidade_vendadetalhe,
            stg_vendadetalhe.id_produto as fk_produto,
            stg_vendadetalhe.preco_unidade,
            stg_vendadetalhe.disconto_unidade,
            --CARTAO,
            stg_cartao.id_cartao as fk_cartao,
            stg_cartao.tipo_cartao,
            --VENDARAZAOCABECALHO,
            --stg_vendarazaocabecalho.id_venda,
            --stg_vendarazaocabecalho.id_razao,
            --RAZAO,
            stg_razao.id_razao as fk_razao,
            stg_razao.nome_razao
        from stg_vendacabecalho
        left join stg_vendadetalhe on
            stg_vendacabecalho.id_venda = stg_vendadetalhe.id_venda
        left join stg_cartao on
            stg_vendacabecalho.id_cartao = stg_cartao.id_cartao
        left join stg_vendarazaocabecalho on
            stg_vendacabecalho.id_venda = stg_vendarazaocabecalho.id_venda
        left join stg_razao on
            stg_vendarazaocabecalho.id_razao = stg_razao.id_razao
    ),

    criar_chave as (
        select
            row_number() over(order by cast((cast(fk_venda as string) || cast(fk_produto as string)) as int)) as sk_venda,
            *
        from join_tabelas
    )

    

select *
from criar_chave