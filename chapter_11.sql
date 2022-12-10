-- 
-- MySQL Crash Course
-- 
-- Chapter 11 – Creating Functions and Procedures							
--
-- You can copy and paste any of these commands into your favorite MySQL tool
-- (like MySQL Workbench) and run them in your own MySQL environment.
--

-- Create the tables for the chapter
create database population;

use population;

create table state_population
	(
    state       varchar(100),
    population  int
    );

insert into state_population values ('New York',		19299981);
insert into state_population values ('Texas',			29730311);
insert into state_population values ('California',		39613493);
insert into state_population values ('Florida', 		21944577);
insert into state_population values ('New Jersey',		 9267130);
insert into state_population values ('Massachusetts',	 6893000);
insert into state_population values ('Rhode Island', 	 1097379);

drop table if exists county_population;

create table county_population (state char(50), county varchar(100), population int);

insert into county_population values ('New York',	'Kings',		2736074);
insert into county_population values ('New York',	'Queens',		2405464);
insert into county_population values ('New York',	'New York',		1694251);
insert into county_population values ('New York',	'Suffolk',		1525920);
insert into county_population values ('New York',	'Bronx',		1472654);
insert into county_population values ('New York',	'Nassau',		1395774);
insert into county_population values ('New York',	'Westchester',	1004457);
insert into county_population values ('New York',	'Erie',			954236);
insert into county_population values ('New York',	'Monroe',		759443);
insert into county_population values ('New York',	'Richmond',		495747);
insert into county_population values ('New York',	'Onondaga',		476516);
insert into county_population values ('New York',	'Orange',		401310);
insert into county_population values ('New York',	'Rockland',		338329);
insert into county_population values ('New York',	'AlbaNew York', 314848);
insert into county_population values ('New York',	'Dutchess',		295911);
insert into county_population values ('New York',	'Saratoga',		235509);
insert into county_population values ('New York',	'Oneida',		232125);
insert into county_population values ('New York',	'Niagara',		212666);
insert into county_population values ('New York',	'Broome',		198683);
insert into county_population values ('New York',	'Ulster',		181851);
insert into county_population values ('New York',	'Rensselaer',	161130);
insert into county_population values ('New York',	'Schenectady',	158061);
insert into county_population values ('New York',	'Chautauqua',	127657);
insert into county_population values ('New York',	'Oswego',		117525);
insert into county_population values ('New York',	'Jefferson',	116721);
insert into county_population values ('New York',	'Ontario',		112458);
insert into county_population values ('New York',	'St. Lawrence',	108505);
insert into county_population values ('New York',	'Tompkins',		105740);
insert into county_population values ('New York',	'Putnam',		97668);
insert into county_population values ('New York',	'Steuben',		93584);
insert into county_population values ('New York',	'Wayne',		91283);
insert into county_population values ('New York',	'Chemung',		84148);
insert into county_population values ('New York',	'Clinton',		79843);
insert into county_population values ('New York',	'Sullivan',		78624);
insert into county_population values ('New York',	'Cattaraugus',	77042);
insert into county_population values ('New York',	'Cayuga',		76248);
insert into county_population values ('New York',	'Madison',		68016);
insert into county_population values ('New York',	'Warren',		65737);
insert into county_population values ('New York',	'Livingston',	61834);
insert into county_population values ('New York',	'Columbia',		61570);
insert into county_population values ('New York',	'Washington',	61302);
insert into county_population values ('New York',	'Herkimer',		60139);
insert into county_population values ('New York',	'Otsego',		58524);
insert into county_population values ('New York',	'Genesee',		58388);
insert into county_population values ('New York',	'Fulton',		53324);
insert into county_population values ('New York',	'Montgomery',	49532);
insert into county_population values ('New York',	'Tioga',		48455);
insert into county_population values ('New York',	'Greene',		47931);
insert into county_population values ('New York',	'Franklin',		47555);
insert into county_population values ('New York',	'Chenango',		47220);
insert into county_population values ('New York',	'Cortland',		46809);
insert into county_population values ('New York',	'Allega', 		46456);
insert into county_population values ('New York',	'Delaware',		44308);
insert into county_population values ('New York',	'Wyoming',		40531);
insert into county_population values ('New York',	'Orleans',		40343);
insert into county_population values ('New York',	'Essex',		37381);
insert into county_population values ('New York',	'Seneca',		33814);
insert into county_population values ('New York',	'Schoharie',	29714);
insert into county_population values ('New York',	'Lewis',		26582);
insert into county_population values ('New York',	'Yates',		24774);
insert into county_population values ('New York',	'Schuyler',		17898);
insert into county_population values ('New York',	'Hamilton',		5107);

