-- 
-- MySQL Crash Course
-- 
-- Chapter 17 – Using Triggers to Prevent Errors and Track Changes to Voter Data						
--
-- You can copy and paste any of these commands into your favorite MySQL tool
-- (like MySQL Workbench) and run them in your own MySQL environment.
--
-- To find answers to particular exercises, search through this file for the exercise number, like "17-5"

-- Exercise 17-1 is to create these voting database and tables:
drop database if exists voting;

create database voting;

use voting;

-- Creating the data tables
create table voter
	(
	voter_id				int				primary key 	auto_increment, -- automatically inserts a voter_id value (answers exercise 17-3)
	voter_name				varchar(100)	not null,
	voter_address			varchar(100)	not null,
	voter_county			varchar(50)		not null,
	voter_district			varchar(10)		not null,
	voter_precinct			varchar(10)		not null,
	voter_party				varchar(20),
	voting_location			varchar(100)	not null,
	voter_registration_num	int 			not null		unique
	);

create table ballot
	(
	ballot_id				int				primary key 	auto_increment,
	voter_id				int				not null		unique,
	ballot_type				varchar(10)		not null,
	ballot_cast_datetime	datetime		not null,
	constraint foreign key (voter_id) references voter(voter_id),
	constraint check(ballot_type in ('in-person', 'absentee'))
	);

create table race
	(
	race_id					int				primary key 	auto_increment,
	race_name				varchar(100)	not null		unique,
	votes_allowed           int             not null
	);
	
create table candidate
	(
	candidate_id			int				primary key 	auto_increment,
	race_id					int				not null,
	candidate_name			varchar(100)	not null        unique,
	candidate_address		varchar(100)	not null,
	candidate_party			varchar(20),
	incumbent_flag			bool,
	constraint foreign key (race_id) references race(race_id)
	);	
	
create table ballot_candidate
	(
	ballot_id				int,
	candidate_id			int,
	primary key (ballot_id, candidate_id),
	constraint foreign key (ballot_id) references ballot(ballot_id),
	constraint foreign key (candidate_id) references candidate(candidate_id)
	);
-- End of Exercise 17-1

-- Creating the audit tables
create table voter_audit
  (
    audit_datetime  datetime,
    audit_user      varchar(100),
    audit_change    varchar(1000)
  );

create table ballot_audit
  (
    audit_datetime  datetime,
    audit_user      varchar(100),
    audit_change    varchar(1000)
  );

create table race_audit
  (
    audit_datetime  datetime,
    audit_user      varchar(100),
    audit_change    varchar(1000)
  );

create table candidate_audit
  (
    audit_datetime  datetime,
    audit_user      varchar(100),
    audit_change    varchar(1000)
  );

create table ballot_candidate_audit
  (
    audit_datetime  datetime,
    audit_user      varchar(100),
    audit_change    varchar(1000)
  );

-- Creating the "after insert" triggers
-- tr_voter_ai
drop trigger if exists tr_voter_ai;

delimiter //

create trigger tr_voter_ai
  after insert on voter
   for each row
begin
  insert into voter_audit
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
      'New voter added -',
	  ' voter_id: ', 				new.voter_id,
	  ' voter_name: ',				new.voter_name,
	  ' voter_address: ',			new.voter_address,
	  ' voter_county: ',		    new.voter_county,
	  ' voter_district: ',			new.voter_district,
	  ' voter_precinct: ',			new.voter_precinct,
	  ' voter_party: ',				new.voter_party,
	  ' voting_location: ',			new.voting_location,
	  ' voter_registration_num: ',	new.voter_registration_num
    )
  );
end//

delimiter ;

-- Exercise 17-5 is to create this tr_ballot_ai trigger:
drop trigger if exists tr_ballot_ai;

delimiter //

create trigger tr_ballot_ai
  after insert on ballot
   for each row
begin
  insert into ballot_audit
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
      'New ballot added -',
	  ' ballot_id ',				new.ballot_id,
	  ' voter_id: ', 				new.voter_id,
	  ' ballot_type: ',				new.ballot_type,
	  ' ballot_cast_datetime: ',    new.ballot_cast_datetime
    )
  );
end//

delimiter ;
-- End of Exercise 17-5

