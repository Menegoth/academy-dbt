select
    sk_produto,
    nome_produto
from {{ ref('dim_produtos') }}
where sk_produto = 1
group by sk_produto, nome_produto
having not(nome_produto = 'Adjustable Race')