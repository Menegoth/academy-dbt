select
    sk_endereco,
    cidade_endereco
from {{ ref('dim_enderecos') }}
where sk_endereco = 1
group by sk_endereco, cidade_endereco
having not(cidade_endereco = 'Bothell')