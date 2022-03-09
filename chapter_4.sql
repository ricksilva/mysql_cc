-- 
-- MySQL Crash Course
-- 
-- Chapter 4 – MySQL Data Types								
--
-- You can copy and paste any of these commands into your favorite MySQL tool
-- (like MySQL Workbench) and run them in your own MySQL environment.
--
create database mysqldatatype;

use mysqldatatype;

create table solar_eclipse
(
	eclipse_date				date,
	time_of_greatest_eclipse	time,
	eclipse_type				varchar(10),
	magnitude					numeric(4,3)
);
	
insert into solar_eclipse (
	eclipse_date, 
	time_of_greatest_eclipse,
    eclipse_type,
	magnitude
	)
values 
	('2022-04-30', '20:42:36', 'Partial', 0.640),
	('2022-10-25', '11:01:20', 'Partial', 0.862),
	('2023-04-20', '04:17:56', 'Hybrid', 1.013);
	
create table animal 
	(
    animal_name	    varchar(20),
    animal_desc     tinytext,
    animal_picture  mediumblob
    );	
	
insert into animal 
	(
    animal_name,
    animal_desc,
    animal_picture
    )
    values
    (
    'T-Rex',
    'T-Rex lived in western North America on what was then an island continent known as Laramidia 68 to 66 million years ago.',
    'C:\Users\location\T-Rex.jpg' -- This assumes you have a T-Rex image at this location
    );
	
insert into animal 
	(
    animal_name,
    animal_desc,
    animal_picture
    )
    values
    (
	'Lemur',
    'Lemurs are wet-nosed primates from the Lemuroidea family. They are native to the island of Madagascar.',
    'C:\Users\location\lemur.jpg' -- This assumes you have a lemur image at this location
    );

insert into animal 
	(
    animal_name,
    animal_desc,
    animal_picture
    )
    values
    (
	'Blue Dragon',
    'The Blue Dragon or Glaucus Atlanticus floats upside down and uses its blue side to blend into the water. It looks like a small dragon.',
    'C:\Users\location\blue_dragon.jpg' -- This assumes you have a Blue Dragon image at this location
    );
	
create table country_code
(
    country_code    char(3)
);

create table interesting_people
(
    interesting_name    varchar(100)
);

-- This will fail with a message that tells you what your maximum size for a varchar is
create table test_varchar_size
(
    huge_column varchar(999999999)
);

create table student
	(
	student_id     int,
	student_class  enum('Freshman','Sophomore','Junior','Senior')
	);

create table interpreter
    (
    interpreter_id     int,
    language_spoken    set('English','German','French','Spanish')
    );
	
create table book
    (
    book_id            int,
    author_bio         tinytext,
    book_proposal      text,
    entire_book        mediumtext
    );

create table store
	(
	store_name	varchar(100)
	);
	
insert into store
	(
	store_name
	)
values
	('Town Supply'),
	("Bill's Supply");

-- Strings with single quotes
select  * 
from    store 
where   store_name = 'Town Supply';

-- Strings with double quotes
select  *
from    store
where   store_name = "Town Supply";

-- This SQL causes an error because the single quote is the same character as the apostrophe.
-- I commented it out so it won't prevent the next SQL statements from running in your MySQL Workbench environment.
-- select  *
-- from    store
-- where   store_name = 'Bill's Supply';

-- Using double quotes here clears up the problem
select  *
from    store 
where   store_name = "Bill's Supply";

-- Or you can use single quotes and escape the apostrophe
select  *
from    store
where   store_name = 'Bill\'s Supply';


create table encryption
    (
    key_id          int,
    encryption_key  binary(50)
    );

create table signature
    (
    signature_id    int,
    signature       varbinary(400)
    );
	
create table planet_stat 
(
	planet            varchar(20),
	miles_from_earth  bigint,
	diameter_km       mediumint
);

insert into planet_stat (planet, miles_from_earth, diameter_km) values ('Mars',		48678219,   6792);
insert into planet_stat (planet, miles_from_earth, diameter_km) values ('Jupiter',	390674712,  142984);
insert into planet_stat (planet, miles_from_earth, diameter_km) values ('Saturn',	792248279,  120536);
insert into planet_stat (planet, miles_from_earth, diameter_km) values ('Uranus',	1692662533, 51118);
insert into planet_stat (planet, miles_from_earth, diameter_km) values ('Neptune',	2703959966, 49528);

-- Let's drop and recreate planet_stat with the miles column redefined as an unsigned int
drop table planet_stat;

create table planet_stat 
(
    planet            varchar(20),
    miles_from_earth  int unsigned, -- Now using int unsigned, not bigint
    diameter_km       mediumint
);

insert into planet_stat (planet, miles_from_earth, diameter_km) values ('Jupiter',	390674712,  142984);
insert into planet_stat (planet, miles_from_earth, diameter_km) values ('Saturn',	792248279,  120536);
insert into planet_stat (planet, miles_from_earth, diameter_km) values ('Uranus',	1692662533, 51118);
insert into planet_stat (planet, miles_from_earth, diameter_km) values ('Neptune',	2703959966, 49528);

create table food
(
    food              varchar(30),
    organic_flag      bool,
    gluten_free_flag  bool
);


-- Exercise 4-1:
create database rapper;

use rapper;

create table album
(
	rapper_id				smallint unsigned,
	album_name				varchar(100),
	explicit_lyrics_flag 	bool,
	album_revenue 			decimal(12,2),
	album_content 			longblob
);
