select 
    sum(ticket)

from {{ ref('fct_final') }}
where EXTRACT(YEAR FROM data_venda) = 2011
having not(sum(ticket) = 15701093.062954)