select
    pk_produto,
    nome_produto
from {{ ref('dim_produtos') }}
where pk_produto = 1
group by pk_produto, nome_produto
having not(nome_produto = 'Adjustable Race')