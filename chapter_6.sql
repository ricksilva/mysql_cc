-- 
-- MySQL Crash Course
-- 
-- Chapter 6 – Complex Joins with Multiple Tables						
--
-- You can copy and paste any of these commands into your favorite MySQL tool
-- (like MySQL Workbench) and run them in your own MySQL environment.
--

-- Setting up the database for our query below
create database police;

use police;

create table location
	(
	location_id		int,
	location_name	varchar(100),
	primary key (location_id)
	);
	
insert into location (location_id, location_name) values (1, 'Corner of Main and Elm');
insert into location (location_id, location_name) values (2, 'Family Donut Shop');
insert into location (location_id, location_name) values (3, 'House of Vegan Restaurant');

create table suspect
	(
	suspect_id		int,
	suspect_name	varchar(100),
	primary key(suspect_id)
);

insert into suspect (suspect_id, suspect_name) values (1, 'Eileen Sideways');
insert into suspect (suspect_id, suspect_name) values (2, 'Hugo Hefty');

create table crime
	(
	crime_id	int,
	location_id	int,
	suspect_id	int,
	crime_name	varchar(200),
	primary key(crime_id),
	foreign key (location_id) references location(location_id),
	foreign key (suspect_id) references suspect(suspect_id)
	);
	
insert into crime (crime_id, location_id, suspect_id, crime_name) values (1, 1, 1, 'Jaywalking');
insert into crime (crime_id, location_id, suspect_id, crime_name) values (2, 2, 2, 'Larceny: Donut');
insert into crime (crime_id, location_id, suspect_id, crime_name) values (3, 3, null, 'Receiving Salad Under False Pretenses');

-- A query with both an inner join and an outer join
select	c.crime_name,
		s.suspect_name
from	crime c
inner join location l
  on c.location_id = l.location_id
left join suspect s
  on c.suspect_id = s.suspect_id;


-- Setting up a wine database for the examples below
create database wine;

use wine;

create table country
	(
	country_id		int,
	country_name	varchar(100)
	);

insert into country (country_id, country_name) values (1,'France');
insert into country (country_id, country_name) values (2,'Spain');
insert into country (country_id, country_name) values (3,'USA');

create table region
	(
	region_id	int,
	region_name	varchar(100),
	country_id	int
	);
	
insert into region (region_id, region_name, country_id) values (1, 'Napa Valley', 3);
insert into region (region_id, region_name, country_id) values (2, 'Walla Walla Valley', 3);
insert into region (region_id, region_name, country_id) values (3, 'Texas Hill', 3);

create table viticultural_area
	(
	viticultural_area_id	int,
	viticultural_area_name	varchar(100),
	region_id				int
	);

insert into viticultural_area (viticultural_area_id, viticultural_area_name, region_id) values (1, 'Atlas Peak', 1);
insert into viticultural_area (viticultural_area_id, viticultural_area_name, region_id) values (2, 'Calistoga', 1);
insert into viticultural_area (viticultural_area_id, viticultural_area_name, region_id) values (3, 'Wild Horse Valley', 1);

create table winery 
	(
	winery_id				int,
	winery_name 			varchar(100),
	viticultural_area_id	int,
	offering_tours_flag		bool
	);
	
insert into winery (winery_id, winery_name, viticultural_area_id, offering_tours_flag) values (1, 'Silva Vinyards', 1, false);
insert into winery (winery_id, winery_name, viticultural_area_id, offering_tours_flag) values (2, 'Chateau Traileur Parc', 2, true);
insert into winery (winery_id, winery_name, viticultural_area_id, offering_tours_flag) values (3, 'Winosaur Estate', 3, true);

	
create table wine_type
	(
	wine_type_id	int,
	wine_type_name	varchar(100)
	);
	
insert into wine_type values (1, 'Chardonnay');
insert into wine_type values (2, 'Cabernet Sauvignon');
insert into wine_type values (3, 'Merlot');

create table portfolio
	(
	winery_id		int,
	wine_type_id	int,
	in_season_flag	bool
	);
	
	
