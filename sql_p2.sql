use sql_project_p1;
-- DATA CLEANING --
select * from retail_data
where sale_time IS NULL
OR
customer_id IS NULL
OR
gender IS NULL
OR 
age IS NULL
OR
category IS NULL
OR
quantiy IS NULL
OR 
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;
-- DATA EXPLORATION ---
-- HOW MANY CUTOMERS WE HAVE --
select count( DISTINCT customer_id) from retail_data;
select DISTINCT category from retail_data;
select * from retail_data;
-- write a query to retrieve all the columns fo sales made on '2022-11-05' --
select * from retail_data 
where sale_date='2022-11-05'
;
-- write a query to retrieve all the all transaction where caregory is clothing --
 -- and the quantity sold is more than10 in the month of november --

select * from retail_data
where category ='Clothing'
And 
quantiy>=4
And
month(sale_date)='11';

-- write a query to calculate total sales for each category --
select category,sum(total_sale),count(*) as total_orders from retail_data
group by category ;

-- write a query to found outt AVERAGE AGE --
-- OF CUSTOMERSNWHO HAVE PURCHASED ITEMS FFROM BEAUTY CATEGORY --
SELECT category, round(avg(age),2) from retail_data
where category='Beauty';

-- write a query to find out all the transaction where total sales>1000 --
select * from retail_data
where total_sale >1000;
-- write a query to find out total number of  transaction made by each gender in each category.
select gender,category,count(transaction_id) from retail_data
group by  gender,category;

-- write a query to calculate avg sales for each month find out best selling month in each year--
select * from
(
select month(sale_date),year(sale_date),avg(total_sale),
dense_rank()over(partition by year(sale_date) order by  avg(total_sale)) as p
from retail_data 
group by month(sale_date) ,year(sale_date)
) as t1
where p = 1;
-- write a query to find out the top 5 customer based on hishest total sales
select customer_id  ,sum(total_sale) 
from retail_data group by customer_id order by sum(total_sale) desc limit 5
;
-- write a query to find out the number of unique customer who purchased items from each category
select count(distinct customer_id),category from retail_data
group by category;
-- write a query to calculate each shift and number of orders
with hourly_sales
as
(
select *,
case
when hour(sale_time)<=12 then "morning"
when hour(sale_time) between 12 and 17 then "afternoon"
else "evening"
end as shift
from retail_data
)
select shift,count(*) as total_orders
from hourly_sales group by shift
;