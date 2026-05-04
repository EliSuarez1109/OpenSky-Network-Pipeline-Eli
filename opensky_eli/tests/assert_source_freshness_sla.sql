{# 
  Este test valida el SLA: 
  Si el último dato llegó hace más de 24 horas, el test devuelve filas y falla.
  Por problemas de compatibilida de version de dbt el compilador está rechazando las llaves estándar de freshness, 
  por lo que la solucion que encontre fue esta.
#}

SELECT 
    MAX(_loaded_at) as last_load,
    CURRENT_TIMESTAMP() as current_time_check
FROM {{ source('raw', 'aircraft_incremental_landing') }}
HAVING MAX(_loaded_at) < TIMESTAMPADD(hour, -24, CURRENT_TIMESTAMP())