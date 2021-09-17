create database if not exists land;

use land;

drop table if exists continent;

create table continent
(
	continent_id	tinyint		not null	auto_increment,
	continent_name	varchar(20),
	population		bigint,
	primary key (continent_id)
);

insert into continent (continent_name, population) values ('Asia', 4641054775);
insert into continent (continent_name, population) values ('Africa', 1340598147);
insert into continent (continent_name, population) values ('Europe', 747636026);
insert into continent (continent_name, population) values ('North America', 592072212);
insert into continent (continent_name, population) values ('South America', 430759766);
insert into continent (continent_name, population) values ('Australia', 43111704);
insert into continent (continent_name, population) values ('Antarctica', 0);

create table high_temperature
	(
	city				varchar(50),
	year				int,
	high_temperature	int,
	primary key (city, year)
	);

insert into high_temperature (city, year, high_temperature)
values
('Death Valley, CA', 2020, 130),
('International Falls, MN', 2020 , 78),
('New York, NY', 2020, 96),
('Death Valley, CA', 2021, 128),
('International Falls, MN', 2021 , 77),
('New York, NY', 2021, 98);

create database if not exists feedback;

use feedback;

create table customer
	(
    customer_id	int,
    first_name	varchar(50),
    last_name	varchar(50),
    address		varchar(100),
    primary key (customer_id)
	);
	
insert into customer (customer_id, first_name, last_name, address)
values
(1, 'Bob', 'Smith', '12 Dreary Lane'),
(2, 'Sally', 'Jones', '76 Boulevard Meugler'),
(3, 'Karen', 'Bellyacher', '354 Main Street');

create table complaint
    (
    complaint_id  int,
    customer_id   int,
    complaint     varchar(200),
    primary key (complaint_id),
    foreign key (customer_id) references customer(customer_id)
    );
	
insert into complaint (complaint_id, customer_id, complaint)
values (1, 3, 'I want to speak to your manager');

create database if not exists pet;

use pet;

create table owner
(
	owner_id			int,
	owner_address		varchar(50),
	primary key (owner_id)
);

create table breed
(
	breed_id		int,
	breed_name		varchar(50),
	temperament		varchar(50),
	primary key (breed_id)
);

create table veterinarian
(
	veterinarian_id			int,
	veterinarian_name		varchar(50),
	veterinarian_address	varchar(50),
	veterinarian_phone		varchar(50),
	primary key (veterinarian_id)
);

create table dog
	(
	dog_id			int,
	dog_name		varchar(50) unique,
	owner_id		int,
	breed_id		int,
	veterinarian_id	int,
	primary key (dog_id),
	foreign key (owner_id) references owner(owner_id),
	foreign key (breed_id) references breed(breed_id),
	foreign key (veterinarian_id) references veterinarian(veterinarian_id)
	);

create table contact
(
    contact_id     int,
    name           varchar(50) not null1,
    city           varchar(50),
    phone          varchar(20),
    email_address  varchar(50),
    primary key(contact_id)
);

insert into contact values
(1, 'Steve Chen', 'Beijing', '123-3123', 'steve@schen21.org'),
(2, 'Joan Field', 'New York', '321-4321', 'jfield@jfny99.com'),
(3, 'Bill Bashful', 'Lincoln', null    ,  'bb@shyguy77.edu');

use land;

create table high_temperature
(
    city              varchar(50),
    year              int,
    high_temperature  int,
    constraint check (year between 1880 and 2200),
    constraint check (high_temperature < 200),
    primary key (city, year)
);

use feedback;

create table job
(
    job_id	   int,
	job_desc   varchar(100),
	shift      varchar(50) default '9-5',
	primary key (job_id)
);
