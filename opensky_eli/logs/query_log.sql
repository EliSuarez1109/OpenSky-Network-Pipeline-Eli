-- created_at: 2026-05-04T08:30:33.401533919+00:00
-- finished_at: 2026-05-04T08:30:33.727687817+00:00
-- elapsed: 326ms
-- outcome: success
-- dialect: snowflake
-- node_id: not available
-- query_id: 01c4239e-0108-c17e-0029-56e70017e6ba
-- desc: list_relations_in_parallel
SHOW OBJECTS IN SCHEMA "OPENSKY_DB"."RAW_MARTS" LIMIT 10000;
-- created_at: 2026-05-04T08:30:34.582242674+00:00
-- finished_at: 2026-05-04T08:30:34.955012519+00:00
-- elapsed: 372ms
-- outcome: success
-- dialect: snowflake
-- node_id: not available
-- query_id: 01c4239e-0108-c1f9-0029-56e700177696
-- desc: execute adapter call
show terse schemas in database OPENSKY_DB
    limit 10000
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "profile_name": "opensky_eli", "target_name": "dev"} */;
-- created_at: 2026-05-04T08:30:36.167822051+00:00
-- finished_at: 2026-05-04T08:30:37.915787845+00:00
-- elapsed: 1.7s
-- outcome: success
-- dialect: snowflake
-- node_id: model.opensky_eli.fact_aircraft_incremental
-- query_id: 01c4239e-0108-bc62-0029-56e700158756
-- desc: execute adapter call
create or replace transient  table OPENSKY_DB.RAW_marts.fact_aircraft_incremental
    
    
    
    as (

WITH raw_incremental AS (
    SELECT 
        -- Limpieza de comillas y separación de columnas similar a la Fuente A
        REPLACE(TRIM(SPLIT_PART(raw_data, ',', 1)), '"', '') AS icao24,
        REPLACE(TRIM(SPLIT_PART(raw_data, ',', 2)), '"', '') AS registration,
        REPLACE(TRIM(SPLIT_PART(raw_data, ',', 3)), '"', '') AS manufacturer,
        REPLACE(TRIM(SPLIT_PART(raw_data, ',', 4)), '"', '') AS model,
        REPLACE(TRIM(SPLIT_PART(raw_data, ',', 8)), '"', '') AS operator,
        
    
    TRY_TO_TIMESTAMP(
        NULLIF(REPLACE(TRIM(aws_load_date), '"', ''), '')
    )
 AS cleaned_aws_load_date,
        _loaded_at
        
    FROM OPENSKY_DB.RAW.aircraft_incremental_landing

    
)

SELECT * FROM raw_incremental
    )

/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.opensky_eli.fact_aircraft_incremental", "profile_name": "opensky_eli", "target_name": "dev"} */;
-- created_at: 2026-05-04T08:30:37.920897991+00:00
-- finished_at: 2026-05-04T08:30:38.239310868+00:00
-- elapsed: 318ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.opensky_eli.fact_aircraft_incremental
-- query_id: 01c4239e-0108-c1f9-0029-56e70017769a
-- desc: execute adapter call
drop view if exists OPENSKY_DB.RAW_marts.fact_aircraft_incremental__dbt_tmp cascade
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.opensky_eli.fact_aircraft_incremental", "profile_name": "opensky_eli", "target_name": "dev"} */;