-- Create the f_get_state_population() function
use population;

drop function if exists f_get_state_population;

delimiter //
create function f_get_state_population (
  state_param    varchar(100)
)
returns int
deterministic reads sql data
begin
  declare population_var int;

  select  population
  into    population_var
  from    state_population
  where   state = state_param;

  return(population_var);

end//

delimiter ;

-- Call the f_get_state_population() function
select f_get_state_population('New York');

-- Call the f_get_state_population() function from a WHERE clause
select  *
from    state_population
where   population > f_get_state_population('New York');

-- Create the p_set_state_population() procedure
use population;

drop procedure if exists p_set_state_population;

delimiter //


drop function if exists f_get_world_population;

-- f_get_world_population() with delimiters
delimiter //
create function f_get_world_population()
returns bigint
deterministic no sql
begin
  return(7978759141);
end//

delimiter ;

drop function if exists f_get_world_population;

-- f_get_world_population() without delimiters
create function f_get_world_population()
returns bigint
deterministic no sql
return(7978759141);



select f_get_world_population();


create procedure p_set_state_population(
    in state_param varchar(100)
)
begin
    delete from state_population
    where state = state_param;
   
    insert into state_population
    (
           state,
           population
    )
    select state,
           sum(population)
    from   county_population
    where  state = state_param
    group by state;
    
end//

delimiter ;

-- Call the p_set_state_population() procedure
call p_set_state_population('New York');

-- Create the p_set_and_show_state_population() procedure
use population;

drop procedure if exists p_set_and_show_state_population;

delimiter //

create procedure p_set_and_show_state_population(
    in state_param varchar(100)
)
begin
    declare population_var int;

    delete from state_population
    where state = state_param;
   
    select sum(population)
    into   population_var
    from   county_population
    where  state = state_param;

    insert into state_population
    (
           state,
           population
    )
    values
    (
           state_param,
           population_var
    );

    select concat(
               'Setting the population for ',
               state_param,
               ' of ',
               population_var
            );
end//

delimiter ;

-- Call the p_set_and_show_state_population() procedure
call p_set_and_show_state_population('New York');

-- Show all procedures and functions in the population database
select routine_type,
       routine_name
from   information_schema.routines
where  routine_schema='population';

-- Create the weird_math database and the f_math_trick() function
create database weird_math;

use weird_math;

drop function if exists f_math_trick;

delimiter //

create function f_math_trick(
    input_param   int
)
returns int
no sql
begin
    set @a = input_param;
    set @b = @a * 3;
    set @c = @b + 6;
    set @d = @c / 3;
    set @e = @d - @a;

    return(@e);
end//

delimiter ;

-- Call the f_math_trick() function. I hope you like 2's.  ;-)
select f_math_trick(12);

select f_math_trick(-28),
       f_math_trick(0),
       f_math_trick(175);

-- Create the p_compare_population() procedure
use population;

drop procedure if exists p_compare_population;

delimiter //

