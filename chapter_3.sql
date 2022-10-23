-- 
-- MySQL Crash Course
-- 
-- Chapter 3 – Introduction to SQL								
--
-- You can copy and paste any of these commands into your favorite MySQL tool
-- (like MySQL Workbench) and run them in your own MySQL environment.
--

-- The land database and the continent table were created in the last chapter's script: chapter_2.sql
use land;

-- Selecting 3 columns from the continent table
select continent_id,
       continent_name,
       population
from   continent;

-- Selecting 3 columns from the continent table for Asia
select continent_id,
       continent_name,
       population
from   continent
where  continent_name = 'Asia';

-- Selecting just the population column from the continent table for Asia
select population
from   continent
where  continent_name   = 'Asia';

-- Ordering rows
select continent_id,
       continent_name,
       population
from   continent
order by continent_name;

-- Ordering rows by population in descending order
select continent_id,
       continent_name,
       population
from   continent
order by population desc;

-- Using the wildcard *
select *
from   continent;

-- The same SQL statements, formatted differently
select continent_id, continent_name, population from continent;

select continent_id, continent_name, population 
from continent;

-- Uppercase keywords
SELECT continent_id,
       continent_name,
       population
FROM   continent;


use pet;

-- Drop the table (if it exists) before recreating it
drop table if exists dog;

-- This table depends on the owner, breed, and veterinarian tables existing first.
-- If you did not create those tables, you can find the SQL in chapter_2.sql
CREATE TABLE dog
(
    dog_id            int,
    dog_name          varchar(50) UNIQUE,
    owner_id          int,
    breed_id          int,
    veterinarian_id   int,
    PRIMARY KEY (dog_id),
    FOREIGN KEY (owner_id) REFERENCES owner(owner_id),
    FOREIGN KEY (breed_id) REFERENCES breed(breed_id),
    FOREIGN KEY (veterinarian_id) REFERENCES veterinarian(veterinarian_id)
);


-- Switch back to the "land" database
use land;

-- Backticks
select `continent_id`,
       `continent_name`,
       `population`
from   `continent`;

-- The next 3 SQL statements show comments in SQL:

-- This SQL statement shows the highest-populated continents at the top
select continent_id,
       continent_name,
       population
from   continent
order by population desc;

select continent_id,
       continent_name, -- Continent names are displayed in English
       population
from   continent
order by population desc;

/* 
This query retrieves data for all the continents in the world. 
The population of each continent is updated in this table yearly.
*/
select * from continent;


create database employment;

use employment;

create table unemployed
(
	region_id   int,
	unemployed	int
);

insert into unemployed (region_id, unemployed)
values 
(1, 2218457),
(2, 137455),
(3, null);

select * 
from   unemployed
where  unemployed is null;

select * 
from   unemployed
where  unemployed is not null;

--
-- Try It Yourself Exercises:
--

-- If you didn't already create the feedback database in chapter 2, let's create it here
create database if not exists feedback;

-- Make sure the customer table is loaded for the Try It Yourself exercises:
use feedback;

-- Drop any old versions of this table (if they exist) before recreating the table
drop table if exists customer;

create table customer
(
    customer_id     int,
    first_name	    varchar(50),
    last_name       varchar(50),
    address         varchar(100),
    primary key (customer_id)
); 

-- Unless you already did this in chapter 2, load the customer table with data.
insert into customer (customer_id, first_name, last_name, address)
values
(1, 'Bob', 'Smith', '12 Dreary Lane'),
(2, 'Sally', 'Jones', '76 Boulevard Meugler'),
(3, 'Karen', 'Bellyacher', '354 Main Street');

-- Exercise 3-1: Select first and last name from the customer table
select	first_name,
		last_name
from	customer;

-- Exercise 3-2: Retrieve the customer_id, first_name, and last_name for customers with a first name of Karen
select	customer_id,
		first_name,
		last_name
from	customer
where	first_name = 'Karen';
