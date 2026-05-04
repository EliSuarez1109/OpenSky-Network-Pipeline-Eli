{% macro clear_timestamp(column_name) %}
    CASE 
        WHEN {{ column_name }} = '""' OR {{ column_name }} IS NULL THEN NULL
        ELSE TO_TIMESTAMP_NTZ({{ column_name }})
    END
{% endmacro %}