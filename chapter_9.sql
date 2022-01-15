-- 
-- MySQL Crash Course
-- 
-- Chapter 9 – Inserting, Updating, and Deleting Data						
--
-- You can copy and paste any of these commands into your favorite MySQL tool
-- (like MySQL Workbench) and run them in your own MySQL environment.
--
create database building;

use building;

create table arena (
    arena_id          int,
    arena_name        varchar(100),
    location          varchar(100),
    seating_capacity  int
);

insert into arena
    (
    arena_id,
    arena_name, 
    location, 
    seating_capacity
    )
values 
    (
    1,
    'Madison Square Garden',
    'New York',
    20000
    );

select * from arena;

insert into arena
    (
    arena_id,
    arena_name, 
    location, 
    seating_capacity
    )
values 
    (
    2,
    'Dean Smith Center',
    'North Carolina',
    null
    );

-- Let's remove the row we just inserted and insert the same row in a different way
delete from arena where arena_id = 2;

-- This insert statement does the same thing.
-- If we don't list the seating_capacity at all, it will be set to null.
insert into arena
    (
    arena_id,
    arena_name, 
    location
    )
values 
    (
    2,
    'Dean Smith Center',
    'North Carolina'
    );

select  *
from    arena
where   arena_id = 2;

insert into arena (arena_id, arena_name, location, seating_capacity)
values (3, 'Philippine Arena', 'Bocaue', 55000);

insert into arena (arena_id, arena_name, location, seating_capacity) 
values (4, 'Sportpaleis', 'Antwerp', 23359);

insert into arena (arena_id, arena_name, location, seating_capacity) 
values (5, 'Bell Centre', 'Montreal', 22114);

-- We could achieve the same results by combining them all in one insert statement:

-- First, let's remove the rows we just inserted and inserted them in a different way
delete from arena where arena_id in (3, 4, 5);

insert into arena (arena_id, arena_name, location, seating_capacity)
values (3, 'Philippine Arena', 'Bocaue', 55000),
       (4, 'Sportpaleis', 'Antwerp', 23359),
       (5, 'Bell Centre', 'Montreal', 22114);

-- Inserting a row without listing column names  :-(
insert into arena 
values (6, 'Staples Center', 'Los Angeles', 19060);

select * from arena;

-- Let's drop and recreate the arena table and have the arena_id automatically increment
drop table arena;

create table arena (
    arena_id          int            primary key       auto_increment,
    arena_name        varchar(100),
    location          varchar(100),
    seating_capacity  int
);

-- Reloading the data without having to manage the arena_id column
insert into arena (arena_name, location, seating_capacity)
values ('Madison Square Garden', 'New York', 20000);

insert into arena (arena_name, location, seating_capacity)
values ('Dean Smith Center', 'North Carolina', null);

insert into arena (arena_name, location, seating_capacity)
values ('Philippine Arena', 'Bocaue', 55000);

insert into arena (arena_name, location, seating_capacity) 
values ('Sportpaleis', 'Antwerp', 23359);

insert into arena (arena_name, location, seating_capacity) 
values ('Bell Centre', 'Montreal', 22114);

insert into arena (arena_name, location, seating_capacity) 
values ('Staples Center', 'Los Angeles', 19060);

select * from arena;


create table large_building
	(
	building_type      varchar(50),
	building_name      varchar(100),
	building_location  varchar(100),
	building_capacity  int,
	active_flag        bool
);

insert into large_building values ('Hotel', 'Wanda Inn', 			'Cape Cod', 125,	true);
insert into large_building values ('Arena', 'Yamada Green Dome', 	'Japan', 	20000,	true);
insert into large_building values ('Arena', 'Oracle Arena', 		'Oakland', 	19596,	true);

select  building_name,
        building_location,
        building_capacity
from    large_building
where   building_type = 'Arena'
and     active_flag is true;

-- Let's use the same query to insert into the arena table
insert into arena (
        arena_name, 
        location,
        seating_capacity
)
select  building_name,
        building_location,
        building_capacity 
from    large_building
where   building_type = 'Arena'
and     active_flag is true;

select * from arena;

-- Creating a table based on a query
create table new_arena as
select  building_name,
        building_location,
        building_capacity 
from    large_building
where   building_type = 'Arena'
and     active_flag is true;

select * from new_arena;

desc new_arena;

-- Making a copy of the arena table using today's date _(YYYYMMDD) as a suffix
create table arena_20241125  as 
select * from arena;

-- Here are three ways we could change Staples Center to Crypto.com Arena:
update  arena
set     arena_name = 'Crypto.com Arena'
where   arena_id = 6;

update  arena
set     arena_name = 'Crypto.com Arena'
where   arena_name = 'Staples Center';

update  arena
set     arena_name = 'Crypto.com Arena'
where   location = 'Los Angeles';

-- Set the seating_capacity for arenas with an ID of more than 3 to 20,000
update  arena
set     seating_capacity = 20000
where   arena_id > 3;

-- Set the seating_capacity for all arenas to 15,000
update  arena
set     seating_capacity = 15000;

-- Set the seating_capacity of arena 6 to 19,100
update  arena
set     arena_name = 'Crypto.com Arena',
        seating_capacity = 19100
where   arena_id = 6;

delete from arena
where arena_id = 2;

select * from arena;

-- Delete all arenas that have the text "Arena" somewhere in their name
delete from arena
where arena_name like '%Arena%';

select * from arena;

-- Deleting arena 459237 does nothing because there is no such arena in the table.
delete from arena
where arena_id = 459237;

-- Delete all arenas
delete from arena;

-- Delete all arenas fast
truncate table arena;

-- Remove the entire table
drop table arena;




-- Try It Yourself Exercises:

-- Exercise 9-1: Create food database, favorite_meal table, and insert rows into the table
create database food;

use food;

create table favorite_meal
(
    meal	varchar(50),
	price	numeric(5,2)
);

-- HERE ARE 3 DIFFERENT WAYS TO INSERT THE ROWS. PICK THE FORMAT YOU LIKE BEST:
insert into favorite_meal 
	(
		meal, 
		price
	)
values
	(
		'Pizza', 
		7.22
	);
	
insert into favorite_meal 
	(
		meal, 
		price
	)
values
	(
		'Cheeseburger', 
		8.41
	);
	
insert into favorite_meal 
	(
		meal, 
		price
	)
values
	(
		'Salad', 
		9.57
	);

-- Or, reformatted, we could write the insert statements like this:
insert into favorite_meal (meal, price) values ('Pizza', 7.22);
insert into favorite_meal (meal, price) values ('Cheeseburger', 8.41);
insert into favorite_meal (meal, price) values ('Salad', 9.57);

-- Or even:
insert into favorite_meal (meal, price)
values 
	('Pizza', 7.22),
	('Cheeseburger', 8.41),
	('Salad', 9.57);

-- Exercise 9-2: Inserting college data
create database education;

use education;

create table college
	(
	college_name			varchar(100),
	location				varchar(50),
	undergrad_enrollment	int
	);
	
insert into college (college_name, location, undergrad_enrollment) 
values ('Princeton University', 'New Jersey', 4773);

insert into college (college_name, location, undergrad_enrollment) 
values ('Massachusetts Institute of Technology', 'Massachusetts', 4361);

insert into college (college_name, location, undergrad_enrollment) 
values ('Oxford University', 'Oxford', 11955);

select * from college;

-- Exercise 9-3: Increase prices by 20%
use food;

update favorite_meal
set    price = price * 1.2;

-- Exercise 9-4: Remove Pizza from the favorite_meal table
delete from favorite_meal
where meal = 'Pizza';
