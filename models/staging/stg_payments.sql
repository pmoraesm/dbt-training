select
    id as customer_id,
    orderid as order_id,
    paymentmethod as payment_method,
    status,
    {{ cents_to_dollar('amount', 4) }} as amount,
    created,
    _batched_at

from {{ source('stripe', 'payment') }}

/* {{ limit_results_in_default('created', 10)}} */