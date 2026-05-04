{{
    config(
        materialized='incremental',
        unique_key='icao24',
        on_schema_change='fail',
        tags=['incremental']
    )
}}

WITH raw_incremental AS (
    SELECT 
        -- Limpieza de comillas y separación de columnas similar a la Fuente A
        REPLACE(TRIM(SPLIT_PART(raw_data, ',', 1)), '"', '') AS icao24,
        REPLACE(TRIM(SPLIT_PART(raw_data, ',', 2)), '"', '') AS registration,
        REPLACE(TRIM(SPLIT_PART(raw_data, ',', 3)), '"', '') AS manufacturer,
        REPLACE(TRIM(SPLIT_PART(raw_data, ',', 4)), '"', '') AS model,
        REPLACE(TRIM(SPLIT_PART(raw_data, ',', 8)), '"', '') AS operator,
        {{ clear_timestamp('aws_load_date') }} AS cleaned_aws_load_date,
        _loaded_at
        
    FROM {{ source('raw', 'aircraft_incremental_landing') }}

    {% if is_incremental() %}
    WHERE _loaded_at > {{ get_max_loaded_date(this) }}
    {% endif %}
)

SELECT * FROM raw_incremental