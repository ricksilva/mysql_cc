-- 
-- MySQL Crash Course
-- 
-- Chapter 10 – Creating Views
--
-- You can copy and paste any of these commands into your favorite MySQL tool
-- (like MySQL Workbench) and run them in your own MySQL environment.
--
create database mysqlview;

use mysqlview;

create table course
	(
	course_name		varchar(100),
	course_level	varchar(50)
	);
	
insert into course values ('Introduction to Python', 'beginner');
insert into course values ('Introduction to HTML', 'beginner');
insert into course values ('React Full-Stack Web Development', 'advanced');
insert into course values ('Object-Oriented Design Patterns in Java', 'advanced');
insert into course values ('Practical Linux Administration', 'advanced');
insert into course values ('Learn JavaScript', 'beginner');
insert into course values ('Advanced Hardware Security', 'advanced');

create view v_course_beginner as 
select  *
from    course
where   course_level = 'beginner';

select * from v_course_beginner;

create view v_course_advanced as 
select  *
from    course
where   course_level = 'advanced';

select * from v_course_advanced;

create table company
	(
    company_id			int,
    company_name 		varchar(200),
    owner				varchar(100),
    owner_phone_number	varchar(20)
    );

create table complaint
	(
       complaint_id		int,
       company_id		int,
       complaint_desc	varchar(200)
    );

insert into company values (1, 'Catywampas Cellular', 'Sam Shady', '784-785-1245');
insert into company values (2, 'Wooden Nickle Bank', 'Oscar Opossum', '719-997-4545');
insert into company values (3, 'Pitiful Pawn Shop', 'Frank Fishy', '917-185-7911');

insert into complaint  values (1, 1, "Phone doesn't work");
insert into complaint  values (2, 1, 'Wiki is on the blink');
insert into complaint  values (3, 1, 'Customer Service is bad');
insert into complaint  values (4, 2, 'Bank closes too early');
insert into complaint  values (5, 3, 'My iguana died');
insert into complaint  values (6, 3, 'Police confiscated my purchase');

create view v_complaint as
select   a.company_name,
         a.owner,
         a.owner_phone_number,
         count(*)
from     company a
join     complaint b
on       a.company_id = b.company_id
group by a.company_name,
		 a.owner,
         a.owner_phone_number;

create view v_complaint_public as
select   a.company_name,
         count(*)
from     company a
join     complaint b
on       a.company_id = b.company_id
group by a.company_name;

select * from v_complaint_public;

-- This update will work
update  v_course_beginner
set     course_name = 'Introduction to Python 3.1'
where   course_name = 'Introduction to Python';

-- This update will not work. 
update  v_complaint
set     owner_phone_number = '578-982-1277'
where   owner = 'Sam Shady';

drop view v_course_advanced;


-- Try It Yourself Exercises
create database corporate;

use corporate;

create table employee
	(
	employee_name	varchar(100),
	department		varchar(50),
	position		varchar(100),
	home_address    varchar(200),
	date_of_birth	date
	);
	
insert into employee values ('Sidney Crumple', 'accounting', 'Accountant', '123 Credit Road', '1997-01-04');
insert into employee values ('Al Ledger', 'accounting', 'Bookkeeper', '2 Revenue Street', '2002-11-22');
insert into employee values ('Bean Counter', 'accounting', 'Manager', '8 Double Entry Place', '1996-04-29');
insert into employee values ('Lois Crumple', 'accounting', 'Accountant', '123 Debit Lane', '2007-08-27');
insert into employee values ('Loretta Hardsell', 'sales', 'Sales Rep', '66 Hawker Street', '2000-07-09');
insert into employee values ('Bob Closer', 'sales', 'Sales Rep', '73 Peddler Way', '1999-02-16');

-- Exercise 10-1: Create a view called v_employee_accounting with all the employees in the accounting department
create view v_employee_accounting as 
select  *
from    employee
where   department = 'accounting';

-- Exercise 10-2: Create a view called v_employee_sales with all the employees in the sales department
create view v_employee_sales as 
select  *
from    employee
where   department = 'sales';

-- Exercise 10-3: Create a view called v_employee_private that hides the home address and date of birth
create view v_employee_private as 
select  employee_name,
        department,
		position
from    employee;

select * from v_employee_accounting;
select * from v_employee_sales;
select * from v_employee_private;
