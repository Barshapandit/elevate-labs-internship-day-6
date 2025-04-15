create database evermart_sales;  
use evermart_sales;
drop table products;
create table customers(
customer_id varchar(255) not null,
customer_name varchar(255) not null,
region varchar(255) not null,
signup_date date not null,
primary key (customer_id));
select * from customers;
create table products(
product_id varchar(255) not null,
product_name varchar(255) not null,
category varchar(255) not null,
price float not null,
primary key (product_id));
select * from products;
create table transactions(
transaction_id varchar(255) not null,	
customer_id varchar(255) not null,
product_id varchar(255) not null,	
transaction_date date not null,	
quantity int not null,	
total_value	float not null,
price float not null,
primary key (transaction_id));
select * from transactions;

# year wise sales
select year(transaction_date) as sales_year,round(sum(total_value),2) as yearly_total_sales
from transactions
group by year(transaction_date)
order by (sales_year);

# region-wise total quantity sold and total_revenue
select customers.region,sum(transactions.quantity) as total_quantity,
round(sum(transactions.total_value),2) as total_revenue
from customers join transactions
on customers.customer_id=transactions.customer_id
group by customers.region
order by total_revenue desc;

# category-wise sales
select products.category,sum(transactions.quantity) as total_quantity,
sum(transactions.total_value) as total_revenue
from products join transactions
on products.product_id=transactions.product_id
group by products.category
order by total_revenue desc;

# top 10 customers
select customers.customer_id,customers.customer_name,
transactions.total_value as total_sales
from customers join transactions
on customers.customer_id=transactions.customer_id
order by total_sales desc limit 10;

# top 10 selling products
select products.product_id,products.product_name,
products.category,transactions.total_value as total_sales
from products join transactions
on products.product_id=transactions.product_id
order by total_sales desc limit 10;

# year-wise category-wise highest quantity of products sold
select (year(transactions.transaction_date)) as sales_year,
products.category,
sum(transactions.quantity) as total_quantities_sold
from transactions join products
on transactions.product_id=products.product_id
group by sales_year,products.category
order by (sales_year);
