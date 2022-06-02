-- 
-- MySQL Crash Course
-- 
-- Chapter 18 – Using Views to Hide Salary Data							
--
-- You can copy and paste any of these commands into your favorite MySQL tool
-- (like MySQL Workbench) and run them in your own MySQL environment.
--
-- Run this script as a user who has privs to create tables and grant permissions, like "root"
drop database if exists business;

create database business;

use business;

create table employee
	(
	employee_id		int					primary key 	auto_increment,
	first_name		varchar(100)		not null,
	last_name		varchar(100)		not null,
	department		varchar(100)		not null,
	job_title		varchar(100)		not null,
	salary			decimal(15,2)		not null
	);

insert into employee(first_name, last_name, department, job_title, salary)
values ('Jean',' Unger', 'Accounting', 'Bookkeeper', 81200);

insert into employee(first_name, last_name, department, job_title, salary)
values ('Brock', 'Warren', 'Accounting', 'CFO', 246000);

insert into employee(first_name, last_name, department, job_title, salary)
values ('Ruth', 'Zito', 'Marketing', 'Creative Director', 178000);

insert into employee(first_name, last_name, department, job_title, salary)
values ('Ann', 'Ellis', 'Technology', 'Programmer', 119500);

insert into employee(first_name, last_name, department, job_title, salary)
values ('Todd', 'Lynch', 'Legal', 'Compliance Manager', 157000);

create view v_employee as
select	employee_id,
		first_name,
		last_name,
		department,
		job_title
from	employee;

-- You can run these commands using the 'root' account that got created when you installed MySQL
drop user if exists accounting_user@localhost;
drop user if exists marketing_user@localhost;
drop user if exists techology_user@localhost;
drop user if exists legal_user@localhost;
drop user if exists hr_user@localhost;

create user accounting_user@localhost identified by 'accounting_password';
create user marketing_user@localhost identified by 'marketing_password';
create user technology_user@localhost identified by 'technology_password';
create user legal_user@localhost identified by 'legal_password';
create user hr_user@localhost identified by 'hr_password';

grant select, delete, insert, update on business.employee to hr_user@localhost;

grant select on business.v_employee to hr_user@localhost;
grant select on business.v_employee to accounting_user@localhost;
grant select on business.v_employee to marketing_user@localhost;
grant select on business.v_employee to legal_user@localhost;
grant select on business.v_employee to technology_user@localhost;

-- Exercise 18-1
create view v_employee_fn_dept as
select	first_name,
		department
from	employee;

select * from v_employee_fn_dept;
