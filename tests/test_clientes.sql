select
    pk_cliente,
    nome_loja
from {{ ref('dim_clientes') }}
where pk_cliente = 1
group by pk_cliente, nome_loja
having not(nome_loja = 'A Bike Store')