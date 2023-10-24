with
    fonte_estados as (
        select
            cast(stateprovinceid as int) as id_estado,
            cast(name as string) as nome_estado,
            cast(countryregioncode as string) as codigo_pais,
        from {{ source('sap_adw', 'stateprovince') }}
    )

select *
from fonte_estados
    