-- tr_race_ai
drop trigger if exists tr_race_ai;

delimiter //

create trigger tr_race_id
  after insert on race
   for each row
begin
  insert into race_audit
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
      'New race added -',
	  ' race_id ',				new.race_id,
	  ' race_name: ', 			new.race_name
    )
  );
end//

delimiter ;

-- tr_candidate_ai
drop trigger if exists tr_candidate_ai;

delimiter //

create trigger tr_candidate_ai
  after insert on candidate
   for each row
begin
  insert into candidate_audit
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
      'New candidate added -',
	  ' candidate_id ',				new.candidate_id,
	  ' race_id: ', 				new.race_id,
	  ' candidate_name: ',			new.candidate_name,
	  ' candidate_address: ',		new.candidate_address,
	  ' candidate_party: ',			new.candidate_party,
	  ' incumbent_flag: ',			new.incumbent_flag
    )
  );
end//

delimiter ;

-- tr_ballot_candidate_ai
drop trigger if exists tr_ballot_candidate_ai;

delimiter //

create trigger tr_ballot_candidate_ai
  after insert on ballot_candidate
   for each row
begin
  insert into ballot_candidate_audit
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
      'New ballot_candidate row added -',
	  ' ballot_id ',				new.ballot_id,
	  ' candidate_id: ', 			new.candidate_id
    )
  );
end//

delimiter ;

-- Create the after delete triggers
-- tr_voter_ad
drop trigger if exists tr_voter_ad;

delimiter //

create trigger tr_voter_ad
  after delete on voter
  for each row
begin
  insert into voter_audit
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
      'voter deleted -',
	  ' voter_id: ', 				old.voter_id,
	  ' voter_name: ',				old.voter_name,
	  ' voter_address: ',			old.voter_address,
	  ' voter_county: ',		    old.voter_county,
	  ' voter_district: ',			old.voter_district,
	  ' voter_precinct: ',			old.voter_precinct,
	  ' voter_party: ',				old.voter_party,
	  ' voting_location: ',			old.voting_location,
	  ' voter_registration_num: ',	old.voter_registration_num
    )
  );
end//

delimiter ;

-- Exercise 17-6:
-- tr_ballot_ad
drop trigger if exists tr_ballot_ad;

delimiter //

create trigger tr_ballot_ad
  after delete on ballot
  for each row
begin
  insert into ballot_audit
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
      'ballot deleted -',
	  ' ballot_id: ', 				old.ballot_id,
	  ' voter_id: ', 				old.voter_id,
	  ' ballot_type: ',				old.ballot_type,
	  ' ballot_cast_datetime: ',	old.ballot_cast_datetime
    )
  );
end//

delimiter ;
-- End of Exercise 17-6

-- tr_race_ad
drop trigger if exists tr_race_ad;

delimiter //

create trigger tr_race_ad
  after delete on race
  for each row
begin
  insert into race_audit
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
      'race deleted -',
	  ' race_id: ', 		old.race_id,
	  ' race_name: ',		old.race_name
    )
  );
end//

delimiter ;

-- tr_candidate_ad
drop trigger if exists tr_candidate_ad;

delimiter //

create trigger tr_candidate_ad
  after delete on candidate
  for each row
begin
  insert into candidate_audit
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
      'candidate deleted -',
	  ' candidate_id: ', 			old.candidate_id,
	  ' race_id: ', 				old.race_id,  
	  ' candidate_name: ',			old.candidate_name,
	  ' candidate_address: ',		old.candidate_address,
	  ' candidate_party: ',			old.candidate_party,
	  ' incumbent_flag: ',			old.incumbent_flag
    )
  );
end//

delimiter ;

-- tr_ballot_candidate_ad
drop trigger if exists tr_ballot_candidate_ad;

delimiter //

create trigger tr_ballot_candidate_ad
  after delete on ballot_candidate
  for each row
begin
  insert into ballot_candidate_audit
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
      'ballot_candidate row deleted -',
	  ' ballot_id: ', 		old.ballot_id,  
	  ' candidate_id: ', 	old.candidate_id
    )
  );
end//

delimiter ;

-- Create the "after update" triggers
-- tr_voter_au 
drop trigger if exists tr_voter_au;

