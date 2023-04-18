with employees as (

    select
        Employee_ID,
        Full_Name,
        Age

    from  `pocs-381312.001.Sheet1` 

),

finances as (

    select
        Employee_ID,
        Job_Title,
        
        status

    from  `pocs-381312.001.Sheet1` 

),

customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders

    group by 1

),


final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from customers

    left join customer_orders using (customer_id)

)

select * from final