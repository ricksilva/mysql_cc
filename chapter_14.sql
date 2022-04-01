-- 
-- MySQL Crash Course
-- 
-- Chapter 14 – Tips and Tricks							
--
-- You can copy and paste any of these commands into your favorite MySQL tool
-- (like MySQL Workbench) and run them in your own MySQL environment.
--
create database distribution;

-- don't forget the USE!
use distribution;

create table employee
  (
    employee_id     int            primary key,
    employee_name   varchar(100),
    tee_shirt_size  varchar(3)
  );

select database();

select table_schema,
       create_time
from   information_schema.tables
where  table_name = 'employee';

create database car_dealership;

use car_dealership;

create table inventory
	(
	vin		char(17),
	mfg		varchar(100),
	model	varchar(100),
	color	varchar(100)
	);
	
insert into inventory(vin, mfg, model, color) values ('1ADCQ67RFGG234561','Ford', 		'Mustang',	'red');
insert into inventory(vin, mfg, model, color) values ('2XBCE65WFGJ338565','Toyota', 	'RAV4', 	'orange');
insert into inventory(vin, mfg, model, color) values ('3WBXT62EFGS439561','Volkswagen', 'Golf', 	'black');
insert into inventory(vin, mfg, model, color) values ('4XBCX68RFWE532566','Ford', 		'Focus', 	'green');
insert into inventory(vin, mfg, model, color) values ('5AXDY62EFWH639564','Ford', 		'Explorer', 'yellow');
insert into inventory(vin, mfg, model, color) values ('6DBCZ69UFGQ731562','Ford', 		'Escort', 	'white');
insert into inventory(vin, mfg, model, color) values ('7XBCX21RFWE532571','Ford', 		'Focus', 	'black');
insert into inventory(vin, mfg, model, color) values ('8AXCL60RWGP839567','Toyota', 	'Prius', 	'gray');
insert into inventory(vin, mfg, model, color) values ('9XBCX11RFWE532523','Ford', 		'Focus', 	'red');

-- This "where clause" is not complete. It will update every Ford Focus!
update  inventory
set     color = 'blue'
where   mfg = 'Ford'
and     model = 'Focus';
-- and    color = 'green';

-- Let's look at the data for Ford Focuses (Foci?)
select *
from   inventory
where  mfg = 'Ford'
and    model = 'Focus';

update inventory
set    color = 'blue'
where  vin = '4XBCX68RFWE532566';

delete from inventory
where vin = '8AXCL60RWGP839567';

select *
from   inventory
where  mfg = 'Ford'
and    model = 'Focus';


start transaction;

update inventory
set    color = 'blue'
where  mfg = 'Ford'
and    model = 'Focus';

rollback;
-- or commit;


create database investment;

use investment;

create table market_index
	(
    market_index	varchar(100),
    market_value   decimal(10,2)
    );

load data local infile 'c:/Users/rick/market/market_indexes.txt' into table market_index;

select * from market_index;



-- Move this to EXERCISES file?
create database travel;

use travel;

create table zoo
	(
	zoo_name	varchar(100),
	country		varchar(100)
	);
	
insert into zoo	(zoo_name, country) values ('Beijing Zoo', 'China');
insert into zoo	(zoo_name, country) values ('Berlin Zoological Garden', 'Germany');
insert into zoo	(zoo_name, country) values ('Bronx Zoo', 'USA');
insert into zoo	(zoo_name, country) values ('Ueno Zoo', 'Japan');
insert into zoo	(zoo_name, country) values ('Singapore Zoo', 'Singapore');
insert into zoo	(zoo_name, country) values ('Chester Zoo', 'England');
insert into zoo	(zoo_name, country) values ('San Diego Zoo', 'USA');
insert into zoo	(zoo_name, country) values ('Toronto Zoo', 'Canada');
insert into zoo	(zoo_name, country) values ('Korkeasaari Zoo', 'Finland');
insert into zoo	(zoo_name, country) values ('Henry Doorly Zoo', 'USA');
