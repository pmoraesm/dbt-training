{% macro limit_results_in_default(column_name, no_of_days=3) %}
{% if target.name == 'default' %}
where {{ column_name }} >=  date_sub(current_date(), interval {{ no_of_days }} day)
{% endif %}
{%endmacro%}