create procedure p_compare_population(
    in state_param varchar(100)
)
begin
    declare state_population_var int;
    declare county_population_var int;

    select  population
    into    state_population_var
    from    state_population
    where   state = state_param;

    select sum(population)
    into   county_population_var
    from   county_population
    where  state = state_param;

    if (state_population_var = county_population_var) then
       select 'The population values match';
    else
       select 'The population values are different';
    end if;
	
	-- If you want to display one of THREE messages, replace the if/else above with this code
	-- Remove the comment characters (the 2 dashes) first.
	
    -- if (state_population_var = county_population_var) then
    --    select 'The population values match';
    -- elseif (state_population_var > county_population_var) then
    --    select 'State population is more than the sum of county population';
    -- else
    --    select 'The sum of county population is more than the state population';
    -- end if;
end//

delimiter ;

-- Call the p_compare_population() procedure
call p_compare_population('New York');

-- Create the p_population_group() procedure
use population;

drop procedure if exists p_population_group;

delimiter //

create procedure p_population_group(
    in state_param varchar(100)
)
begin
    declare state_population_var int;
    
    select population
    into   state_population_var
    from   state_population
    where  state = state_param;

    case 
      when state_population_var > 30000000 then select 'Over 30 Million';
      when state_population_var > 10000000 then select 'Between 10M and 30M';
      else select 'Under 10 Million';
    end case;

end//

delimiter ;

-- Call the p_population_group() procedure three times
call p_population_group('California');
call p_population_group('New York');
call p_population_group('Rhode Island');

-- Create the p_endless_loop() procedure. This creates an endless loop.
drop procedure if exists p_endless_loop;

delimiter //
create procedure p_endless_loop()
begin
loop
  select 'Looping Again';
end loop;
end;
//
delimiter ;

-- Call the p_endless_loop() procedure. Warning: This kicks off an endless loop.
call p_endless_loop();

-- Create the procedure p_more_sensible_loop()
drop procedure if exists p_more_sensible_loop;

delimiter //
create procedure p_more_sensible_loop()
begin
 set @cnt = 0;
 msl: loop
  select 'Looping Again';
    set @cnt = @cnt + 1;
  if @cnt = 10 then 
    leave msl;
  end if;
end loop msl;
end;
//
delimiter ;

-- Call the procedure p_more_sensible_loop()
call p_more_sensible_loop();

-- Create the procedure p_repeat_until_loop()
drop procedure if exists p_repeat_until_loop;

delimiter //
create procedure p_repeat_until_loop()
begin
set @cnt = 0;
repeat
  select 'Looping Again';
  set @cnt = @cnt + 1;
until @cnt = 10 
end repeat;
end;
//
delimiter ;

-- Call the procedure p_repeat_until_loop()
call p_repeat_until_loop();

-- Create procedure p_while_loop()
drop procedure if exists p_while_loop;

delimiter //
create procedure p_while_loop()
begin
set @cnt = 0;
while @cnt < 10 do
  select 'Looping Again';
  set @cnt = @cnt + 1;
end while;
end;
//
delimiter ;

-- Call procedure p_while_loop()
call p_while_loop();

-- Create procedure p_get_county_population()
use population;

drop procedure if exists p_get_county_population;

delimiter //

create procedure p_get_county_population(
    in state_param varchar(100)
)
begin
    select county,
           format(population,0)
    from   county_population
    where  state = state_param
    order by population desc;
end//

delimiter ;

-- Call procedure p_get_county_population()
call p_get_county_population('New York');

-- Create procedure p_split_big_ny_counties()
drop procedure if exists p_split_big_ny_counties;

delimiter //

