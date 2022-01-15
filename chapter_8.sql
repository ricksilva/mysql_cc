-- 
-- MySQL Crash Course
-- 
-- Chapter 8 – Calling Built-In MySQL Functions						
--
-- You can copy and paste any of these commands into your favorite MySQL tool
-- (like MySQL Workbench) and run them in your own MySQL environment.
--

create database callfunc;

use callfunc;

select pi();

select upper('rofl');

select datediff('2024-12-25', '2024-11-28');

select round(2.71828);

select round(2.71828, 2);

-- A function within a function
select round(pi());

-- The same SQL formatted on multiple lines for people who find this clearer
select round(
         pi()
       );

create table movie (
	movie_name		varchar(100),
	star_rating 	float,
	release_date	date
);

insert into movie
	(
	movie_name,
	star_rating,
	release_date
	)
values
	('Exciting Thriller', 	4.72,	'2024-09-27'),
	('Bad Comedy', 			1.2,	'2025-01-02'),
	('OK Horror', 			3.1789,	'2024-10-01');

select upper(movie_name),
       round(star_rating)
       from movie
where  star_rating > 3
and    year(release_date) <= 2024;

-- The land database and the continent table were created in chapter_2.sql
use land;

select  count(*) 
from    continent;

select  count(*)
from    continent
where   population > 1000000000;

select max(population) 
from   continent;

-- Switch back to the callfunc database
use callfunc;

create table train
	(
	train	varchar(100),
	mile	int
	);
	
insert into train
	(
	train,
	mile
	)
values
	('The Chief', 8000),
	('Flying Scotsman', 6500),
	('Golden Arrow', 2133);
	
select   * 
from     train
where    mile =
(
  select max(mile)
  from   train
);

-- Switch back to the "land" database
use land;

select min(population) 
from   continent;

select sum(population) 
from   continent;

select avg(population) 
from   continent;

select    *
from      continent
where     population <
(
  select  avg(population)
  from    continent
);

-- Switching back to the callfunc database
use callfunc;

create table sale
	(
	sale_id				int,
	customer_name		varchar(100),
	salesperson_name	varchar(50),
	amount				numeric(7,2)
	);
	
insert into sale
	(
	sale_id,
	customer_name,
	salesperson_name,
	amount
	)
values
	(1,	'Bill McKenna',	'Sally',	12.34),
	(2,	'Carlos Souza',	'Sally',	28.28),
	(3,	'Bill McKenna',	'Tom',		9.72),
	(4,	'Bill McKenna',	'Sally',	17.54),
	(5,	'Jane Bird',	'Tom',		34.44);

select sum(amount) 
from   sale
group by customer_name;

select sum(amount) 
from   sale
group by salesperson_name;

select  sum(amount)
from    sale;

select count(*)
from   sale
group by salesperson_name;

select   avg(amount)
from     sale 
group by salesperson_name;

select  salesperson_name,
        avg(amount)
from    sale 
group by salesperson_name;

create database vacation;

use vacation;

create table theme_park
	(
	country varchar(50),
	state	varchar(50),
	city	varchar(100),
	park  	varchar(100)
	);
	
insert into theme_park
values
	('USA',		'Florida',			'Orlando',				'Disney World'),
	('USA',		'Florida',			'Orlando',				'Universal Studios'),
	('USA',		'Florida',			'Orlando',				'SeaWorld'),
	('USA',		'Florida',			'Tampa',				'Busch Gardens'),
	('Brazil',	'Santa Catarina',	'Balneario Camboriu',	'Unipraias Park'),
	('Brazil',	'Santa Catarina',	'Florianopolis',		'Show Water Park');

select country,
       state,
       count(*)      
from   theme_park;

select country,
       state,
       count(*)      
from   theme_park
group by country,
       state;

-- Switching back to the callfunc database
use callfunc;

create table phone_book
	(
	first_name	varchar(100),
	last_name	varchar(100)
	);
	
insert into phone_book
	(
	first_name,
	last_name
	)
values
	('Jennifer','Perez'),
	('Richard','Johnson'),
	('John','Moore');

select  concat(first_name, ' ', last_name)
from    phone_book;

-- Switch back to the "land" database
use land;

select  population
from    continent
where   continent_name = 'Asia';

select format(population, 0)
from   continent;

select format(1234567.89, 5);

-- Switching back to the callfunc database
use callfunc;

create table taxpayer
	(
	last_name	varchar(100),
	soc_sec_no	varchar(20)
	);
	
insert into taxpayer
	(
	last_name,
	soc_sec_no
	)
values
	('Jagger', 		'478-555-7598'),
	('McCartney', 	'478-555-1974'),
	('Hendrix',		'478-555-3555');

select  last_name,
        left(last_name, 3)
from    taxpayer;

select  right(soc_sec_no, 4)
from    taxpayer;

select  lower(last_name)
from    taxpayer;

select  upper(last_name)
from    taxpayer;

