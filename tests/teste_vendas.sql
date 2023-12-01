select
    sk_venda,
    fk_cliente
from {{ ref('fct_vendas') }}
where sk_venda = 1
group by sk_venda, fk_cliente
having not(fk_cliente = 29825)