insert into portfolio (winery_id, wine_type_id, in_season_flag) values (1, 1, true);
insert into portfolio (winery_id, wine_type_id, in_season_flag) values (1, 2, true);
insert into portfolio (winery_id, wine_type_id, in_season_flag) values (1, 3, false);
insert into portfolio (winery_id, wine_type_id, in_season_flag) values (2, 1, true);
insert into portfolio (winery_id, wine_type_id, in_season_flag) values (2, 2, true);
insert into portfolio (winery_id, wine_type_id, in_season_flag) values (2, 3, true);
insert into portfolio (winery_id, wine_type_id, in_season_flag) values (3, 1, true);
insert into portfolio (winery_id, wine_type_id, in_season_flag) values (3, 2, true);
insert into portfolio (winery_id, wine_type_id, in_season_flag) values (3, 3, true);
	
-- A five-table join
select c.country_name,
       r.region_name,
       v.viticultural_area_name,
       w.winery_name
from   country c
join   region r
  on   c.country_id = r.country_id
 and   c.country_name = 'USA'
join   viticultural_area v
  on   r.region_id = v.region_id
join   winery w
  on   v.viticultural_area_id = w.viticultural_area_id
 and   w.offering_tours_flag is true
join   portfolio p
  on   w.winery_id = p.winery_id
 and   p.in_season_flag is true
join   wine_type t
  on   p.wine_type_id = t.wine_type_id
 and   t.wine_type_name = 'Merlot';

-- Creating a temporary table
create temporary table winery_portfolio
select w.winery_name,
       w.viticultural_area_id
from   winery w
join   portfolio p
  on   w.winery_id = p.winery_id
 and   w.offering_tours_flag is true
 and   p.in_season_flag is true
join   wine_type t
  on   p.wine_type_id = t.wine_type_id
 and   t.wine_type_name = 'Merlot';

-- Querying the temporary table
select * from winery_portfolio;

-- A Common Table Expression (CTE)
with winery_portfolio_cte as
(
    select w.winery_name,
           w.viticultural_area_id
    from   winery w
    join   portfolio p
      on   w.winery_id = p.winery_id
     and   w.offering_tours_flag is true
     and   p.in_season_flag is true
    join   wine_type t
      on   p.wine_type_id = t.wine_type_id
     and   t.wine_type_name = 'Merlot'
 )
select c.country_name,
       r.region_name,
       v.viticultural_area_name,
       wp.winery_name
from   country c
join   region r
  on   c.country_id = r.country_id
 and   c.country_name = 'USA'
join   viticultural_area v
  on   r.region_id = v.region_id
join   winery_portfolio_cte wp
  on   v.viticultural_area_id = wp.viticultural_area_id;

-- This won't work because CTEs are temporary. You can't query them like a table.
select * from winery_portfolio_cte;

-- wot is a derived table
select wot.winery_name,
       t.wine_type_name
from   portfolio p
join   wine_type t
on     p.wine_type_id = t.wine_type_id
join   (
           select  *
           from    winery
           where   offering_tours_flag is true
       ) wot
on     p.winery_id = wot.winery_id;

-- Subquery
select region_name
from   region
where  country_id =
(
    select country_id
    from   country
    where  country_name = 'USA'
);

-- Running just the subquery by itself returns 3
select country_id
from   country
where  country_name = 'USA';

-- Which makes our whole query evaluate to
select region_name
from   region
where  country_id = 3;

-- A subquery that returns an error. The outer query expects one rows back from the inner query,
-- but the inner query returns more than one row
select region_name
from   region
where  country_id = 
(
    select country_id
    from   country
--  where  country_name = 'USA' -  line commented out
);

-- Using "in" instead of = fixes the error
select region_name
from   region
where  country_id in
(
    select country_id
    from   country
--  where  country_name = 'USA' -  line commented out
);

-- Creating pay database for the correlated subquery example below
create database pay;

use pay;

create table employee
	(
	employee_name	varchar(100),
	department		varchar(100),
	salary			numeric(10,2)
);

insert into employee (employee_name, department, salary) values ('Wanda Wealthy', 'Sales', 200000);
insert into employee (employee_name, department, salary) values ('Paul Poor', 'Sales', 12000);
insert into employee (employee_name, department, salary) values ('Mike Mediocre', 'Sales', 70000);
insert into employee (employee_name, department, salary) values ('Betty Builder', 'Manufacturing', 80000);
insert into employee (employee_name, department, salary) values ('Sean Soldering', 'Manufacturing', 80000);
insert into employee (employee_name, department, salary) values ('Ann Assembly', 'Manufacturing', 65000);

