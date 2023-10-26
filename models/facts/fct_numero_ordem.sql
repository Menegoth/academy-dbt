with 
    dim_vendas as (
        select
            pk_venda,
            id_produto,
            id_cliente,
            id_endereco,
            total_venda,
            quantidade_vendadetalhe,
            tipo_cartao,
            nome_razao,
            data_venda,
            status_venda
        from {{ ref('dim_vendas') }}
        where nome_razao is not null
    ),

    dim_produtos as (
        select
            *
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
            --dim_vendas.id_produto,
            --dim_vendas.id_cliente,
            --dim_vendas.id_endereco,
            dim_vendas.total_venda,
            dim_vendas.quantidade_vendadetalhe,
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
        left join dim_produtos on
            dim_vendas.id_produto = dim_produtos.id_produto
        left join dim_clientes on   
            dim_vendas.id_cliente = dim_clientes.id_cliente
        left join dim_enderecos on
            dim_vendas.id_endereco = dim_enderecos.id_endereco
    ),

    transformacoes as (
        select
            count(*) as numero_de_pedidos,
            sum(quantidade_vendadetalhe) as total_unidade,
            sum(total_venda) as total_valor,
            nome_produto,
            tipo_cartao,
            nome_razao,
            data_venda,
            nome_loja,
            status_venda,
            cidade_endereco,
            nome_estado,
            nome_pais
        from join_tabelas
        group by
            nome_produto,
            tipo_cartao,
            nome_razao,
            data_venda,
            nome_loja,
            status_venda,
            cidade_endereco,
            nome_estado,
            nome_pais
    )

select * from transformacoes