select  last_name 
from    taxpayer
where   upper(last_name) = upper('Mccartney');


select substring('gumbo', 1, 3);

select substring('gumbo', -3, 2);

select substring('MySQL', 3);

select substring('gumbo' from 1 for 3);

select trim(leading  '*' from '**instructions**') as column1,
       trim(trailing '*' from '**instructions**') as column2,
       trim(both     '*' from '**instructions**') as column3,
       trim(         '*' from '**instructions**') as column4;

select trim('   asteroid   ');

select ltrim('   asteroid   ');

select rtrim('   asteroid   ');

select curdate();

select curtime();

select now();

create table event
	(
	event_id			int,
	eclipse_datetime	datetime
	);
	
insert into event
	(
	event_id,
	eclipse_datetime
	)
values 
	(
	374,
	'2024-10-25 11:01:20'
	);

select  eclipse_datetime,
        date_add(eclipse_datetime, interval 5 day)  as add_5_days,
        date_add(eclipse_datetime, interval 4 hour) as add_4_hours,
        date_add(eclipse_datetime, interval 2 week) as add_2_weeks
from    event
where   event_id = 374;

select  eclipse_datetime,
        date_sub(eclipse_datetime, interval 5 day)  as sub_5_days,
        date_sub(eclipse_datetime, interval 4 hour) as sub_4_hours,
        date_sub(eclipse_datetime, interval 2 week) as sub_2_weeks
from    event
where   event_id = 374;

select  eclipse_datetime,
        extract(year from eclipse_datetime)   as year,
        extract(month from eclipse_datetime)  as month,
        extract(day from eclipse_datetime)    as day,
        extract(week from eclipse_datetime)   as week,
        extract(second from eclipse_datetime) as second
from    event
where   event_id = 374;

select  eclipse_datetime,
        year(eclipse_datetime)   as year,
        month(eclipse_datetime)  as month,
        day(eclipse_datetime)    as day,
        week(eclipse_datetime)   as week,
        second(eclipse_datetime) as second
from    event
where   event_id = 374;

select  eclipse_datetime,
        date(eclipse_datetime)   as date,
        time(eclipse_datetime)   as time
from    event
where   event_id = 374;

select datediff('2024-05-05', '2024-01-01');

select  date_format('2024-02-02 01:02:03', '%r') as format1,
        date_format('2024-02-02 01:02:03', '%m') as format2,
        date_format('2024-02-02 01:02:03', '%M') as format3,
        date_format('2024-02-02 01:02:03', '%Y') as format4,
        date_format('2024-02-02 01:02:03', '%y') as format5,
        date_format('2024-02-02 01:02:03', '%W, %M %D at %T') as format6;

select  time_format(curtime(), '%H:%i:%s')                            as format1,
        time_format(curtime(), '%h:%i %p')                            as format2,
        time_format(curtime(), '%l:%i %p')                            as format3,
        time_format(curtime(), '%H hours, %i minutes and %s seconds') as format4,
        time_format(curtime(), '%r')                                  as format5,
        time_format(curtime(), '%T')                                  as format6;

create table payroll
	(
	employee	varchar(100),
	salary		decimal(10,2),
	deduction	decimal(10,2),
	bonus		decimal(10,2),
	tax_rate	decimal(5,2)
	);

insert into payroll
	(
	employee,
	salary,
	deduction,
	bonus,
	tax_rate
	)
values
	('Max Bain',	80000,	5000,	10000,	0.24),
	('Lola Joy',	60000,	0,		800,	0.18),
	('Zoe Ball',	110000,	2000,	30000,	0.35);

select  employee,
        salary - deduction,
        salary + bonus,
        salary * tax_rate,
        salary / 12,
        salary div 12
from    payroll;

create table roulette_winning_number
	(
	winning_number	int
	);

insert into roulette_winning_number
	(
	winning_number
	)
values
	(21), 
	(8), 
	(13);

select  winning_number,
        winning_number % 2
from    roulette_winning_number;

-- These queries all return the same value: winning_number mod 2
select winning_number % 2     from roulette_winning_number;
select winning_number mod 2   from roulette_winning_number;
select mod(winning_number, 2) from roulette_winning_number;

select  winning_number,
        if (winning_number % 2 = 1, 
            'even',
            'odd'
           )
from    roulette_winning_number;

select  employee, 
        salary,
        bonus,
        tax_rate,
        salary + bonus * tax_rate
from    payroll;


create table jelly_bean
	(
	guesser	varchar(100),
	guess	int
	);
	
insert into jelly_bean
	(
	guesser,
	guess
	)
values
	('Ruth', 	275),
	('Henry',	350),
	('Ike',		305);
	
select  guesser,
        guess,
        300          as actual,
        300 - guess  as difference
from    jelly_bean;

select  guesser,
        guess,
        300 as actual,
        abs(300 – guess) as difference
from    jelly_bean;

