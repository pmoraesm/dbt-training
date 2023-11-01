{% macro grant_select(schema=target.schema, role="roles/bigquery.dataViewer", user="paulo.filho@xebia.com") %}

    {% set sql %}
        grant `{{ role }}` on schema `{{ target.project }}`.{{ schema }} to "user:{{ user }}";
    {% endset %}

    {{ log('Granting role ' ~ role ~ ' on all tables on' ~ schema ~ ' to user' ~ user , info=True) }}
    {% do run_query(sql) %}
    {{ log('Privileges granted', info=True) }}

{% endmacro %}