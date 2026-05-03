-- created_at: 2026-05-03T21:55:42.347309760+00:00
-- finished_at: 2026-05-03T21:55:42.657834277+00:00
-- elapsed: 310ms
-- outcome: error
-- error vendor code: 2043
-- error message: Internal: [Snowflake] 002043 (02000): SQL compilation error:
Object does not exist, or operation cannot be performed.
-- dialect: snowflake
-- node_id: not available
-- query_id: not available
-- desc: list_relations_in_parallel
SHOW OBJECTS IN SCHEMA "OPENSKY_DB"."RAW_MARTS" LIMIT 10000;
-- created_at: 2026-05-03T21:55:43.457498970+00:00
-- finished_at: 2026-05-03T21:55:43.916624362+00:00
-- elapsed: 459ms
-- outcome: success
-- dialect: snowflake
-- node_id: not available
-- query_id: 01c42123-0108-bc7e-0029-56e70015d84e
-- desc: execute adapter call
show terse schemas in database OPENSKY_DB
    limit 10000
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "profile_name": "opensky_eli", "target_name": "dev"} */;
-- created_at: 2026-05-03T21:55:43.929537238+00:00
-- finished_at: 2026-05-03T21:55:44.296314017+00:00
-- elapsed: 366ms
-- outcome: success
-- dialect: snowflake
-- node_id: not available
-- query_id: 01c42123-0108-bc62-0029-56e7001585e6
-- desc: execute adapter call
create schema if not exists OPENSKY_DB.RAW_marts
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "profile_name": "opensky_eli", "target_name": "dev"} */;
-- created_at: 2026-05-03T21:55:46.070263577+00:00
-- finished_at: 2026-05-03T21:55:47.266658576+00:00
-- elapsed: 1.2s
-- outcome: success
-- dialect: snowflake
-- node_id: model.opensky_eli.fact_aircraft_incremental
-- query_id: 01c42123-0108-bc83-0029-56e70015c512
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
        aws_load_date,
        _loaded_at
        
    FROM OPENSKY_DB.RAW.aircraft_incremental_landing

    
)

SELECT * FROM raw_incremental
    )

/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.opensky_eli.fact_aircraft_incremental", "profile_name": "opensky_eli", "target_name": "dev"} */;
-- created_at: 2026-05-03T21:55:47.271699674+00:00
-- finished_at: 2026-05-03T21:55:47.578957311+00:00
-- elapsed: 307ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.opensky_eli.fact_aircraft_incremental
-- query_id: 01c42123-0108-baee-0029-56e70015479e
-- desc: execute adapter call
drop view if exists OPENSKY_DB.RAW_marts.fact_aircraft_incremental__dbt_tmp cascade
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.opensky_eli.fact_aircraft_incremental", "profile_name": "opensky_eli", "target_name": "dev"} */;
