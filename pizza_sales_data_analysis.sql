CREATE DATABASE pizzahut;
USE pizzahut;
CREATE TABLE order_detail ( 
order_details_id int not null,
    order_id INT NOT NULL,
    pizza_id text not null,
    quantity int NOT NULL,
    PRIMARY KEY(order_details_id)
);

-- Retrieve the total number of orders placed.

SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;

-- Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(order_detail.quantity * pizzas.price),
            2) AS total_sales
FROM
    order_detail
        JOIN
    pizzas ON pizzas.pizza_id = order_detail.pizza_id

-- Identify the highest-priced pizza.

select
pizza_types.name,pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
order by pizzas.price desc limit 1;

-- Identify the most common pizza size ordered.

select pizzas.size,count(order_detail.order_details_id) as order_count
from pizzas
join order_detail
on pizzas.pizza_id=order_detail.pizza_id
group by pizzas.size
order by order_count desc ;

-- List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizza_types.name, SUM(order_detail.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_detail ON order_detail.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category, SUM(order_detail.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_detail ON order_detail.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;

-- Determine the distribution of orders by hour of the day.

select hour(order_time) as hour, count(order_id) as order_count
from orders
group by  hour;

-- Join relevant tables to find the category-wise distribution of pizzas.

select category, count(name)
from pizza_types
group by category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    ROUND(AVG(quantity), 0) as average_pizza_ordered_per_day
FROM
    (SELECT 
        orders.order_date, SUM(order_detail.quantity) AS quantity
    FROM
        orders
    JOIN order_detail ON orders.order_id = order_detail.order_id
    GROUP BY orders.order_date) AS order_quantity;


-- Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pizza_types.name,
    SUM(order_detail.quantity * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_detail ON order_detail.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;

-- Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    pizza_types.category,
    round((SUM(order_detail.quantity * pizzas.price) / (SELECT 
            ROUND(SUM(order_detail.quantity * pizzas.price),
                        2) AS total_sales
        FROM
            order_detail
                JOIN
            pizzas ON pizzas.pizza_id = order_detail.pizza_id)),2) * 100 AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_detail ON order_detail.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;

-- Analyze the cumulative revenue generated over time.

select order_date,sum(revenue) over(order by order_date) as cum_revenue
from
(select orders.order_date, sum(order_detail.quantity*pizzas.price) as revenue 
from order_detail
join pizzas
on order_detail.pizza_id=pizzas.pizza_id
join orders
on orders.order_id=order_detail.order_id
group by orders.order_date) as sales;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select name,revenue 
from
(select category,name,revenue,
rank() over(partition by category order by revenue desc) as rn
from
(select pizza_types.category,pizza_types.name, sum((order_detail.quantity)*pizzas.price) as revenue
from pizza_types
join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_detail
on order_detail.pizza_id=pizzas.pizza_id
group by pizza_types.category,pizza_types.name) as a) as b 
where rn <=3;
