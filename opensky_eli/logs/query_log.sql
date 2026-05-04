-- created_at: 2026-05-04T07:26:41.455987005+00:00
-- finished_at: 2026-05-04T07:26:41.828325445+00:00
-- elapsed: 372ms
-- outcome: success
-- dialect: snowflake
-- node_id: not available
-- query_id: 01c4235e-0108-c1f1-0029-56e7001755f6
-- desc: list_relations_in_parallel
SHOW OBJECTS IN SCHEMA "OPENSKY_DB"."RAW_MARTS" LIMIT 10000;
-- created_at: 2026-05-04T07:26:42.559882817+00:00
-- finished_at: 2026-05-04T07:26:42.900005003+00:00
-- elapsed: 340ms
-- outcome: success
-- dialect: snowflake
-- node_id: not available
-- query_id: 01c4235e-0108-c1f9-0029-56e7001775f6
-- desc: execute adapter call
show terse schemas in database OPENSKY_DB
    limit 10000
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "profile_name": "opensky_eli", "target_name": "dev"} */;
-- created_at: 2026-05-04T07:26:44.124201244+00:00
-- finished_at: 2026-05-04T07:26:44.850203192+00:00
-- elapsed: 726ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.opensky_eli.fact_aircraft_incremental
-- query_id: 01c4235e-0108-bc85-0029-56e70015e612
-- desc: execute adapter call
create or replace  temporary view OPENSKY_DB.RAW_marts.fact_aircraft_incremental__dbt_tmp
  
  
  
  
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

    
    -- La magia incremental: solo trae registros cargados después del último proceso
    WHERE _loaded_at > (SELECT MAX(_loaded_at) FROM OPENSKY_DB.RAW_marts.fact_aircraft_incremental)
    
)

SELECT * FROM raw_incremental
  )
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.opensky_eli.fact_aircraft_incremental", "profile_name": "opensky_eli", "target_name": "dev"} */;
-- created_at: 2026-05-04T07:26:44.853790310+00:00
-- finished_at: 2026-05-04T07:26:45.119413687+00:00
-- elapsed: 265ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.opensky_eli.fact_aircraft_incremental
-- query_id: 01c4235e-0108-c1f9-0029-56e7001775fa
-- desc: execute adapter call
describe table OPENSKY_DB.RAW_marts.fact_aircraft_incremental__dbt_tmp
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.opensky_eli.fact_aircraft_incremental", "profile_name": "opensky_eli", "target_name": "dev"} */;
-- created_at: 2026-05-04T07:26:45.124520864+00:00
-- finished_at: 2026-05-04T07:26:45.420601165+00:00
-- elapsed: 296ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.opensky_eli.fact_aircraft_incremental
-- query_id: 01c4235e-0108-c23b-0029-56e70017b612
-- desc: execute adapter call
describe table OPENSKY_DB.RAW_marts.fact_aircraft_incremental
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.opensky_eli.fact_aircraft_incremental", "profile_name": "opensky_eli", "target_name": "dev"} */;
-- created_at: 2026-05-04T07:26:45.424012412+00:00
-- finished_at: 2026-05-04T07:26:45.704140453+00:00
-- elapsed: 280ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.opensky_eli.fact_aircraft_incremental
-- query_id: 01c4235e-0108-bc7e-0029-56e70015d936
-- desc: execute adapter call
describe table OPENSKY_DB.RAW_marts.fact_aircraft_incremental__dbt_tmp
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.opensky_eli.fact_aircraft_incremental", "profile_name": "opensky_eli", "target_name": "dev"} */;
-- created_at: 2026-05-04T07:26:45.707270604+00:00
-- finished_at: 2026-05-04T07:26:45.970598722+00:00
-- elapsed: 263ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.opensky_eli.fact_aircraft_incremental
-- query_id: 01c4235e-0108-bc83-0029-56e70015c5fa
-- desc: execute adapter call
describe table "OPENSKY_DB"."RAW_MARTS"."FACT_AIRCRAFT_INCREMENTAL"
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.opensky_eli.fact_aircraft_incremental", "profile_name": "opensky_eli", "target_name": "dev"} */;
-- created_at: 2026-05-04T07:26:45.982879489+00:00
-- finished_at: 2026-05-04T07:26:46.252098966+00:00
-- elapsed: 269ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.opensky_eli.fact_aircraft_incremental
-- query_id: 01c4235e-0108-bc08-0029-56e7001596be
-- desc: execute adapter call
-- back compat for old kwarg name
  
  begin
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.opensky_eli.fact_aircraft_incremental", "profile_name": "opensky_eli", "target_name": "dev"} */;
-- created_at: 2026-05-04T07:26:46.252510047+00:00
-- finished_at: 2026-05-04T07:26:48.167890239+00:00
-- elapsed: 1.9s
-- outcome: success
-- dialect: snowflake
-- node_id: model.opensky_eli.fact_aircraft_incremental
-- query_id: 01c4235e-0108-bbba-0029-56e7001577a2
-- desc: execute adapter call

    
        
            
	    
	    
            
        
    

    

    merge into OPENSKY_DB.RAW_marts.fact_aircraft_incremental as DBT_INTERNAL_DEST
        using OPENSKY_DB.RAW_marts.fact_aircraft_incremental__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.icao24 = DBT_INTERNAL_DEST.icao24))

    
    when matched then update set
        "ICAO24" = DBT_INTERNAL_SOURCE."ICAO24","REGISTRATION" = DBT_INTERNAL_SOURCE."REGISTRATION","MANUFACTURER" = DBT_INTERNAL_SOURCE."MANUFACTURER","MODEL" = DBT_INTERNAL_SOURCE."MODEL","OPERATOR" = DBT_INTERNAL_SOURCE."OPERATOR","AWS_LOAD_DATE" = DBT_INTERNAL_SOURCE."AWS_LOAD_DATE","_LOADED_AT" = DBT_INTERNAL_SOURCE."_LOADED_AT"
    

    when not matched then insert
        ("ICAO24", "REGISTRATION", "MANUFACTURER", "MODEL", "OPERATOR", "AWS_LOAD_DATE", "_LOADED_AT")
    values
        ("ICAO24", "REGISTRATION", "MANUFACTURER", "MODEL", "OPERATOR", "AWS_LOAD_DATE", "_LOADED_AT")


/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.opensky_eli.fact_aircraft_incremental", "profile_name": "opensky_eli", "target_name": "dev"} */;
-- created_at: 2026-05-04T07:26:48.168235227+00:00
-- finished_at: 2026-05-04T07:26:48.837283749+00:00
-- elapsed: 669ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.opensky_eli.fact_aircraft_incremental
-- query_id: 01c4235e-0108-c23b-0029-56e70017b616
-- desc: execute adapter call

    commit
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.opensky_eli.fact_aircraft_incremental", "profile_name": "opensky_eli", "target_name": "dev"} */;
-- created_at: 2026-05-04T07:26:48.841463195+00:00
-- finished_at: 2026-05-04T07:26:49.497446246+00:00
-- elapsed: 655ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.opensky_eli.fact_aircraft_incremental
-- query_id: 01c4235e-0108-bc85-0029-56e70015e616
-- desc: execute adapter call
drop view if exists OPENSKY_DB.RAW_marts.fact_aircraft_incremental__dbt_tmp cascade
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.opensky_eli.fact_aircraft_incremental", "profile_name": "opensky_eli", "target_name": "dev"} */;
