with 
    stg_enderecos as (
        select *
        from {{ ref("stg_sap_aw__enderecos") }}
    ),

    stg_estados as (
        select *
        from {{ ref("stg_sap_aw__estados") }}
    ),

    stg_paises as (
        select *
        from {{ ref("stg_sap_aw__pais") }}
    ),

    join_tabelas as (
        select 
            --ENDERECOS
            stg_enderecos.id_endereco,
            stg_enderecos.cidade_endereco,
            --stg_enderecos.id_estado,
            --ESTADOS
            stg_estados.id_estado,
            stg_estados.nome_estado,
            --stg_estados.codigo_pais,
            --PAISES
            stg_paises.codigo_pais,
            stg_paises.nome_pais
        from stg_enderecos
        left join stg_estados on
            stg_enderecos.id_estado = stg_estados.id_estado
        left join stg_paises on 
            stg_estados.codigo_pais = stg_paises.codigo_pais
    ),

    criar_chave as (
        select
            row_number() over(order by id_endereco) as pk_endereco,
            *
        from join_tabelas   
    )

select * 
from criar_chave