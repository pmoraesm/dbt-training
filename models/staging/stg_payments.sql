select
    id as customer_id,
    orderid as order_id,
    paymentmethod as payment_method,
    status,
    amount / 100 as amount,
    created,
    _batched_at

from {{ source('stripe', 'payment') }}