delimiter //

create trigger tr_voter_au
  after update on voter
  for each row
begin
  set @change_msg = concat('voter ',old.voter_id,' updated');

  if new.voter_id != old.voter_id then
    set @change_msg = concat(@change_msg, concat('. voter_id changed from ', old.voter_id, ' to ', new.voter_id));
  end if;

  if new.voter_name != old.voter_name then
    set @change_msg = concat(@change_msg, concat('. voter_name changed from ', old.voter_name, ' to ', new.voter_name));
  end if;
  
  if new.voter_address != old.voter_address then
    set @change_msg = concat(@change_msg, concat('. voter_address changed from ', old.voter_address, ' to ', new.voter_address));
  end if;

  if new.voter_county != old.voter_county then
    set @change_msg = concat(@change_msg, concat('. voter_county changed from ', old.voter_county, ' to ', new.voter_county));
  end if;
  
  if new.voter_district != old.voter_district then
    set @change_msg = concat(@change_msg, concat('. voter_district changed from ', old.voter_district, ' to ', new.voter_district));
  end if;

  if new.voter_precinct != old.voter_precinct then
    set @change_msg = concat(@change_msg, concat('. voter_precinct changed from ', old.voter_precinct, ' to ', new.voter_precinct));
  end if;

  if new.voter_party != old.voter_party then
    set @change_msg = concat(@change_msg, concat('. voter_party changed from ', old.voter_party, ' to ', new.voter_party));
  end if;

  if new.voting_location != old.voting_location then
    set @change_msg = concat(@change_msg, concat('. voting_location changed from ', old.voting_location, ' to ', new.voting_location));
  end if;  
  
  if new.voter_registration_num != old.voter_registration_num then
    set @change_msg = concat(@change_msg, concat('. voter_registration changed from ', old.voter_registration_num, ' to ', new.voter_registration_num));
  end if;
  
insert into voter_audit(audit_datetime, audit_user, audit_change)   
values (now(), user(), @change_msg);
  
end//

delimiter ;

-- Exercise 17-7: Create the tr_ballot_au trigger
-- tr_ballot_au 
drop trigger if exists tr_ballot_au;

delimiter //

create trigger tr_ballot_au
  after update on ballot
  for each row
begin
  set @change_msg = concat('ballot ',old.ballot_id,' updated');

  if new.ballot_id != old.ballot_id then
    set @change_msg = concat(@change_msg, concat('. ballot_id changed from ', old.ballot_id, ' to ', new.ballot_id));
  end if;
  
  if new.voter_id != old.voter_id then
    set @change_msg = concat(@change_msg, concat('. voter_id changed from ', old.voter_id, ' to ', new.voter_id));
  end if;
  
  if new.ballot_type != old.ballot_type then
    set @change_msg = concat(@change_msg, concat('. ballot_type changed from ', old.ballot_type, ' to ', new.ballot_type));
  end if;

  if new.ballot_cast_datetime != old.ballot_cast_datetime then
    set @change_msg = concat(@change_msg, concat('. ballot_cast_datetime changed from ', old.ballot_cast_datetime, ' to ', new.ballot_cast_datetime));
  end if;
  
insert into ballot_audit(audit_datetime, audit_user, audit_change)   
values (now(), user(), @change_msg);
  
end//

delimiter ;
-- End of Exercise 17-7

-- tr_race_au 
drop trigger if exists tr_race_au;

delimiter //

create trigger tr_race_au
  after update on race
  for each row
begin
  set @change_msg = concat('race ',old.race_id,' updated');

  if new.race_id != old.race_id then
    set @change_msg = concat(@change_msg, concat('. race_id changed from ', old.race_id, ' to ', new.race_id));
  end if;
  
  if new.race_name != old.race_name then
    set @change_msg = concat(@change_msg, concat('. race_name changed from ', old.race_name, ' to ', new.race_name));
  end if;
  
insert into race_audit(audit_datetime, audit_user, audit_change)   
values (now(), user(), @change_msg);
  
end//

delimiter ;

-- tr_candidate_au 
drop trigger if exists tr_candidate_au;

delimiter //

create trigger tr_candidate_au
  after update on candidate
  for each row