create table best_paid
	(
	department	varchar(100),
	salary		numeric(10,2)
);

insert into best_paid (department, salary) values ('Sales', 200000);
insert into best_paid (department, salary) values ('Manufacturing', 80000);

-- Correlated subquery
select	employee_name,
		salary
from	employee e
where	salary =
		(
		select  b.salary
		from    best_paid b
		where   b.department = e.department
		);

-- Switching back to the wine database
use wine;

-- Creating the best_wine_contest table for the union example below
create table best_wine_contest
(
	wine_name  varchar(100),
    place		int
);

insert into best_wine_contest (wine_name, place) values ('Riesling',1);
insert into best_wine_contest (wine_name, place) values ('Pinot Grigio',2);
insert into best_wine_contest (wine_name, place) values ('Zinfandel',3);
insert into best_wine_contest (wine_name, place) values ('Malbec',4);
insert into best_wine_contest (wine_name, place) values ('Verdejo',5);

-- Using a union statement
select wine_type_name from wine_type
union
select wine_name from best_wine_contest;

-- Using "union all"
select wine_type_name from wine_type
union all
select wine_name from best_wine_contest;

-- ordering by the place column
select * 
from   best_wine_contest
order by place;

-- Limiting the results to the top 3 places
select * 
from   best_wine_contest
order by place
limit 3;


--
-- Try It Yourself Exercises
---

-- Setting up the canada database for our exercises
-- O Canada! Where pines and maples grow.

create database canada;

use canada;

create table province
	(
	province_id			int,
	province_name		varchar(100),
	official_language	varchar(20)
);
	
insert into province (province_id, province_name, official_language) values (1, 'Alberta', 'English');
insert into province (province_id, province_name, official_language) values (2, 'British Columbia', 'English');
insert into province (province_id, province_name, official_language) values (3, 'Manitoba', 'English');
insert into province (province_id, province_name, official_language) values (4, 'New Brunswick', 'English, French');
insert into province (province_id, province_name, official_language) values (5, 'Newfoundland', 'English');
insert into province (province_id, province_name, official_language) values (6, 'Nova Scotia', 'English');
insert into province (province_id, province_name, official_language) values (7, 'Ontario', 'English');
insert into province (province_id, province_name, official_language) values (8, 'Prince Edward Island', 'English'); 
insert into province (province_id, province_name, official_language) values (9, 'Quebec', 'French');
insert into province (province_id, province_name, official_language) values (10, 'Saskatchewan', 'English');

create table capital_city
	(
	city_id		int,
	city_name	varchar(100),
	province_id	int
	);

insert into capital_city (city_id, city_name, province_id) values (1, 'Toronto', 7);
insert into capital_city (city_id, city_name, province_id) values (2, 'Quebec City', 9);
insert into capital_city (city_id, city_name, province_id) values (3, 'Halifax', 5);
insert into capital_city (city_id, city_name, province_id) values (4, 'Fredericton', 4);
insert into capital_city (city_id, city_name, province_id) values (5, 'Winnipeg', 3);
insert into capital_city (city_id, city_name, province_id) values (6, 'Victoria', 2);
insert into capital_city (city_id, city_name, province_id) values (7, 'Charlottetown', 8);
insert into capital_city (city_id, city_name, province_id) values (8, 'Regina', 10);
insert into capital_city (city_id, city_name, province_id) values (9, 'Edmonton', 1);
insert into capital_city (city_id, city_name, province_id) values (10,'St. Johns', 5);
	
create table tourist_attraction
	(
	attraction_id		int,
	attraction_name		varchar(100),
	attraction_city_id	int,
	open_flag			bool
	);

insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (1, 'CN Tower', 1, true);
insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (2, 'Old Quebec', 2, true);
insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (3, 'Royal Ontario Museum', 1, true);
insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (4, 'Place Royale', 2, true);
insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (5, 'Halifax Citadel', 3, true);
insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (6, 'Garrison District', 4, true);
insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (7, 'Confederation Centre of the Arts', 7, true);
insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (8, 'Stone Hall Castle', 8, true);
insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (9, 'West Edmonton Mall', 9, true);
insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (10,'Signal Hill', 10, true);
insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (11,'Canadian Museum for Human Rights', 5, true);
insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (12,'Royal BC Museum', 6, true);
insert into tourist_attraction (attraction_id, attraction_name, attraction_city_id, open_flag) values (13,'Sunnyside Amusement Park', 1, false);

