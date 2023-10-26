with 
    dim_vendas as (
        select
            pk_venda,
            id_endereco,
            id_produto,
            preco_unidade,
            disconto_unidade,
            quantidade_vendadetalhe,
            data_venda
        from {{ ref('dim_vendas') }}
    ),

    dim_enderecos as (
        select
            pk_endereco,
            id_endereco,
            cidade_endereco,
            nome_estado,
            nome_pais
        from {{ ref("dim_enderecos") }}
    ),

    dim_produtos as (
        select
            pk_produto,
            id_produto,
            nome_produto
        from {{ ref("dim_produtos") }}
    ),

    join_tabelas as (
        select 
            --VENDAS
            dim_vendas.pk_venda,
            --dim_vendas.id_endereco,
            --dim_vendas.id_produto,
            dim_vendas.preco_unidade,
            dim_vendas.disconto_unidade,
            dim_vendas.quantidade_vendadetalhe,
            dim_vendas.data_venda,
            --ENDERECOS
            dim_enderecos.pk_endereco,
            dim_enderecos.id_endereco,
            dim_enderecos.cidade_endereco,
            dim_enderecos.nome_estado,
            dim_enderecos.nome_pais,
            --PRODUTOS
            dim_produtos.pk_produto,
            dim_produtos.id_produto,
            dim_produtos.nome_produto,
            from dim_vendas
            join dim_enderecos on
                dim_vendas.id_endereco = dim_enderecos.id_endereco
            join dim_produtos on
                dim_vendas.id_produto = dim_produtos.id_produto
    ),

    transformacoes as (
        select
            (preco_unidade - (preco_unidade * disconto_unidade)) * quantidade_vendadetalhe as ticket,
            (select extract(month from data_venda)) as mes,
            (select extract(year from data_venda)) as ano,
            *
        from join_tabelas
    ),

    ticket_medio as (
        select
            AVG(ticket) as ticket_medio,
            nome_produto,
            mes,
            ano,
            cidade_endereco,
            nome_estado,
            nome_pais
        from transformacoes
        group by
            nome_produto,
            mes,
            ano,
            cidade_endereco,
            nome_estado,
            nome_pais
        order by ticket_medio DESC
    )

select 
*
from ticket_medio