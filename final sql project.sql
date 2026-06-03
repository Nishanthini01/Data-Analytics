create database amazon_company
use amazon_company;

#insert tables
select * from customers;
select * from orders;
select * from products;
select * from reviews;
select * from suppliers;

##Retrieve all customers from a specific city

select * from customers;
where city = 'North Kyle'

##Fetch all products under the "fruits" category

select * from products
WHERE category ="fruits";

##Ensure age cannot be null and must be greater than 18

select 8,case
when age >18 then "eligible"
else"not eligible"
end as age_limit from customers;
select * from customers;

##Insert 2 new rows into the products table using INSERT statements

insert into products values
('1112456a-12ab-43de-82ed-799bb41c6c6c','Fresh Bread','Bakery','Sub-Bakery-2',320,450,'944b97d5-77cd-54dc-b49d-9d82df942674'),
('2223567b-23bc-54ef-93fe-811cc52d7d7d','Chocolate Cake','Bakery','Sub-Bakery-3',540,620,'a55c18e6-88de-65ed-c50e-0e93eg053785');
select * from products;

##Update the stock quantity of a product where ProductId matches a specific ID

set sql_safe_updates=0;
update products
SET StockQuantity = 190 WHERE ï»¿ProductID = "2aa28375-c563-41b5-aa33-8e2c2e0f4db9";
select ï»¿ProductID,StockQuantity from products;

##Delete a supplier from the suppliers table where their city matches a specific value

select * from suppliers;
select city,count(*) as city_count from suppliers
group by city;
delete from  suppliers
where city="New James";
set sql_safe_updates=0;

##Add a CHECK constraint to ensure that ratings in the reviews table are between 1 and 5

alter table reviews
add check (Rating between 1 and 5);
select * from reviews;

##Add a DEFAULT constraint for the PrimeMember column in the customers table(default value:"no")

alter table customers change column PrimeMember primemember varchar(100) default "no";

##WHERE clause to find orders placed after 2024-01-01

select * from orders
where OrderDate > '2024-01-01';

##HAVING clause to list products with average ratings greater than 4

select*from reviews;
select ProductID, AVG(Rating) AS Avg_Rating from reviews
GROUP BY ProductID
HAVING Avg(Rating) > 4;

##GROUP BY and ORDER BY clauses to rank products by total sales

select productName,sum(PricePerUnit) as total_sales from  products
group by productName
order by  total_sales  desc;
select *from products;
select*,
 rank()over (order by PricePerUnit desc) as Ranking from  products;
 
 ##Calculate each customers total spending
 
select CustomerID,count(*),sum(OrderAmount) as total_spending  from orders
 group by CustomerID
 having total_spending;
 select*from orders; 
 
 
 ##Rank customeers based on their spending
 
 select*,rank()over (order by OrderAmount desc ) as Ranking from  orders;
 
##Identify customers who have spent more than 5,000/-

select *from orders
where OrderAmount > 5000;

##Join the orders and orderdetails tables to calculate total revenue per order

select o.ï»¿OrderID,sum(od.Quantity * o.OrderAmount) as Total_Revenue from orders o join order_details od on od.ï»¿OrderID=o.ï»¿OrderID 
group by od.ï»¿OrderID;
select *from orders;
select*from order_details;

##Identify the customers who placed the most orders in a specific time period

select CustomerID,count(ï»¿OrderID) as Total_Orders from orders
where OrderDate between '2024-01-01' and '2025-01-01'
group by CustomerID
order by Total_Orders desc;
select *from orders;

##Find the supplier with the most products in stock

select SupplierID,sum(StockQuantity) as Total_Stock from products
group by SupplierID
order by Total_Stock desc
limit 1;

##Seperate product categories and subcategories into a new table

create table categories
(Category varchar(50),Subcategory varchar(50));
create table sub_categories
(Category varchar(50), Subcategory varchar(50));

 
 ##Identify the top 3 products based on sales revenue
 
 select*,dense_rank()over(order by PricePerUnit desc) as ranking from products  
limit 3;
select*from products;

##Find the customers who haven't placed  order

select *from customers
where ï»¿CustomerID not in (select ï»¿CustomerID from orders);

##Which cities have the highest concentration of prime members

select City,COUNT(*) as Prime_Members FROM customers
where PrimeMember ="Yes"
group by City
order by Prime_Members desc;

##What are the top 3 most freqently ordered categories

select *from products;
select Category,count(*) as category_count from products
where ï»¿ProductID  IN (select ï»¿ProductID from products)
group by Category
having category_count 
limit 3;
