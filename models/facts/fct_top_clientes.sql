with
    dim_vendas as (
        select
            pk_venda,
            id_cliente,
            id_endereco,
            id_produto,
            total_venda,
            tipo_cartao,
            nome_razao,
            data_venda,
            status_venda
        from {{ ref('dim_vendas') }}
    ),

    dim_produtos as (
        select
            pk_produto,
            id_produto,
            nome_produto
        from {{ ref('dim_produtos') }}
    ),

    dim_clientes as (
        select
            pk_cliente,
            id_cliente,
            nome_loja
        from {{ ref('dim_clientes') }}
    ),

    dim_enderecos as (
        select
            pk_endereco,
            id_endereco,
            cidade_endereco,
            nome_estado,
            nome_pais
        from {{ ref('dim_enderecos') }}
    ),

    join_tabelas as (
        select
            --VENDAS
            dim_vendas.pk_venda,
            --dim_vendas.id_cliente,
            --dim_vendas.id_endereco,
            --dim_vendas.id_produto,
            dim_vendas.total_venda,
            dim_vendas.tipo_cartao,
            dim_vendas.nome_razao,
            dim_vendas.data_venda,
            dim_vendas.status_venda,
            --PRODUTOS
            dim_produtos.pk_produto,
            dim_produtos.id_produto,
            dim_produtos.nome_produto,
            --CLIENTES
            dim_clientes.pk_cliente,
            dim_clientes.id_cliente,
            dim_clientes.nome_loja,
            --ENDERECOS
            dim_enderecos.pk_endereco,
            dim_enderecos.id_endereco,
            dim_enderecos.cidade_endereco,
            dim_enderecos.nome_estado,
            dim_enderecos.nome_pais
        from dim_vendas
        join dim_produtos on
            dim_vendas.id_produto = dim_produtos.id_produto
        join dim_clientes on
            dim_vendas.id_cliente = dim_clientes.id_cliente
        join dim_enderecos on
            dim_vendas.id_endereco = dim_enderecos.id_endereco
    )

select *
from dim_clientes
where id_cliente = 11000