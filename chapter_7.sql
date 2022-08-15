-- 
-- MySQL Crash Course
-- 
-- Chapter 7 – Comparing Values							
--
-- You can copy and paste any of these commands into your favorite MySQL tool
-- (like MySQL Workbench) and run them in your own MySQL environment.
--

-- Using =

-- The wine database was created in chapter_6.sql
use wine;

select  *
from    country
where   country_id = 3;

select  *
from    wine_type
where   wine_type_name = 'Merlot';

select  c.country_name
from    country c
join    region r
  on    c.country_id = r.country_id;

select *
from   region
where  country_id =
(
    select country_id
    from   country
    where  country_name = 'USA'
);

-- create a database called compval for several of the examples showing value comparisons
create database compval;

use compval;

create table musical_instrument
	(
	instrument	varchar(100)
	);

insert into musical_instrument (instrument)
values 	
	('guitar'), 
	('banjo'), 
	('piano');

-- Using "not equal" (!=)
select  *
from    musical_instrument
where   instrument != 'banjo';

create table possible_wedding_date
	(
	wedding_date	date
	);
	
insert into possible_wedding_date
values
('2024-02-11'),
('2024-03-17'),
('2024-02-14');

-- Using "not equal" (<>)
select  *
from    possible_wedding_date
where   wedding_date <> '2024-02-11';

create table job
	(
	job			varchar(100),
	salary		int,
	start_date	date
	);
	
insert into job
	(
	job,
	salary,
	start_date
	)
values
	('Programmer',	100000, '2024-06-01'),
	('Manager', 	222000, '2021-01-15'),	
	('Teacher', 	35000,  '2024-03-01');

-- Greater than
select  *
from    job
where   salary > 100000
and     start_date > '2024-01-20';

-- Greater than or equal to
select  *
from    job
where   salary >= 100000
and     start_date >= '2024-01-20';

create table team_schedule
	(
	opponent	varchar(100),
	game_date	date,
	game_time	time
	);
	
insert into team_schedule
	(
	opponent,
	game_date,
	game_time
	)
values
	('Destroyers','2024-01-24','22:00'),
	('Stray Cats','2024-02-03','10:00'),
	('Bombers','2024-03-17','23:00');

-- Less than
select *
from   team_schedule
where  game_time < '22:00';

-- Less than or equal to 
select *
from   team_schedule
where  game_time <= '22:00';

create table employee
	(
	emp_name		varchar(50),
	retirement_date	date
	);
	
insert into employee
	(
	emp_name,
	retirement_date
	)
values
	('Alfred','2034-01-08'),
	('Latasha','2029-11-17'),
	('Nancy', null),
	('Chuck', null),
	('Mitch', null);

-- Is null
select  *
from    employee
where   retirement_date is null;

-- Don't do this. Don't use "= null". The correct syntax is "IS null"
select *
from   employee
where  retirement_date = null;

-- Is not null
select *
from   employee
where  retirement_date is not null;

-- Don't do this. Don't use "!= null". The correct syntax is "IS NOT null"
select *
from   employee
where  retirement_date != null;

-- In

-- switch back to the wine database
use wine;

create table cheap_wine
	(
	wine_type_name	varchar(100)
	);
	
insert into cheap_wine
	(wine_type_name)
values
	('Chardonnay');

select  *
from    wine_type
where   wine_type_name in ('Chardonnay', 'Riesling');

select  *
from    wine_type
where   wine_type_name in 
        (
        select  wine_type_name
        from    cheap_wine
        );

-- Not in
select  *
from    wine_type
where   wine_type_name not in ('Chardonnay', 'Riesling');

select  *
from    wine_type
where   wine_type_name not in 
        (
        select  wine_type_name
        from    cheap_wine
        );


-- Switch back to the compval database
use compval;

create table customer
	(
	customer_name	varchar(50),
	birthyear		year
	);
	
insert into customer
	(
	customer_name,
	birthyear
	)
values
	('Helen', 1947),
	('Zippy', 1985),
	('Junior', 2021);

-- Between
select  *
from    customer
where   birthyear between 1981 and 1996;

-- Not between
select  *
from    customer
where   birthyear not between 1981 and 1996;

create table billionaire
	(
	first_name	varchar(100),
	last_name	varchar(100)
	);
	
insert into billionaire
	(
	first_name,
	last_name
	)
