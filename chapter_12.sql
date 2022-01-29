-- 
-- MySQL Crash Course
-- 
-- Chapter 12 – Creating Triggers						
--
-- You can copy and paste any of these commands into your favorite MySQL tool
-- (like MySQL Workbench) and run them in your own MySQL environment.
--

-- Create the tables for the chapter
create database accounting;

use accounting;

-- Create a table for account payable data for a company
create table payable
	(
	payable_id	int,
	company		varchar(100),
	amount		numeric(8,2),
	service		varchar(100)
	);
	
insert into payable
	(
	payable_id,
	company,
	amount,
	service
	)
values
	(1, 'Acme HVAC', 		 	 123.32,	'Repair of Air Conditioner'),
	(2, 'Initech Printers',		1459.00,	'New Printers'),
	(3, 'Hooli Cleaning',		4398.55,	'Janitorial Services');
	
-- Create the payable_audit table that will track changes to the payable table
create table payable_audit
	(
	audit_datetime	datetime,
	audit_user		varchar(50),
	audit_change	varchar(500)
	);
	
-- Create an after insert trigger	
drop trigger if exists tr_payable_ai;

delimiter //

create trigger tr_payable_ai
  after insert on payable
  for each row
begin
  insert into payable_audit
	(
      audit_datetime,
      audit_user,
      audit_change
    )
  values
    (
      now(),
	  user(),
	  concat(
		  'New row for payable_id ',
		  new.payable_id,
		  '. Company: ',
		  new.company,
		  '. Amount: ',
		  new.amount,
		  '. Service: ',
		  new.service
	  )
	);
end//

delimiter ;

-- Insert a row into the payable table to test the insert trigger
insert into payable
	(
	  payable_id,
      company,
      amount,
      service
    )
values
	(
	  4,
	  'Sirius Painting',
      451.45,
      'Painting the lobby'
    );
	
-- Did a row get logged in the payable_audit table showing what was inserted into the payable table?
select * from payable_audit;

-- Create an after delete trigger
use accounting;

drop trigger if exists tr_payable_ad;

delimiter //

create trigger tr_payable_ad
  after delete on payable
  for each row
begin
  insert into payable_audit
    (
      audit_datetime,
      audit_user,
      audit_change
    )
  values
    (
      now(),
      user(),
      concat(
        'Deleted row for payable_id ',
        old.payable_id,
        '. Company: ',
        old.company,
       '. Amount: ',
       old.amount,
       '. Service: ',
       old.service
    )
  );
end//

delimiter ;	

-- Delete a row from the payable table to test the delete trigger
delete from payable where company = 'Sirius Painting';

-- Is there a row in the payable_audit table that logs the deleted row from the payable table?
select * from payable_audit;

-- Create an after update trigger
delimiter //

create trigger tr_payable_au
  after update on payable
  for each row
begin
  set @change_msg = 
	concat(
		'Updated row for payable_id ',
		old.payable_id
	);

  if (old.company != new.company) then
    set @change_msg = 
	  concat(
		@change_msg,
		'. Company changed from ',
		old.company,
		' to ',
		new.company
	  );
  end if;
	
  if (old.amount != new.amount) then
    set @change_msg = 
	  concat(
		@change_msg,
		'. Amount changed from ',
		old.amount,
		' to ',
		new.amount
	  );
  end if;
	
  if (old.service != new.service) then
    set @change_msg = 
	  concat(
		@change_msg,
		'. Service changed from ',
		old.service,
		' to ',
		new.service
	  );
  end if;
	
  insert into payable_audit
	(
      audit_datetime,
      audit_user,
      audit_change
    )
  values
    (
      now(),
	  user(),
	  @change_msg
  );
	
end//

delimiter ;

-- Test the trigger by updating a row
update payable
set    amount = 100000,
       company = 'House of Larry'
where  payable_id = 3;

-- Did the update get logged?
select * from payable_audit;

create database bank;

use bank;

create table credit
	(
	customer_id		int,
	customer_name	varchar(100),
	credit_score	int
	);
	
-- Create a before insert trigger	
drop trigger if exists tr_credit_bi;

delimiter //

create trigger tr_credit_bi
  before insert on credit
  for each row
begin
  if (new.credit_score < 300) then
	set new.credit_score = 300;
  end if;
  
  if (new.credit_score > 850) then
	set new.credit_score = 850;
  end if;
 
 end//

delimiter ;

-- Test the trigger by inserting some values into the credit table
insert into credit
	(
	customer_id,
	customer_name,
	credit_score
	)
values
	(1,	'Milton Megabucks',	  987),
	(2,	'Patty Po', 		  145),
	(3, 'Vinny Middle-Class', 702);
	
-- Create the before delete trigger	
use bank;

delimiter //

create trigger tr_credit_bd
 before delete on credit
  for each row
begin
  if (old.credit_score > 750) then
     signal sqlstate '45000'
       set message_text = 'Cannot delete scores over 750';
  end if;

end//

delimiter ;

-- Test the trigger
delete from credit where customer_id = 1;
delete from credit where customer_id = 2;

-- Try it Yourself Exercises

-- Set up for chapter 12 exercises
create database jail;

use jail;

create table alcatraz_prisoner
	(
	prisoner_id		int,
	prisoner_name	varchar(100)
	);
	
insert into alcatraz_prisoner
	(
	prisoner_id,
	prisoner_name
	)
values
	(85,	'Al Capone'),
	(594,	'Robert Stroud'),
	(1476, 	'John Anglin');

-- Exercise 12-1: Create the audit table
create table alcatraz_prisoner_audit
	(
	audit_datetime	datetime,
	audit_user		varchar(100),
	audit_change	varchar(200)
	);

-- Exercise 12-2: Create and test a before insert audit trigger
use jail;

drop trigger if exists tr_alcatraz_prisoner_ai;

-- Create the trigger
delimiter //

 create trigger tr_alcatraz_prisoner_ai
  after insert on alcatraz_prisoner
  for each row
begin
  insert into alcatraz_prisoner_audit
  (
    audit_datetime,
    audit_user,
    audit_change
  )
  values
  (
    now(),
    user(),
    concat(
      'New row for Prisoner ID ',
      new.prisoner_id,
      '. Prisoner Name: ',
      new.prisoner_name
    )
  );
end//

delimiter ;

-- Test the trigger by inserting a new prisoner
insert into alcatraz_prisoner
  (
    prisoner_id,
    prisoner_name
  )
values
  (
    117,
    'Machine Gun Kelly'
  );

-- Did the row get inserted into the alcatraz_prisoner table?
select * from alcatraz_prisoner;

-- Did the new prisoner get logged in the audit table?
select * from alcatraz_prisoner_audit;

-- Set up for exercise 12-3
create database exam;

use exam;

create table grade
	(
	student_name	varchar(100),
	score 			int
	);
	
insert into grade
	(
	student_name,
	score
	)
values
	('Billy',79),
	('Jane', 87),
	('Paul', 93);
	
-- Exercise 12-3: Create the trigger
use exam;

delimiter //

create trigger tr_grade_bu 
  before update on grade
  for each row
begin
  if (new.score < 50) then
    set new.score = 50;
  end if;
  
  if (new.score > 100) then
    set new.score = 100;
  end if;
 
end//

delimiter ;

-- Test the trigger by updating some grades
update grade set score = 38  where student_name = 'Billy';
update grade set score = 107 where student_name = 'Jane';
update grade set score = 95  where student_name = 'Paul';

-- Are there no grades lower than 50 or higher than 100?
select * from grade;
