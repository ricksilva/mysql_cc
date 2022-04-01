-- 
-- MySQL Crash Course
-- 
-- Chapter 16 – Creating a Weather Database and Loading Data						
--
-- You can copy and paste any of these commands into your favorite MySQL tool
-- (like MySQL Workbench) and run them in your own MySQL environment.
--
create database weather;

use weather;

drop table if exists current_weather_load;

create table current_weather_load
(
	station_id		int              primary key,
	station_city	varchar(100),
	station_state	char(2),
	station_lat		decimal(6,4),
	station_lon		decimal(7,4),
	as_of_dt		varchar(14),
	temp 			int,
	feels_like		int,
	wind			int,
	wind_direction	varchar(10),
	precipitation   decimal(3,1),
	pressure		decimal(4,2),
    visibility      decimal(3,1),
	humidity		int,
	weather_desc	varchar(100),
	sunrise			time,
	setset			time
);
 
 
create table current_weather
(
	station_id		int              primary key,
	station_city	varchar(100),
	station_state	char(2),
	station_lat		decimal(6,4),
	station_lon		decimal(7,4),
	as_of_dt		datetime,
	temp 			int,
	feels_like		int,
	wind			int,
	wind_direction	varchar(10),
	precipitation   decimal(3,1),
	pressure		decimal(4,2),
    visibility      decimal(3,1),
	humidity		int,
	weather_desc	varchar(100),
	sunrise			time,
	setset			time
);
 
 
 
load data local infile 'C:/Users/silva/mysql_book/GitHub/mysql_cc/chapter_16/weather.csv' 
into table weather.current_weather_load
fields terminated by ',';
 
 
select * from weather.current_weather_load;
	
	
	
	
	
	
	select STR_TO_DATE('20240211 13:26','%Y%m%d %H:%i');