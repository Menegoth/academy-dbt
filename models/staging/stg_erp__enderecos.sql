with
    fonte_enderecos as (
        select
            cast(addressid as int) as id_endereco,
            cast(city as string) as cidade_endereco,
            cast(stateprovinceid as int) as estado_endereco
        from {{ source('sap_adw', 'address') }}
    )

select *
from fonte_enderecos