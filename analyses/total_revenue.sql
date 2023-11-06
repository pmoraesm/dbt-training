with payments as (
    select * from {{ ref("stg_payments") }}
    where status = 'success'
),

total as (
    select created as date,
    sum(amount) as total_amount
    from payments
    group by 1
    order by 1
)

select * from total