values
	('Elon',		'Musk'),
	('Jacqueline',	'Mars'),
	('John',		'Mars'),
	('Andrey',		'Melnichenko'),
	('Jeff',		'Bezos'),
	('Bill',		'Gates'),
	('Mark',		'Zuckerberg');

-- Like
select  * 
from    billionaire
where   last_name like 'M%';	

select  * 
from    billionaire
where   last_name like '%e%';

create table three_letter_term
	(
	term	char(3)
	);

insert into three_letter_term
	(
	term
	)
values
	('cat'),
	('hat'),
	('bat'),
	('dog'),
	('egg'),
	('ape');

select  * 
from    three_letter_term
where   term like '_at';

-- Not like
select  * 
from    three_letter_term
where   term not like '_at';

select  * 
from    billionaire
where   last_name not like 'M%';

-- Exists
select 'There is at least one millennial in this table'
where exists
(
    select  *
    from    customer
    where   birthyear between 1981 and 1996
);

-- Same query using "select 1" instead of "select *"
select 'There is at least one millennial in this table'
where exists
(
    select  1
    from    customer
    where   birthyear between 1981 and 1996
);

create table bachelor
	(
		name			varchar(100),
		employed_flag	bool
	);
	
insert into bachelor
	(
	name,
	employed_flag
	)
values
	('Hector Handsome', true),
	('Frank Freeloader', false);
	
-- checking a boolean column
select  *
from    bachelor
where   employed_flag is true;

select  *
from    bachelor
where   employed_flag is false;

-- Ways to check for true
select * from bachelor where employed_flag is true;
select * from bachelor where employed_flag;
select * from bachelor where employed_flag = true;
select * from bachelor where employed_flag != false;
select * from bachelor where employed_flag = 1;
select * from bachelor where employed_flag != 0;

-- Ways to check for false
select * from bachelor where employed_flag is false;
select * from bachelor where not employed_flag;
select * from bachelor where employed_flag = false;
select * from bachelor where employed_flag != true;
select * from bachelor where employed_flag = 0;
select * from bachelor where employed_flag != 1;

create table applicant
	(
	name					varchar(100),
	associates_degree_flag	bool,
	bachelors_degree_flag	bool,
	years_experience		int
	);
	
insert into applicant
	(
	name,
	associates_degree_flag,
	bachelors_degree_flag,
	years_experience
	)
values 
	('Joe Smith', 0, 1, 7),
	('Linda Jones', 1, 0, 2),
	('Bill Wang', 0, 1, 1),
	('Sally Gooden', 1, 0,0),
	('Katy Daly', 0, 0, 0);

-- Using OR
select  *
from    applicant
where   bachelors_degree_flag is true
or      years_experience >= 2;

-- This query returns unexpected results
select  *
from    applicant
where   years_experience >= 2
and     associates_degree_flag is true
or      bachelors_degree_flag is true;

-- Adding parentheses gives us the results we expected
select  *
from    applicant
where   years_experience >= 2
and     (
        associates_degree_flag is true
or      bachelors_degree_flag is true
        );



-- Try It Yourself Exercises

-- Create a database for Exercise 7-1
create database band;

use band;

create table musician
	(
	musician_name	varchar(100),
	phone			varchar(20),
	musician_type	varchar(100)
	);
	
insert into musician values ('Diva DeLuca', 		'615-758-7836', 'Opera Singer');
insert into musician values ('Skeeter Sullivan', 	'629-209-2332', 'Bluegrass Singer');
insert into musician values ('Tex Macaroni', 		'915-789-1721', 'Country Singer');
insert into musician values ('Bronzy Bohannon', 	'212-211-1216', 'Sax Player');

-- Exercise 7-1: Finding Singers from Nashville
select * from musician
where (
      phone like '615%'
or    phone like '629%'
      )
and   musician_type like '%Singer%';


-- Create a database for Exercise 7-2
create database airport;

use airport;

create table boarding
	(
	passenger_name		varchar(100),
	license_flag		bool,
	student_id_flag		bool,
	soc_sec_card_flag	bool 
	);
	
insert into boarding values ('Frank Flyer', true, false, false);
insert into boarding values ('Rhonda Runway', false, false, true);
insert into boarding values ('Sam Suitcase', false, true, true);
insert into boarding values ('Pam Prepared', true, true, true);
insert into boarding values ('Sally Stowaway', false, false, false);

-- Exercise 7-2: Grouping conditions using parentheses
select  *
from    boarding
where   license_flag is true
and     (
        student_id_flag is true
or      soc_sec_card_flag is true
		);
