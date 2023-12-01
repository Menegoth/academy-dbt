with 
    fct_vendas as (
        select
            sk_venda,
            fk_cliente,
            fk_endereco,
            fk_produto,
            total_venda,
            preco_unidade,
            disconto_unidade,
            quantidade_vendadetalhe,
            tipo_cartao,
            nome_razao,
            data_venda,
            status_venda
        from {{ ref('fct_vendas') }}
    ),

    dim_produtos as (
        select
            sk_produto,
            fk_produto,
            nome_produto
        from {{ ref('dim_produtos') }}
    ),

    dim_clientes as (
        select
            sk_cliente,
            fk_cliente,
            nome_loja
        from {{ ref('dim_clientes') }}
    ),

    dim_enderecos as (
        select 
            sk_endereco,
            fk_endereco,
            cidade_endereco,
            nome_estado,
            nome_pais
        from {{ ref('dim_enderecos') }}
    ),

    join_tabelas as (
        select
            --VENDAS
            fct_vendas.sk_venda,
            --fct_vendas.id_produto,
            --fct_vendas.id_cliente,
            --fct_vendas.id_endereco,
            fct_vendas.total_venda,
            fct_vendas.preco_unidade,
            fct_vendas.disconto_unidade,
            fct_vendas.quantidade_vendadetalhe,
            fct_vendas.tipo_cartao,
            fct_vendas.nome_razao,
            fct_vendas.data_venda,
            fct_vendas.status_venda,
            --PRODUTOS
            dim_produtos.sk_produto,
            dim_produtos.fk_produto,
            dim_produtos.nome_produto,
            --CLIENTES
            dim_clientes.sk_cliente,
            dim_clientes.fk_cliente,
            dim_clientes.nome_loja,
            --ENDERECOS
            dim_enderecos.sk_endereco,
            dim_enderecos.fk_endereco,
            dim_enderecos.cidade_endereco,
            dim_enderecos.nome_estado,
            dim_enderecos.nome_pais 
        from fct_vendas
        join dim_produtos on
            fct_vendas.fk_produto = dim_produtos.fk_produto
        join dim_clientes on   
            fct_vendas.fk_cliente = dim_clientes.fk_cliente
        join dim_enderecos on
            fct_vendas.fk_endereco = dim_enderecos.fk_endereco
    ),

    transformacoes as (
        select
            (preco_unidade - (preco_unidade * disconto_unidade)) * quantidade_vendadetalhe as ticket,
            *
        from join_tabelas
    )

select * from transformacoes