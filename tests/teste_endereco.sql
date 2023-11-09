select
    pk_endereco,
    cidade_endereco
from {{ ref('dim_enderecos') }}
where pk_endereco = 1
group by pk_endereco, cidade_endereco
having not(cidade_endereco = 'Bothell')