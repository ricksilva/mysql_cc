--
-- MySQL Crash Course
-- 
-- Chapter 2 – Creating Databases and Tables 					
--
-- You can copy and paste any of these commands into your favorite MySQL tool
-- (like MySQL Workbench) and run them in your own MySQL environment.
--

--
-- Examples from the chapter:
--

-- Get a list of your databases
show databases;

-- Creating databases
create database circus;
create database finance;
create database music;

-- Removing databases
drop database circus;
drop database finance;
drop database music;

-- Create a new database called land
create database land;

-- Set your default database to "land" before you create the tables below
-- so they will be created in the "land" database.
use land;

create table continent 
(
   continent_id		int,
   continent_name	varchar(20),
   population		bigint
);

-- If you want to load the continent table with data, you can run these commands:
insert into continent (continent_id, continent_name, population) values (1, 'Asia', 4641054775);
insert into continent (continent_id, continent_name, population) values (2, 'Africa', 1340598147);
insert into continent (continent_id, continent_name, population) values (3, 'Europe', 747636026);
insert into continent (continent_id, continent_name, population) values (4, 'North America', 592072212);
insert into continent (continent_id, continent_name, population) values (5, 'South America', 430759766);
insert into continent (continent_id, continent_name, population) values (6, 'Australia', 43111704);
insert into continent (continent_id, continent_name, population) values (7, 'Antarctica', 0);

create table high_temperature
(
    city				varchar(50),
    year				int,
    high_temperature	int,
    primary key (city, year)
);

-- Load data into the high_temperature table
insert into high_temperature (city, year, high_temperature)
values
('Death Valley, CA', 		2020,	130),
('International Falls, MN', 2020,	78),
('New York, NY', 			2020,	96),
('Death Valley, CA', 		2021,	128),
('International Falls, MN', 2021,	77),
('New York, NY', 			2021,	98);

-- This is an improved version of the high_temperature table that we created above.
-- In this version we have check constraints for the year and high_temperature columns.
-- To create this new version of the table, we drop the old table, recreate the table, 
-- and reinsert the data.

-- Drop the old version of the table (if one exists)
drop table if exists high_temperature;

create table high_temperature
(
    city              varchar(50),
    year              int,
    high_temperature  int,
    constraint check (year between 1880 and 2200),
    constraint check (high_temperature < 200),
    primary key (city, year)
);

-- Reinsert the data into the high_temperature table
insert into high_temperature (city, year, high_temperature)
values
('Death Valley, CA', 		2020,	130),
('International Falls, MN', 2020,	78),
('New York, NY', 			2020,	96),
('Death Valley, CA', 		2021,	128),
('International Falls, MN', 2021,	77),
('New York, NY', 			2021,	98);


create database feedback;

-- Don't forget to run the USE command so that the tables below will be 
-- created in the "feedback" database
use feedback;

create table customer
(
    customer_id     int,
    first_name	    varchar(50),
    last_name       varchar(50),
    address         varchar(100),
    primary key (customer_id)
); 

-- If you want to load the customer table with data, run these commands:
insert into customer (customer_id, first_name, last_name, address)
values
(1, 'Bob', 'Smith', '12 Dreary Lane'),
(2, 'Sally', 'Jones', '76 Boulevard Meugler'),
(3, 'Karen', 'Bellyacher', '354 Main Street');

create table complaint
    (
    complaint_id  int,
    customer_id   int,
    complaint     varchar(200),
    primary key (complaint_id),
    foreign key (customer_id) references customer(customer_id)
    );
	
-- Insert one row of data into the complaint table
insert into complaint (complaint_id, customer_id, complaint)
values (1, 3, 'I want to speak to your manager');

-- Trying to insert this row into the complaint table will fail
-- because there is no customer 4 in the customer table.
insert into complaint (complaint_id, customer_id, complaint)
values (2, 4, 'My food was cold');

alter table customer add column zip varchar(50);
alter table customer drop column address;
alter table customer rename column zip to zip_code;
alter table customer rename to valued_customer;

create table contact
(
    contact_id     int,
    name           varchar(50)  not null,
    city           varchar(50),
    phone          varchar(20),
    email_address  varchar(50)  unique,
    primary key(contact_id)
);

-- Note that for contact 3, null does not have quotes around it:
insert into contact values
(1, 'Steve Chen',	'Beijing',	'123-3123',	'steve@schen21.org'),
(2, 'Joan Field',	'New York',	'321-4321',	'jfield@jfny99.com'),
(3, 'Bill Bashful',	'Lincoln',	null,		'bb@shyguy77.edu');

create table job
(
    job_id     int,
    job_desc   varchar(100),
    shift      varchar(50) default '9-5',
    primary key (job_id)
);

create table product
	(
	product_id		int,
	product_name	varchar(100),
	supplier_id		int
	);
	
-- Create an index on the supplier_id column to speed up retrieval
create index product_supplier_index on product(supplier_id);

drop table product;

create database pet;

-- Don't forget to run the USE command so that the tables below will be 
-- created in the "pet" database
use pet;

-- Drop any old versions of this table before recreating it.
drop table if exists owner;

create table owner
(
	owner_id		int,
	owner_name		varchar(100),
	owner_address	varchar(100),
	primary key (owner_id)
);

drop table if exists breed;

create table breed
(
	breed_id	int,
	breed_name	varchar(50),
	temperament	varchar(100),
	primary key (breed_id)
);
	
drop table if exists veterinarian;

create table veterinarian
(
	veterinarian_id			int,
	veterinarian_name		varchar(100),
	veterinarian_address	varchar(100),
	veterinarian_phone		varchar(100),
	primary key (veterinarian_id)
);

drop table if exists dog;

create table dog
(
    dog_id            int,
    dog_name          varchar(50) unique,
    owner_id          int,
    breed_id          int,
    veterinarian_id   int,
    primary key (dog_id),
    foreign key (owner_id) references owner(owner_id),
    foreign key (breed_id) references breed(breed_id),
    foreign key (veterinarian_id) references veterinarian(veterinarian_id)
);

show indexes from dog;

--
-- Try It Yourself Exercises:
--

-- Exercise 2-1: Listing your databases
show databases;

-- Exercise 2-2: Creating a database and showing your databases.
create database cryptocurrency;

-- You should see the new cryptocurrency database in your list of databases.
show databases;

-- Exercise 2-3: Dropping a database and showing your databases.
drop database cryptocurrency;

-- You should not see the cryptocurrency database in your list of databases.
show databases;

-- Exercise 2-4: Create the athletic database and the sport and player tables with primary and foreign keys.
create database athletic;

use athletic;

create table sport
(
	sport_id	int,
	sport_name	varchar(50),
	primary key (sport_id)
);

create table player
(
    player_id    int,
    player_name  varchar(50),
    player_age   int,
    sport_id     int,
    primary key (player_id),
    foreign key (sport_id) references sport(sport_id)
);
