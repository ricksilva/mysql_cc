show databases;

create database circus;

create database finance;

create database music;

use land;

create table continent 
(
   continent_id	int,
   continent_name	varchar(20),
   population		bigint
);

create table customer
(
    customer_id     int,
    first_name	    varchar(50),
    last_name       varchar(50),
    address         varchar(100),
    primary key (customer_id)
); 

create table high_temperature
(
    city              varchar(50),
    year              int,
    high_temperature  int,
    constraint check (year between 1880 and 2200),
    constraint check (high_temperature < 200),
    primary key (city, year)
);


create table customer
(
    customer_id     int,
    first_name	    varchar(50),
    last_name       varchar(50),
    address         varchar(100),
    primary key (customer_id)
); 

create table complaint
    (
    complaint_id  int,
    customer_id   int,
    complaint     varchar(200),
    primary key (complaint_id),
    foreign key (customer_id) references customer(customer_id)
    );

create table contact
(
    contact_id     int,
    name           varchar(50)  not null,
    city           varchar(50),
    phone          varchar(20),
    email_address  varchar(50)  unique,
    primary key(contact_id)
);

create table job
(
    job_id     int,
    job_desc   varchar(100),
    shift      varchar(50) default '9-5',
    primary key (job_id)
);

use pet;

create table dog
(
    dog_id            int,
    dog_name          varchar(50) unique,
    owner_id          int,
    breed_id          int,
    veterinarian_id   int,
    primary key (dog_id),
    foreign key (owner_id) references owner(owner_id),
    foreign key (breed_id) references breed(breed_id),
    foreign key (veterinarian_id) references veterinarian(veterinarian_id)
);

alter table customer add column zip varchar(50);
alter table customer drop column address;
alter table customer rename column zip to zip_code;
alter table customer rename to valued_customer;
