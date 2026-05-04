{% macro get_max_loaded_date(table_ref) %}
    (SELECT MAX(_loaded_at) FROM {{ table_ref }})
{% endmacro %}