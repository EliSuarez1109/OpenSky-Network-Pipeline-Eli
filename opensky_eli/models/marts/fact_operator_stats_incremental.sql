{{
    config(
        materialized='incremental',
        unique_key='operator_icao',
        incremental_strategy='merge',
        tags=['incremental']
    )
}}

WITH daily_metrics AS (
    SELECT 
        REPLACE(TRIM(SPLIT_PART(raw_data, ',', 8)), '"', '') AS operator_icao,
        COUNT(DISTINCT REPLACE(TRIM(SPLIT_PART(raw_data, ',', 1)), '"', '')) AS total_aircrafts,
        MAX(_loaded_at) as last_update,
        CURRENT_TIMESTAMP() as _loaded_at
    FROM {{ source('raw', 'aircraft_incremental_landing') }}
    WHERE operator_icao IS NOT NULL AND operator_icao != ''

    {% if is_incremental() %}
      AND _loaded_at > (SELECT MAX(last_update) FROM {{ this }})
    {% endif %}

    GROUP BY 1
)

SELECT * FROM daily_metrics