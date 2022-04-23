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
	station_id		int             primary key,
	station_city	varchar(100),
	station_state	char(2),
	station_lat		decimal(6,4)    not null,
	station_lon		decimal(7,4)    not null,
	as_of_dt		datetime,
	temp 			int             not null,
	feels_like		int,
	wind			int,
	wind_direction	varchar(3),
	precipitation   decimal(3,1),
	pressure		decimal(6,2),
    visibility      decimal(3,1)    not null,
	humidity		int,
	weather_desc	varchar(100)    not null,
	sunrise			time,
	sunset			time,
	constraint cwl_station_lat    check(station_lat between -90 and 90),
	constraint cwl_station_lon    check(station_lon between -180 and 180),
	constraint cwl_temp           check(temp between -50 and 150),
	constraint cwl_feels_like     check(feels_like between -50 and 150),
	constraint cwl_wind           check(wind between 0 and 300),
	constraint cwl_wind_direction check(wind_direction in (
	    'N','S','E','W','NE','NW','SE','SW',
	    'NNE','ENE','ESE','SSE','SSW','WSW','WNW','NNW')
	),
	constraint cwl_precipitation  check(precipitation between 0 and 400),
	constraint cwl_pressure       check(pressure between 0 and 1100),
	constraint cwl_visibility     check(visibility between 0 and 20),
	constraint cwl_humidity       check(humidity between 0 and 100)
);

drop table if exists current_weather;

create table current_weather like current_weather_load;

-- Create a "trucking" user with the password "Roger".
create user trucking@localhost identified by 'Roger';
grant all privileges on weather.* to trucking@localhost;