select  * 
from    jelly_bean
where   abs(300 - guess) = 
(
    select  min(abs(300 - guess))
    from    jelly_bean
);

select ceiling(3.29);

select floor(3.29);

-- These both return 33 because the argument is a whole number
select 	ceiling(33),
		floor(33);
		
select degrees(pi());

select radians(180);

select exp(2);

select log(2);

select log(2, 8);

select mod(7,2);

select pow(5,3);

select round(9.87654321, 3);

select truncate(9.87654321, 3);

select truncate(9.87654321, 0);

select sin(2);

select cos(2);

select sqrt(16);

create table test_score
	(
	score	int
	);
	
insert into test_score
	(
	score
	)
values
	(70),(82),(97);
	
select  stddev_pop(score)
from    test_score;

select tan(3.8);

create table online_order
	(
	order_datetime	datetime
	);
	
insert into online_order
	(
	order_datetime
	)
values
	('2024-12-08 11:39:09'),
	('2024-12-10 10:11:14');
	
select  order_datetime 
from    online_order;

select  cast(order_datetime as date)
from    online_order;


select coalesce(null, null, 42);

create table candidate
	(
	employee_name	varchar(100),
	employer		varchar(100)
	);
	
insert into candidate
	(
	employee_name,
	employer
	)
values
	('Jim Miller',		'Acme Corp'),
	('Laura Garcia',	'Globex'),
	('Jacob Davis', 	null);

select employee_name,
       coalesce(employer, 'Between Jobs')
from   candidate;

create table customer
	(
	customer_name  varchar(100),
	country			varchar(100)
	);
	
insert into customer
	(
	customer_name,
	country
	)
values
	('Venkat Gupta','India'),
	('Joey Cheeseburger','USA'),
	('Mary Merica','USA'),
	('Sally Stars','USA'),
	('Sam Singh','India'),
	('Tom Gomez','Peru');

select country
from   customer;

select distinct(country)
from   customer;

-- This syntax returns the same result
select distinct country
from   customer;

select count(distinct country)
from   customer;

-- Which database are you in?
select database();

create table test_result
	(
    student_name	varchar(50),
    grade			int
    );

insert into test_result
	(
	student_name,
	grade
	)
values
	('Lisa',	98),
	('Bart',    41),
	('Nelson',	11);

select  student_name,
        if(grade > 59, 'pass', 'fail')
from    test_result;

select  student_name,
case
  when grade < 30 then 'Please retake this exam'
  when grade < 60 then 'Better luck next time'
  else 'Good job'
end
from test_result;

-- What version of MySQL are you running?
select version();



-- Exercise 8-1: Calling the lower() function with an argument of 'E.E. Cummings'.
select lower('E.E. Cummings');

-- Exercise 8-2: Call the now() function with no arguments.
select now();

-- Create the music database for Exercise 8-3 and 8-4:
create database music;

use music;

create table genre_stream
	(
	genre	varchar(100),
	stream	int
	);
	
insert into genre_stream
	(
	genre,
	stream
	)
values
	('R&B, Hip Hop', 		3102456),
	('Rock',				1577569),
	('Pop',					1298756),
	('Country',				764789),
	('Latin',				601758),
	('Dance, Electronic',	308745);
	
-- Exercise 8-3: Count the rows in the genre_stream table
select count(*) from genre_stream;

-- Exercise 8-4: Get the average streams for all genres in the genre_stream table
select avg(stream) from genre_stream;

-- Exercise 8-5: Get the count of theme parks in each country
use vacation;

select country,
       count(*)
from   theme_park
group by country;

-- Exercise 8-6: Get the zip_codes and parts of the zip code
create database mail;

use mail;

create table address(zip_code varchar(20));

insert into address values (94103);
insert into address values (37188);
insert into address values (96718);

select zip_code,
       substr(zip_code, 1, 1) as national_area,
       substr(zip_code, 2, 2) as sectional_center,
       substr(zip_code, 4, 2) as associate_post_office
from   address;

-- Exercise 8-7: Calculate how many days until the Brisbane Summer Olympics on July 23, 2032
select  datediff('2032-07-23', curdate());

-- Exercise 8-8: How many kilometers the moon? It's 252,088 miles X 1.60934. Round the result.
select round(252088 * 1.60934);

-- Create the electricity database for Exercise 8-9:
create database electricity;

use electricity;

create table electrician (
	name varchar(100), 
	years_experience int
	);

insert into electrician 
	(
	name,
	years_experience
	)
values 
	('Zach Zap', 1),
	('Wanda Wiring', 6),
	('Larry Light', 21);

-- Exercise 8-9: The case statement was displaying Zach Zap as an Apprentice because the WHEN lines were in the wrong order.
-- Reverse the "when" conditions because once a condition is met, the case statement returns and stops looking for a match.
select  name,
case
  when years_experience < 5 then 'Journeyman'
  when years_experience < 10 then 'Apprentice'
  else 'Master Electrician'
end
from    electrician;