begin
  set @change_msg = concat('candidate ',old.candidate_id,' updated');

  if new.candidate_id != old.candidate_id then
    set @change_msg = concat(@change_msg, concat('. candidate_id changed from ', old.candidate_id, ' to ', new.candidate_id));
  end if;

  if new.race_id != old.race_id then
    set @change_msg = concat(@change_msg, concat('. race_id changed from ', old.race_id, ' to ', new.race_id));
  end if;

  if new.candidate_name != old.candidate_name then
    set @change_msg = concat(@change_msg, concat('. candidate_name changed from ', old.candidate_name, ' to ', new.candidate_name));
  end if;
  
  if new.candidate_address != old.candidate_address then
    set @change_msg = concat(@change_msg, concat('. candidate_address changed from ', old.candidate_address, ' to ', new.candidate_address));
  end if;

  if new.candidate_party != old.candidate_party then
    set @change_msg = concat(@change_msg, concat('. candidate_party changed from ', old.candidate_party, ' to ', new.candidate_party));
  end if;

  if new.incumbent_flag != old.incumbent_flag then
    set @change_msg = concat(@change_msg, concat('. incumbent_flag changed from ', old.incumbent_flag, ' to ', new.incumbent_flag));
  end if;  

insert into candidate_audit(audit_datetime, audit_user, audit_change)   
values (now(), user(), @change_msg);
  
end//

delimiter ;

-- tr_ballot_candidate_au 
drop trigger if exists tr_ballot_candidate_au;

delimiter //

create trigger tr_ballot_candidate_au
  after update on ballot_candidate
  for each row
begin
  set @change_msg = concat('ballot_candidate changed for ballot_id ',old.ballot_id,', candidate_id ',old.candidate_id);

  if new.ballot_id != old.ballot_id then
    set @change_msg = concat(@change_msg, concat('. ballot_id changed from ', old.ballot_id, ' to ', new.ballot_id));
  end if;
  
  if new.candidate_id != old.candidate_id then
    set @change_msg = concat(@change_msg, concat('. candidate_id changed from ', old.candidate_id, ' to ', new.candidate_id));
  end if;
  
insert into ballot_candidate_audit(audit_datetime, audit_user, audit_change)   
values (now(), user(), @change_msg);
  
end//

delimiter ;

-- Create the ballot_candidate before insert trigger tr_ballot_candidate_bi to prevent overvoting
drop trigger if exists tr_ballot_candidate_bi;

delimiter //

create trigger tr_ballot_candidate_bi
  before insert on ballot_candidate
  for each row
begin 
  declare v_race_id int;
  declare v_votes_allowed int;
  declare v_existing_votes int;
  declare v_error_msg varchar(100);
  declare v_race_name varchar(100);  
  
  select r.race_id,
         r.race_name,
         r.votes_allowed
  into   v_race_id,
         v_race_name,
         v_votes_allowed
  from   race r
  join   candidate c
  on     r.race_id = c.race_id
  where  c.candidate_id = new.candidate_id;

  select count(*)
  into   v_existing_votes
  from   ballot_candidate bc
  join   candidate c
  on     bc.candidate_id = c.candidate_id
  and    c.race_id = v_race_id
  where  bc.ballot_id = new.ballot_id;

  if v_existing_votes >= v_votes_allowed then
     select concat('Overvoting error: The ',
              v_race_name,
              ' race allows selecting a maximum of ',
              v_votes_allowed,
              ' candidate(s) per ballot.'
            )
     into v_error_msg;
	 
    signal sqlstate '45000' set message_text = v_error_msg;
  end if;
end//

delimiter ;

-- Insert data into tables
-- voter table

-- This first insert statement to the voter table is Exercise 17-2
insert into voter (voter_name, voter_address, voter_county, voter_district, voter_precinct, voter_party, voting_location, voter_registration_num)
values ('Susan King', '12 Pleasant St. Springfield', 'Franklin', '12A', '4C', 'Democrat', '523 Emerson St.', 129756);
-- End of Exercise 17-2

-- Answer to Exercise 17-3: The voter_id column value gets automatically added to the table because 
--                          voter_id was defined as "auto increment" when we created the voter table.
--                          MySQL will automatically make sure the value of voter_id gets higher with each new row.

