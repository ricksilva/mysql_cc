-- 
-- MySQL Crash Course
-- 
-- Chapter 3 – Introduction to SQL								
--
-- You can copy and paste any of these commands into your favorite MySQL tool
-- (like MySQL Workbench) and run them in your own MySQL environment.
--

-- The land database and the continent table creation are in the last chapter's script: chapter_2.sql
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
from   continent;
order by continent_name;

-- Ordering rows by population in descending order
select continent_id,
       continent_name,
       population
from   continent;
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

use XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;

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

-- Backticks
select `continent_id`,
       `continent_name`,
       `population`
from   `continent`;

-- Comments in SQL (like this one!):

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






create database election;

use election;

create table vote (
district	int,
precinct	int,
vote 		int
);

insert into vote (district, precinct, vote) values
    (1,         1,      14264),
    (1,         2,        547),
    (1,         3,       8756),
    (2,         1,         78),
    (2,         2,        366),
    (2,         3,        875);
    
select * from vote;

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


use music;

create table genre_stream
(
genre	varchar(50),
stream	int
);

insert into genre_stream (genre, stream) values
('Hip Hop', 3102456),
('Rock', 1577569),
('Pop', 1298756),
('Country', 764789),
('Latin',601758),
('Dance', 308745);

create database vacation; 

use vacation;

create table theme_park
(
	country	varchar(50),
	state	varchar(50),
	city	varchar(50),
	park	varchar(100)
);

insert into theme_park (country, state, city, park)
values 
('USA',			'Florida',			'Orlando',				'Disney World'),
('USA',			'Florida',			'Orlando',				'Universal Studios'),
('USA',			'Florida',			'Orlando',				'SeaWorld'),
('USA',			'Florida',			'Tampa',				'Busch Gardens'),
('Brazil',		'Santa Catarina',	'Balneario Camboriu',	'Unipraias Park'),
('Brazil',		'Santa Catarina',	'Florianopolis',		'Show Water Park');

select	country,
		state,
		count(*)
from	theme_park
group by country, state;



--
-- Try It Yourself Exercises:
--

-- Exercise 3-1: Select first and last name from the customer table
use feedback;

select	first_name,
		last_name
from	customer;

-- Exercise 3-2: Retrieve the customer_id, first_name, and last_name for customers with a first name of Karen
select	customer_id,
		first_name,
		last_name
from	customer
where	first_name = 'Karen';

-- Exercise 3-3: How many rows are in the genre_stream table?
use music;

select count(*) from genre_stream;

-- Exercise 3-4: Select all columns from the genre_stream table ordered by the stream column in descending order
select	*
from	genre_stream
order by stream desc;

-- Exercise 3-5: Find the average number of streams for all genres
select	avg(stream)
from	genre_stream;

-- Exercise 3-6: Show the number of parks per country
select	country,
		count(*)
from	theme_park
group by country;
