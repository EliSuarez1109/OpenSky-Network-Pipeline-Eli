{% macro clear_timestamp(column_name) %}
    
    TRY_TO_TIMESTAMP(
        NULLIF(REPLACE(TRIM({{ column_name }}), '"', ''), '')
    )
{% endmacro %}