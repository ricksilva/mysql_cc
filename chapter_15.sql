-- 
-- MySQL Crash Course
-- 
-- Chapter 15 – Calling MySQL from Programming Languages						
--
-- You can copy and paste any of these commands into your favorite MySQL tool
-- (like MySQL Workbench) and run them in your own MySQL environment.
--
create database topography;

use topography;

create table mountain
	(
	mountain_name	varchar(100),
	location		varchar(100),
	height			int
	);
	
insert into mountain (mountain_name, location, height) values ('Mount Everest', 'Asia', 29029);
insert into mountain (mountain_name, location, height) values ('Aconcagua', 'South America', 22841);
insert into mountain (mountain_name, location, height) values ('Denali', 'North America', 20310);
insert into mountain (mountain_name, location, height) values ('Mount Kilimanjaro', 'Africa', 19341);

drop procedure if exists p_get_mountain_by_loc;

delimiter //
create procedure p_get_mountain_by_loc(
	location_param varchar(100)
)
begin
    select  mountain_name,
            height
    from    mountain
    where   location = location_param;
end//

delimiter ;

-- There are also Java, PHP, and Python programs that access MySQL in the chapter_15 subdirectory.
