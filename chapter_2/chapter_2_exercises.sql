-- Exercise 2-1: Listing your databases
show databases;

-- Exercise 2-2: Creating a database and showing your databases.
create database cryptocurrency;

-- You should see the new cryptocurrency database in your list of databases.
show databases;

-- Exercise 2-3: Dropping a database and showing your databases.
drop database cryptocurrency;

-- You should not see the cryptocurrency database in your list of databases.
show databases;

-- Exercise 2-4: Create the athletic database and the sport and player tables with primary and foreign keys.
create database athletic;

use athletic;

create table sport
(
	sport_id	int,
	sport_name	varchar(50),
	primary key (sport_id)
);

create table player
(
    player_id    int,
    player_name  varchar(50),
    player_age   int,
    sport_id     int,
    primary key (player_id),
    foreign key (sport_id) references sport(sport_id)
);