insert into voter (voter_name, voter_address, voter_county, voter_district, voter_precinct, voter_party, voting_location, voter_registration_num)
values ('Tina Warren', '218 Elm St. Manchester', 'Franklin', '12A', '4C', 'Republican', '523 Emerson St.', 698763);

insert into voter (voter_name, voter_address, voter_county, voter_district, voter_precinct, voter_party, voting_location, voter_registration_num)
values ('Luke Smith', '87 Main St. Madison', 'Franklin', '12A', '4C', 'Unenrolled', '523 Emerson St.', 3859124);

-- race table
insert into race (race_name, votes_allowed) values ('Mayor', 1);
insert into race (race_name, votes_allowed) values ('Board of Health', 1);
insert into race (race_name, votes_allowed) values ('Treasurer', 1);
insert into race (race_name, votes_allowed) values ('School Committee', 2);
insert into race (race_name, votes_allowed) values ('Planning Board', 1);

-- candidate table
insert into candidate (race_id, candidate_name, candidate_address, candidate_party, incumbent_flag)
values (1, 'Lawrence Q. Mow', '1 Prestigous Way', 'Republican', 1);

insert into candidate (race_id, candidate_name, candidate_address, candidate_party, incumbent_flag)
values (1, 'Maria Dolan', '11 Cove St', 'Democrat', 0);

insert into candidate (race_id, candidate_name, candidate_address, candidate_party, incumbent_flag)
values (2, 'Lily Turner', '88 Flanders Ln', 'Democrat', 1);

insert into candidate (race_id, candidate_name, candidate_address, candidate_party, incumbent_flag)
values (2, 'Ruby Clark', '12 Oak St', 'Independent', 0);

insert into candidate (race_id, candidate_name, candidate_address, candidate_party, incumbent_flag)
values (3, 'Liza Warbucks', '5 Lincoln Ave', 'Democrat', 1);

insert into candidate (race_id, candidate_name, candidate_address, candidate_party, incumbent_flag)
values (3, 'William Banks', '63 Brewster St', 'Republican', 0);

insert into candidate (race_id, candidate_name, candidate_address, candidate_party, incumbent_flag)
values (3, 'Andrew T. Oates', '230 Tremont Pl', null, 0);

insert into candidate (race_id, candidate_name, candidate_address, candidate_party, incumbent_flag)
values (4, 'Elaine M. Gold', '67 Fairbanks St', 'Republican', 1);

insert into candidate (race_id, candidate_name, candidate_address, candidate_party, incumbent_flag)
values (4, 'Sarah V. Hall', '7 Harrison St', 'Democrat', 0);

insert into candidate (race_id, candidate_name, candidate_address, candidate_party, incumbent_flag)
values (4, 'Peter Smart', '16 Wayne Rd', 'Democrat', 0);

insert into candidate (race_id, candidate_name, candidate_address, candidate_party, incumbent_flag)
values (5, 'Michael J. Hogan', '2 Pine Hill Rd', 'Green', 1);
	
-- ballot table	
insert into ballot (voter_id, ballot_type, ballot_cast_datetime)
values (1, 'in-person', '2024-04-26 14:47:29');

