{{
    config(
        materialized='incremental',
        unique_key='operator_icao',
        incremental_strategy='merge',
        tags=['incremental']
    )
}}

WITH new_operators AS (
    SELECT DISTINCT
        REPLACE(TRIM(SPLIT_PART(raw_data, ',', 8)), '"', '') AS operator_icao,
        REPLACE(TRIM(SPLIT_PART(raw_data, ',', 9)), '"', '') AS operator_callsign,
        _loaded_at
    FROM {{ source('raw', 'aircraft_incremental_landing') }}
    WHERE operator_icao IS NOT NULL 
      AND operator_icao != ''

    {% if is_incremental() %}
      AND _loaded_at > (SELECT MAX(_loaded_at) FROM {{ this }})
    {% endif %}
)

SELECT * FROM new_operators