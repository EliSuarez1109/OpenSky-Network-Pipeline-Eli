-- created_at: 2026-05-04T09:37:42.079564249+00:00
-- finished_at: 2026-05-04T09:37:42.335019543+00:00
-- elapsed: 255ms
-- outcome: success
-- dialect: snowflake
-- node_id: test.opensky_eli.not_null_fact_aircraft_incremental_icao24.8d11396a75
-- query_id: 01c423e1-0108-bc83-0029-56e70015c75e
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select icao24
from OPENSKY_DB.RAW_marts.fact_aircraft_incremental
where icao24 is null



  
  
      
    ) dbt_internal_test
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.opensky_eli.not_null_fact_aircraft_incremental_icao24.8d11396a75", "profile_name": "opensky_eli", "target_name": "dev"} */;
-- created_at: 2026-05-04T09:37:43.134364261+00:00
-- finished_at: 2026-05-04T09:37:43.422496244+00:00
-- elapsed: 288ms
-- outcome: success
-- dialect: snowflake
-- node_id: test.opensky_eli.unique_fact_aircraft_incremental_icao24.c5b7d281ee
-- query_id: 01c423e1-0108-c23b-0029-56e70017b776
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    icao24 as unique_field,
    count(*) as n_records

from OPENSKY_DB.RAW_marts.fact_aircraft_incremental
where icao24 is not null
group by icao24
having count(*) > 1



  
  
      
    ) dbt_internal_test
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.opensky_eli.unique_fact_aircraft_incremental_icao24.c5b7d281ee", "profile_name": "opensky_eli", "target_name": "dev"} */;
-- created_at: 2026-05-04T09:37:44.294912939+00:00
-- finished_at: 2026-05-04T09:37:44.646633318+00:00
-- elapsed: 351ms
-- outcome: success
-- dialect: snowflake
-- node_id: test.opensky_eli.dbt_utils_accepted_range_fact__c9665e6053a55fecddfee148e88a9d1f.4ddbde6155
-- query_id: 01c423e1-0108-c1f1-0029-56e700175746
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  

with meet_condition as(
  select *
  from OPENSKY_DB.RAW_marts.fact_operator_stats_incremental
),

validation_errors as (
  select *
  from meet_condition
  where
    -- never true, defaults to an empty result set. Exists to ensure any combo of the `or` clauses below succeeds
    1 = 2
    -- records with a value >= min_value are permitted. The `not` flips this to find records that don't meet the rule.
    or not total_aircrafts >= 0
)

select *
from validation_errors


  
  
      
    ) dbt_internal_test
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.opensky_eli.dbt_utils_accepted_range_fact__c9665e6053a55fecddfee148e88a9d1f.4ddbde6155", "profile_name": "opensky_eli", "target_name": "dev"} */;
-- created_at: 2026-05-04T09:37:45.182446252+00:00
-- finished_at: 2026-05-04T09:37:45.476760247+00:00
-- elapsed: 294ms
-- outcome: success
-- dialect: snowflake
-- node_id: test.opensky_eli.assert_source_freshness_sla.710091dfbc
-- query_id: 01c423e1-0108-bc62-0029-56e70015884e
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  

SELECT 
    MAX(_loaded_at) as last_load,
    CURRENT_TIMESTAMP() as current_time_check
FROM OPENSKY_DB.RAW.aircraft_incremental_landing
HAVING MAX(_loaded_at) < TIMESTAMPADD(hour, -24, CURRENT_TIMESTAMP())
  
  
      
    ) dbt_internal_test
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.opensky_eli.assert_source_freshness_sla.710091dfbc", "profile_name": "opensky_eli", "target_name": "dev"} */;
-- created_at: 2026-05-04T09:37:46.023400968+00:00
-- finished_at: 2026-05-04T09:37:46.283652575+00:00
-- elapsed: 260ms
-- outcome: success
-- dialect: snowflake
-- node_id: test.opensky_eli.unique_fact_operator_stats_incremental_operator_icao.2513d9949e
-- query_id: 01c423e1-0108-c17e-0029-56e70017e792
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    operator_icao as unique_field,
    count(*) as n_records

from OPENSKY_DB.RAW_marts.fact_operator_stats_incremental
where operator_icao is not null
group by operator_icao
having count(*) > 1



  
  
      
    ) dbt_internal_test
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.opensky_eli.unique_fact_operator_stats_incremental_operator_icao.2513d9949e", "profile_name": "opensky_eli", "target_name": "dev"} */;
-- created_at: 2026-05-04T09:37:47.318910442+00:00
-- finished_at: 2026-05-04T09:37:47.721497712+00:00
-- elapsed: 402ms
-- outcome: success
-- dialect: snowflake
-- node_id: test.opensky_eli.not_null_dim_operators_incremental_operator_icao.da0de5baae
-- query_id: 01c423e1-0108-bc08-0029-56e7001597fe
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select operator_icao
from OPENSKY_DB.RAW_marts.dim_operators_incremental
where operator_icao is null



  
  
      
    ) dbt_internal_test
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.opensky_eli.not_null_dim_operators_incremental_operator_icao.da0de5baae", "profile_name": "opensky_eli", "target_name": "dev"} */;
-- created_at: 2026-05-04T09:37:48.530950387+00:00
-- finished_at: 2026-05-04T09:37:48.946580027+00:00
-- elapsed: 415ms
-- outcome: success
-- dialect: snowflake
-- node_id: test.opensky_eli.test_no_duplicate_operators.78533e3267
-- query_id: 01c423e1-0108-bc62-0029-56e700158852
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    operator_icao as unique_field,
    count(*) as n_records

from OPENSKY_DB.RAW_marts.dim_operators_incremental
where operator_icao is not null
group by operator_icao
having count(*) > 1



  
  
      
    ) dbt_internal_test
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.opensky_eli.test_no_duplicate_operators.78533e3267", "profile_name": "opensky_eli", "target_name": "dev"} */;
-- created_at: 2026-05-04T09:37:49.438824267+00:00
-- finished_at: 2026-05-04T09:37:49.709885884+00:00
-- elapsed: 271ms
-- outcome: success
-- dialect: snowflake
-- node_id: test.opensky_eli.dbt_expectations_expect_column_01f4141578aab49956eb5aed2fcebf1b.5c388b52ed
-- query_id: 01c423e1-0108-c1f9-0029-56e700177782
-- desc: execute adapter call
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  






    with grouped_expression as (
    select
        
        
    
  
( 1=1 and total_aircrafts >= 1
)
 as expression


    from OPENSKY_DB.RAW_marts.fact_operator_stats_incremental
    

),
validation_errors as (

    select
        *
    from
        grouped_expression
    where
        not(expression = true)

)

select *
from validation_errors








  
  
      
    ) dbt_internal_test
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.opensky_eli.dbt_expectations_expect_column_01f4141578aab49956eb5aed2fcebf1b.5c388b52ed", "profile_name": "opensky_eli", "target_name": "dev"} */;
