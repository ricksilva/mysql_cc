-- 
-- MySQL Crash Course
-- 
-- Chapter 13 – Creating Events							
--
-- You can copy and paste any of these commands into your favorite MySQL tool
-- (like MySQL Workbench) and run them in your own MySQL environment.
--

-- Is your event scheduler on?
show variables like 'event_scheduler';

-- Create event e_cleanup_payable_audit
use bank;

drop event if exists e_cleanup_payable_audit;

delimiter //

create event e_cleanup_payable_audit
 on schedule every 1 month
 starts '2024-01-01 10:00'
do 
begin
  delete from payable_audit
  where audit_datetime < date_sub(now(), interval 1 year);
end //

delimiter ;

-- Create p_account_update() to set up for the event e_account_update
-- The procedure does nothing. It just displays a message so we have a procedure to call.
use bank;

drop procedure if exists p_account_update;

delimiter //

create procedure p_account_update()
begin
  select 'Running p_account_update()';
end//

delimiter ;

-- Show the events scheduled
show events;

-- Create event e_account_update
use bank;

drop event if exists e_account_update;

delimiter //

create event e_account_update
on schedule at '2024-03-10 00:01'
do 
begin
  call p_account_update();
end //

delimiter ;

-- Create table current_time_zone to set up for event e_change_to_dst
use bank;

create table current_time_zone
	(
	time_zone varchar(10)
	);
	
insert into current_time_zone
	(
	time_zone
	)
values 
	(
	'EST'
	);

-- Create event e_change_to_dst
use bank;

drop event if exists e_change_to_dst;

delimiter //

create event e_change_to_dst
on schedule 
at '2024-03-10 1:59'
do
begin
  -- Make any changes to our application needed for DST
  update current_time_zone
  set    time_zone = 'EDT';
end //

delimiter ;

-- Any event errors?
select *
from   performance_schema.error_log
where  data like '%Event Scheduler%';

-- Any event errors for the event "e_account_update"?
select  *
from    performance_schema.error_log
where   data like '%e_account_update%';

-- Try it Yourself exercises

-- Set up for exercise 13-1:
create database eventful;

use eventful;

create table event_message
	(
	message  varchar(100)
	);

-- Exercise 13-1: Create e_write_timestamp event
use eventful;

drop event if exists e_write_timestamp;

delimiter //

create event e_write_timestamp
  on schedule every 1 minute
  starts current_timestamp
  ends current_timestamp + interval 5 minute
do
begin 
  insert into event_message (message)
  values (current_timestamp);
end //

delimiter ;

-- Exercise 13-2: Check for errors
select  *
from    performance_schema.error_log
where   data like '%e_write_timestamp%';

-- Exercise 13-3: Check for new records being inserted every minute
select * from event_message;