-- Exercise 17-4: To run these insert statements, uncomment the insert statements (remove the --'s) and run them.
--                They should fail because they violate the constraints we set up when we created our tables.
--
-- The following insert statement will fail because the voter table already has a voter with voter_registration_num 129756:
--
-- insert into voter (voter_name, voter_address, voter_county, voter_district, voter_precinct, voter_party, voting_location, voter_registration_num)
-- values ('Ed Hart', '7 Church St. Waverly', 'Franklin', '12A', '4C', 'Republican', '523 Emerson St.', 129756);
--
-- The following insert statement will fail because we don't have a voter with a voter_id of 888 in the voter table
-- 
-- insert into ballot (voter_id, ballot_type, ballot_cast_datetime)
-- values (888, 'in-person', now());
--
-- End of Exercise 17-4

-- ballot_candidate table
insert into ballot_candidate (ballot_id, candidate_id)
values (1, 2);

insert into ballot_candidate (ballot_id, candidate_id)
values (1, 8);

-- Create the triggers that allow only the Secretary of State to make changes to voter, race, and candidate data from now on.
-- Creating the tr_voter_bi before insert trigger
drop trigger if exists tr_voter_bi;

delimiter //

create trigger tr_voter_bi
  before insert on voter
  for each row
begin
  if user() not like 'secretary_of_state%' then
    signal sqlstate '45000'
	set message_text = 'Voters can be added only by the Secretary of State';
  end if;
end//

delimiter ;

-- Creating the tr_race_bi before insert trigger
drop trigger if exists tr_race_bi;

delimiter //

create trigger tr_race_bi
  before insert on race
  for each row
begin
  if user() not like 'secretary_of_state%' then
    signal sqlstate '45000'
	set message_text = 'Races can be added only by the Secretary of State';
  end if;
end//

delimiter ;

-- Creating the tr_candidate_bi before insert trigger
drop trigger if exists tr_candidate_bi;

delimiter //

create trigger tr_candidate_bi
  before insert on candidate
  for each row
begin
  if user() not like 'secretary_of_state%' then
    signal sqlstate '45000'
	set message_text = 'Candidates can be added only by the Secretary of State';
  end if;
end//

delimiter ;

-- Creating the tr_voter_bu before update trigger
drop trigger if exists tr_voter_bu;

delimiter //

create trigger tr_voter_bu
  before update on voter
   for each row
begin
   if user() not like 'secretary_of_state%' then
	  signal sqlstate '45000' set message_text = 'Voters can be updated only by the Secretary of State';
  end if;
end//

delimiter ;

-- Creating the tr_candidate_bu before update trigger
drop trigger if exists tr_candidate_bu;

delimiter //

create trigger tr_candidate_bu
  before update on candidate
   for each row
begin
   if user() not like 'secretary_of_state%' then
	  signal sqlstate '45000' set message_text = 'Candidates can be updated only by the Secretary of State';
  end if;
end//

delimiter ;

-- Creating the tr_race_bu before update trigger
drop trigger if exists tr_race_bu;

delimiter //

create trigger tr_race_bu
  before update on race
   for each row
begin
   if user() not like 'secretary_of_state%' then
	  signal sqlstate '45000' set message_text = 'Races can be updated only by the Secretary of State';
  end if;
end//

delimiter ;

-- Creating the tr_voter_bd before delete trigger
drop trigger if exists tr_voter_bd;

delimiter //

create trigger tr_voter_bd
  before delete on voter
   for each row
begin
   if user() not like 'secretary_of_state%' then
	  signal sqlstate '45000' set message_text = 'Voters can be deleted only by the Secretary of State';
  end if;
end//

delimiter ;

-- Creating the tr_candidate_bd before delete trigger
drop trigger if exists tr_candidate_bd;

delimiter //

create trigger tr_candidate_bd
  before delete on candidate
   for each row
begin
   if user() not like 'secretary_of_state%' then
	  signal sqlstate '45000' set message_text = 'Candidates can be deleted only by the Secretary of State';
  end if;
end//

delimiter ;

-- Creating the tr_race_bd before delete trigger
drop trigger if exists tr_race_bd;

delimiter //

create trigger tr_race_bd
  before delete on race
   for each row
begin
   if user() not like 'secretary_of_state%' then
	  signal sqlstate '45000' set message_text = 'Races can be deleted only by the Secretary of State';
  end if;
end//

delimiter ;

-- To test these "before" triggers on the voter, candidate, and race tables, create a new user called secretary_of_state, like this:
-- create user secretary_of_state@localhost identified by 'v0t3'; -- This creates the user's password as v0t3
-- grant all privileges on *.* to secretary_of_state@localhost; -- granting superuser privs on everything is normally a bad idea, but we can do it just for this test.

-- If you log into MySQL as the Secretary of State you can execute these 3 commands (uncomment the commands first)
-- If you log into MySQL with another user ID, our triggers will prevent running the commands.

-- insert into race (race_name, votes_allowed)
-- values ('Dog Catcher', 1);

-- update candidate
-- set    candidate_name = 'Lisa Peacemoney'
-- where  candidate_name = 'Liza Warbucks';

-- delete from voter
-- where voter_name = 'Tina Warren';
