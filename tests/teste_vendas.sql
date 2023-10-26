select
    pk_venda,
    id_cliente
from {{ ref('dim_vendas') }}
where pk_venda = 1
group by pk_venda, id_cliente
having not(id_cliente = 29825)