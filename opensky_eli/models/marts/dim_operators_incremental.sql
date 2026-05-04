{{
    config(
        materialized='incremental',
        unique_key='operator_icao',
        on_schema_change='sync_all_columns'
    )
}}

WITH raw_data_extracted AS (
    SELECT 
        -- Extraemos el operador (campo 8)
        NULLIF(REPLACE(TRIM(SPLIT_PART(raw_data, ',', 8)), '"', ''), '') AS operator_icao,
        -- Extraemos el fabricante (campo 3) como ejemplo de atributo
        NULLIF(REPLACE(TRIM(SPLIT_PART(raw_data, ',', 3)), '"', ''), '') AS manufacturer,
        _loaded_at
    FROM {{ source('raw', 'aircraft_incremental_landing') }}
),

ordered_records AS (
    SELECT 
        operator_icao,
        manufacturer,
        _loaded_at,
        -- Creamos un ranking: si hay 100 filas con el mismo "2026", 
        -- solo la más reciente recibirá el número 1.
        ROW_NUMBER() OVER (
            PARTITION BY operator_icao 
            ORDER BY _loaded_at DESC
        ) AS row_num
    FROM raw_data_extracted
    WHERE operator_icao IS NOT NULL
)

SELECT 
    operator_icao,
    manufacturer,
    _loaded_at
FROM ordered_records
WHERE row_num = 1 -- ESTO ELIMINA LOS DUPLICADOS

{% if is_incremental() %}
    -- Filtro incremental para eficiencia
    AND _loaded_at > (SELECT MAX(_loaded_at) FROM {{ this }})
{% endif %}