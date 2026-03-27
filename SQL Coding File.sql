---Preview the table stracture
select * from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1` limit 100;

------------------------------------------------------------------
---1. Checking the date range
------------------------------------------------------------------

---Checking transaction start date (2023-01-01)
select MIN(transaction_date) AS start_date
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

---They finished the data collection on (2023-06-30)
select MAX(transaction_date) AS Latest_date
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;
---------------------------------------------------------------------------------------------------------------------------------
---2. Checking the name of store locations (We`ve got 3 store locations namely store_location, store_location & store_location)
----------------------------------------------------------------------------------------------------------------------------------
select DISTINCT store_location
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

---------------------------------------------------------------------------------------------------------------------------------
---3. Checking products sold accross different stores (product_category, Tea, product_category, product_category, product_category... )
----------------------------------------------------------------------------------------------------------------------------------
select DISTINCT product_category
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

select DISTINCT product_type
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

select DISTINCT product_category AS category, product_detail AS product_name
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

---Query: Retrieving opening and closing transaction times
select min(transaction_date) AS date, min (transaction_time) AS starting_time, max(transaction_time) AS closing_time
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
group by transaction_date;

---Sum of unit price by product category
select product_category, sum(unit_price* transaction_qty ) AS total_revenue
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
group by product_category ;

---sum of unit_prive by product_type
select product_type, sum(unit_price* transaction_qty) AS total_revenue
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
group by product_type;


---------------------------------------------------------------------------------------------------------------------------------
---4. Answering the Objectives
----------------------------------------------------------------------------------------------------------------------------------
---Identifying top revenue-generating product
select product_category, 
       SUM(transaction_qty * unit_price) AS total_revenue
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
group by product_category
order by total_revenue DESC;

---Identifying peak sales hour of the day
select transaction_time,
 case
       WHEN transaction_time BETWEEN '07:00:00' AND '10:00:00' THEN 'MORNING RUSH'
       WHEN transaction_time BETWEEN '10:00:01' AND '12:00:00' THEN 'LUNCH'
       WHEN transaction_time BETWEEN '12:00:01' AND '18:00:00' THEN 'DAYTIME'
else 'EVENING'
end as time_interval
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
GROUP BY transaction_time;

SELECT DATE_TRUNC('hour', transaction_time) AS hour_bucket,
       SUM(transaction_qty * unit_price) AS total_revenue
FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
GROUP BY hour_bucket
ORDER BY total_revenue DESC;

---Analysing the Sales trends across products and time intervals 
select product_category,COUNT (transaction_qty)
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

SELECT product_category,
       DATE_TRUNC('hour', transaction_time) AS hour_bucket,
       SUM(transaction_qty) AS total_units_sold,
       SUM(transaction_qty * unit_price) AS total_revenue
FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
GROUP BY product_category, hour_bucket
ORDER BY product_category, hour_bucket;


---------------------------------------------------------------------------------------------------------------------------------
---4. Locations comparisons
----------------------------------------------------------------------------------------------------------------------------------
---Which store sells more bakery items vs. coffee?
select store_location, product_category, SUM(transaction_qty )  AS total_units_sales
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
where product_category in ('Bakery', 'Coffee') 
group by product_category, store_location
order by total_units_sales DESC ; 

---Average transaction Value by location
select store_location, AVG(transaction_qty* unit_price) AS avg_transaction_value
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
group by store_location
order by avg_transaction_value DESC ;

---Revenue Contribution by Location and Category
select store_location, product_category, SUM(transaction_qty* unit_price )  AS total_revenue
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
where product_category in ('Bakery', 'Coffee') 
group by product_category, store_location
order by total_revenue DESC ; 

