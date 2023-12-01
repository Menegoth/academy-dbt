select
    sk_cliente,
    nome_loja
from {{ ref('dim_clientes') }}
where sk_cliente = 1
group by sk_cliente, nome_loja
having not(nome_loja = 'A Bike Store')