-- Creating the database for Exercise 6-1 below
create database nutrition;

use nutrition;

create table good_snack
	(
    snack_name varchar(100)
    );
    
create table bad_snack
	(
    snack_name varchar(100)
    );
	
insert into good_snack (snack_name) values ('carrots');
insert into good_snack (snack_name) values ('salad');
insert into good_snack (snack_name) values ('soup');

insert into bad_snack (snack_name) values ('sausage pizza');
insert into bad_snack (snack_name) values ('BBQ ribs');
insert into bad_snack (snack_name) values ('nachos');

-- Exercise 6-2: An inner join with three tables
select a.attraction_name,
       c.city_name,
       p.province_name
from   tourist_attraction a
join   capital_city c
  on   c.city_id = a.attraction_city_id
 and   a.open_flag is true
join   province p
  on   p.province_id = c.province_id
 and   p.official_language = 'French';
 
-- Exercise 6-3: Creating a temporary table
create temporary table open_tourist_attraction 
as
 select   attraction_city_id,
          attraction_name 
 from     tourist_attraction
 where    open_flag is true;

-- Exercise 6-4: Joining a temporary table with a permanent table
select    a.attraction_name,
          c.city_name
from      open_tourist_attraction a
join      capital_city c 
  on      c.city_id = a.attraction_city_id
 and      c.city_name = 'Toronto';
 

-- Creating databases for Exercise 6-5 below
create database attire;

use attire;

create table employee
	(
	employee_id		int,
	employee_name	varchar(100),
	position_name	varchar(100)
	);
	
insert into employee(employee_id, employee_name, position_name) values (1, 'Benedict', 'Pope');
insert into employee(employee_id, employee_name, position_name) values (2, 'Garth', 'Singer');
insert into employee(employee_id, employee_name, position_name) values (3, 'Francis', 'Pope');

create table wardrobe
	(
	employee_id	int,
	hat_size	numeric(4,2)
	);

insert into wardrobe (employee_id, hat_size) values (1, 8.25);
insert into wardrobe (employee_id, hat_size) values (2, 7.50);
insert into wardrobe (employee_id, hat_size) values (3, 6.75);

-- Exercise 6-4: To fix the query, change "where employee_id =" to "where employee_id in"
select 	employee_id,
        hat_size
from    wardrobe
where   employee_id in
(
        select   employee_id
        from     employee
        where    position_name = 'Pope'
);
	

-- Exercise 6-5: To fix the query, change "where employee_id =" to "where employee_id in"
select snack_name from good_snack 
union
select snack_name from bad_snack;

-- Create the database for Exercises 6-6 - 6-8 below
create database monarchy;

use monarchy;

create table royal_family
(
	name		varchar(200),
	birthdate	date
);

insert into royal_family (name, birthdate) values ('Prince Louis of Cambridge', '2018-04-23');
insert into royal_family (name, birthdate) values ('Princess Charlotte of Cambridge', '2015-05-02');
insert into royal_family (name, birthdate) values ('Prince George of Cambridge', '2013-07-22');
insert into royal_family (name, birthdate) values ('Prince William, Duke of Cambridge', '1982-06-21');
insert into royal_family (name, birthdate) values ('Catherine, Duchess of Cambridge', '1982-01-09');
insert into royal_family (name, birthdate) values ('Charles, Prince of Whales','1948-11-14');
insert into royal_family (name, birthdate) values ('Queen Elizabeth II', '1926-04-21');
insert into royal_family (name, birthdate) values ('Prince Andrew, Duke of York', '1960-02-19');

-- Exercise 6-6: Select from royal_family table and order by birthdate
select * from royal_family order by birthdate;

-- Exercise 6-7: Select the oldest royal in the table
select * from royal_family order by birthdate limit 1;

-- Exercise 6-8: Select the youngest 3 royals in the table
select * from royal_family order by birthdate desc limit 3;
