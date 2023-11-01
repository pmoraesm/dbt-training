{% macro clean_stale_models(database=target.project, schema=target.schema, days=7, dry_run=True) %}

    {% set get_drop_commands_query %}
    
        with metadata as (
            select
                'DROP ' as drop_prefix,
                case table_type
                    when 'VIEW' then 'VIEW'
                    else 'TABLE'
                end
                as drop_type,
                ' ' || table_schema || '.' || table_name || ';'  as drop_suffix         
            from {{ schema }}.INFORMATION_SCHEMA.TABLES
            where table_schema = '{{ schema }}'
            and date(creation_time) <= date_sub(current_date, interval {{ days }} day)
        )
        select drop_prefix || drop_type || drop_suffix from metadata
    {% endset %}

    {{ log('\nGenerating cleanup queries...\n', info=True) }}
    
    {% set drop_queries = run_query(get_drop_commands_query).columns[0].values() %}

    {% for query in drop_queries %}
        {% if dry_run %}
            {{ log(query, info=True) }}
        {% else %}
            {{ log('Dropping object with command: ' ~ query, info=True) }}
            {% do run_query(query) %} 
        {% endif %}  
    {% endfor %}

{% endmacro %}