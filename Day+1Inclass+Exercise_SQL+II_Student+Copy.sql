# Dataset used: titanic_ds.csv
# Use subqueries for every question
Create database SQL2Inclass1;
use SQL2Inclass1;
#Q1. Display the first_name, last_name, passenger_no , 
#fare of the passenger who paid less than the  maximum fare. (20 Row)
select first_name,last_name,passenger_no,fare
from titanic_ds
where fare<(select max(fare) from titanic_ds);
#Q2. Display the first_name ,sex, age, fare and deck_number of the passenger 
#equals to passenger number 7 but exclude passenger number 7.(4 Rows)
select first_name,sex,age,fare,deck_number
from titanic_ds
where DECK_NUMBER=(select DECK_NUMBER from titanic_ds where Passenger_No=7) and Passenger_No!=7;
#Q3. Display first_name,embark_town where deck is equals to the deck of embark
# town ends with word 'town' (7 Rows)
select * from titanic_ds;
select first_name,embark_town
from titanic_ds
where DECK in (select DECK from  titanic_ds where embark_town like '%town%' );
# Dataset used: youtube_11.csv

#Q4. Write a query to print video_id and channel_title where trending_date is equals to 
#the trending_date of  category_id 1(5 Rows)
select video_id,channel_title,trending_date
from youtube_11
where Trending_Date=(select Trending_Date from youtube_11 where Category_id=1);
#Q5. Write a query to display the publish date, trending date ,views and description 
#where views are more than views of Channel 'vox'.(7 Rows))
select publish_date,trending_date,views,description
from youtube_11
where views>(select views from youtube_11 where Channel_Title='vox');
#Q6. Write a query to display the channel_title, publish_date and the trending_date 
#having category id in between 9 to Maximum category id .
# Do not use Max function and Use Subquery (3 Rows)
select channel_title,publish_date,trending_date
from youtube_11
where Category_id in (select Category_id from youtube_11 where Category_id >= 9 );
# Database used: db1 (db1.sql file provided)

#Q7. Get those order details whose amount is greater than 100,000 and got cancelled(1 Row))
select * from orderdetails;
select * from payments;
select * from orders;

select *
from payments  p join orders o
on p.customerNumber=o.customerNumber
where amount in (select amount from payments where amount>100000)and status in (select status from orders where status like '%cancelled%');

select *
from orders
where customerNumber in ( select customerNumber from payments where amount>100000 and status like '%cancelled%');
#Q8. Get employee details who shipped an order within a time span of two days 
#from order date (15 Rows)
select *
from employees
where employeeNumber in (select salesrepemployeenumber from customers where customerName 
in (select customername from orders where datediff(shippeddate,orderdate)<=2));
#Q9. Get product name , product line , product vendor of products that got cancelled(53 Rows)
 select * from orderdetails;
 select productname,productline,productvendor
 from products
 where productCode in (select productCode from orderdetails where orderNumber in (select orderNumber from orders where status like '%cancelled%'));
#Q10. Display those customers who ordered product of price greater than average price(buyPrice)
#of all products(98 Rows)
select * from customers where customers.customerNumber IN 
(select orders.customerNumber from orders where orders.orderNumber IN
(select orderNumber from orderdetails where productCode IN
(select products.productCode from products where products.buyPrice>
(select avg(products.buyPrice) from products))));

