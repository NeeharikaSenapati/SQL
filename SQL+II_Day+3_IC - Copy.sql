Create database Sql2Inclass3;
use Sql2Inclass3;

-- ------------------------------------------------------------------------------------------

-- 1. Create a table Airline_Details. Follow the instructions given below: 
-- -- Q1. Values in the columns Flight_ID should not be null and Integer type.
-- -- Q2. Each name of the airline should be unique.
-- -- Q3. No country other than United Kingdom, USA, India, Canada and Singapore should beaccepted
-- -- Q4. Assign primary key to Flight_ID
CREATE TABLE  Airline_Details
(
Flight_ID INT  PRIMARY KEY,
name VARCHAR(25) UNIQUE,
country VARCHAR(15),
CONSTRAINT country_check CHECK (country IN ('United Kingdom', 'USA', 'India', 'Canada', 'Singapore'))
);

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 2. Create a table Passengers. Follow the instructions given below: 
-- -- Q1. Values in the columns Traveller_ID and PNR should not be null.
-- -- Q2. Name of the passenger should be not null
-- -- Q3. Only passengers having age greater than 18 are allowed.
-- -- Q4. Assign primary key to Traveller_ID
-- -- Q5. Flight_ID integer type and not null
-- -- Q6. Ticket_Price integer type and not null

CREATE TABLE Passengers (
Traveller_ID INT  PRIMARY KEY,
PNR VARCHAR(15) NOT NULL,
name VARCHAR(25) NOT NULL,
age INT,
country VARCHAR(15),
Flight_ID INT NOT NULL,
Ticket_Price INT NOT NULL,
CONSTRAINT age_check CHECK (age>18)
);

DESC Passengers;
-- ----------------------------------------------------------------------------------
-- Questions for table Passengers:  
-- -- Q3. PNR status should be unique as well  .
-- -- Q4. Flight Id should not be null.
ALTER TABLE Passengers
ADD CONSTRAINT UQ_PNR UNIQUE(PNR);
ALTER TABLE Passengers MODIFY Flight_ID INT NOT NULL;
-- ---------------------------------------------------------------------------------- 
-- Q5. Create a table Senior_Citizen_Details. Follow the instructions given below: 
-- -- Q1. Assign foreign key constraint on Traveller_ID such that if any row from passenger table is updated, then the Senior_Citizen_Details table should also get updated.
-- -- Q2. Also deletion of any row from passenger table should not be allowed.
-- -- Q3. Create Discounted_Price column of varchar type 20 size with not null property.
 CREATE TABLE  Senior_Citizen_Details(
Traveller_ID INT,
PNR VARCHAR(15) NOT NULL,
Discounted_Price VARCHAR(20) NOT NULL,
FOREIGN KEY (Traveller_ID) REFERENCES Passengers (Traveller_ID) ON DELETE RESTRICT ON UPDATE CASCADE
);
 
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- Q6. Create a table books. Follow the instructions given below: 
-- -- Columns: books_no, description, author_name, cost
-- -- Q1. The cost should not be less than or equal to 0.
-- -- Q2. The cost column should not be null.
-- -- Q3. Assign a primary key to the column books_no.
CREATE TABLE books (
books_no INT  PRIMARY KEY,
description VARCHAR(15) NOT NULL,
author_name VARCHAR(25) ,
cost INT NOT NULL,
CONSTRAINT cost_check CHECK (cost>0)
);
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
# Q7. Update the table 'books' to add columns 'description' and 'author' and must be unique
# of varchar type.

ALTER TABLE books MODIFY COLUMN description VARCHAR(25) UNIQUE NOT NULL,
MODIFY COLUMN author_name VARCHAR(25) UNIQUE NOT NULL;
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- Q8. Create a table bike_sales. Follow the instructions given below: 
-- -- Columns: id, product, quantity, release_year, release_month
-- -- Q1. Assign a primary key to ID. Also the id should auto increment.
-- -- Q2. None of the columns should be left null.
-- -- Q3. The release_month should be between 1 and 12 (including the boundries i.e. 1 and 12).
-- -- Q4. The release_year should be between 2000 and 2010.
-- -- Q5. The quantity should be greater than 0.
CREATE TABLE bike_sales (
ID INT  PRIMARY KEY AUTO_INCREMENT,
product VARCHAR(15) NOT NULL,
quantity INT NOT NULL,
release_year INT NOT NULL,
release_month INT NOT NULL,
CONSTRAINT month_check CHECK ( release_month BETWEEN 1 AND 12),
CONSTRAINT year_check CHECK ( release_month BETWEEN 2000 AND 2010),
CONSTRAINT quantity_check CHECK ( quantity > 0)
);