create procedure p_split_big_ny_counties()
begin
  declare  v_state       varchar(100);
  declare  v_county      varchar(100);
  declare  v_population  int;

  declare done bool default false;
  
  declare county_cursor cursor for 
    select  state,
            county,
            population
    from    county_population
    where   state = 'New York'
    and     population > 2000000;

  declare continue handler for not found set done = true;   
    
  open county_cursor;
  
  fetch_loop: loop
    fetch county_cursor into v_state, v_county, v_population;

    if done then
      leave fetch_loop;
    end if;

    set @cnt = 1;

    split_loop: loop

      insert into county_population
      (
        state, 
        county, 
        population
      )
      values
      (
        v_state,
        concat(v_county,'-',@cnt), 
        round(v_population/2)
      );
      
      set @cnt = @cnt + 1;

      if @cnt > 2 then
        leave split_loop;
      end if;

    end loop split_loop;
    
    -- delete the original county
    delete from county_population where county = v_county;
    
  end loop fetch_loop;
  
  close county_cursor;
end;
//

delimiter ;

-- Call procedure p_split_big_ny_counties()
call p_split_big_ny_counties();

-- How do those counties look now? Did they get split?
select * 
from   county_population
order by population desc;

-- Create procedure p_return_state_population()
use population;

drop procedure if exists p_return_state_population;

delimiter //

create procedure p_return_state_population(
    in  state_param         varchar(100),
    out current_pop_param   int
)
begin 
    select population
    into   current_pop_param
    from   state_population
    where  state = state_param;
end//

delimiter ;

-- Call procedure p_return_state_population()
call p_return_state_population('New York', @pop_ny);

-- What value did the procedure return in the @pop_ny user variable?
select @pop_ny;

-- Create procedure p_population_caller()
use population;

drop procedure if exists p_population_caller;

delimiter //

create procedure p_population_caller()
begin
  call p_return_state_population('New York',@pop_ny); 
  call p_return_state_population('New Jersey',@pop_nj);
  
  set @pop_ny_and_nj = @pop_ny + @pop_nj;
  
  select concat(
     'The population of the NY and NJ area is ',
     @pop_ny_and_nj);
  
end//

delimiter ;

-- Call procedure p_population_caller()
call p_population_caller();



-- Try It Yourself Exercises

-- Setup for exercise 1-1
create database diet;

use diet;

create table calorie
	(
	food			varchar(100),
	calorie_count	int
	);
	
insert into calorie
	(
	food,
	calorie_count
	)
values
	('banana', 110),
	('pizza', 700),
	('apple', 185);

-- Exercise 11-1: Create the f_get_calorie_count() function
use diet;

drop function if exists f_get_calorie_count;

delimiter //
create function f_get_calorie_count (
  food_param    varchar(100)
)
returns int
deterministic reads sql data
begin
  declare calorie_count_var int;

  select  calorie_count
  into    calorie_count_var
  from    calorie
  where   food = food_param;

  return(calorie_count_var);

end//

delimiter ;

-- Call the f_get_calorie_count() function to get the calories for pizza
select f_get_calorie_count('pizza');

-- Setup for exercise 11-2
create database age;

use age;

create table family_member_age
	(
	person	varchar(100),
	age		int
	);
	
insert into family_member_age
values
('Junior',	7),
('Ricky',	16),
('Grandpa',	102);

-- Exercise 11-2: Create the p_get_age_group() procedure to get a family member's age group
drop procedure if exists p_get_age_group;

delimiter //

create procedure p_get_age_group(
    in  family_member  varchar(100)
)
begin
  declare age_var int;

  select  age
  into    age_var
  from    family_member_age
  where   person = family_member;

  case
    when age_var < 13 then select 'Child';
	when age_var < 20 then select 'Teenager';
	else select 'Adult';
  end case;

end//

delimiter ;

-- Call the p_get_age_group() procedure to get a family member's age group
call p_get_age_group('Ricky');
call p_get_age_group('Junior');
call p_get_age_group('Grandpa');

-- Exercise 11-3: Create the p_get_food() procedure 
use diet;

drop procedure if exists p_get_food;

delimiter //
create procedure p_get_food()
begin
  select  *
  from    calorie
  order by calorie_count desc;

end//

delimiter ;

-- Call the procedure to get the list of food and calories
call p_get_food();
