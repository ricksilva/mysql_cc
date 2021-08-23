use subway;

-- An inner join query
select  subway_system.subway_system,
        subway_system.city,
        country.country
from    subway_system
inner join  country
on      subway_system.country_code = country.country_code;

-- Using table aliases
select  s.subway_system,
        s.city,
        c.country
from    subway_system s
inner join  country c
on      s.country_code = c.country_code;

-- Using "join" instead of "inner join" syntax returns the same results
select  s.subway_system,
        s.city,
        c.country
from    subway_system s
join country c
on      s.country_code = c.country_code;

-- An outer join using "right join"
select  s.subway_system,
        s.city,
        c.country
from    subway_system s
right join country c
on      s.country_code = c.country_code;

-- Column Aliasing.  "subway_system" displays as "metro"
select  s.subway_system as metro,
        s.city,
        c.country
from    subway_system as s
inner join country as c
on      s.country_code = c.country_code
where   c.country_code = 'FR';

-- Specifying the subway database with the "use" command
use subway;
select * from subway_system;

-- Specifying the subway database by using the "database.table" syntax
select * from subway.subway_system;


use restaurant;

-- A cross join
select     m.main_item,
           s.side_item
from       main_dish m 
cross join side_dish s;

-- An inner join
select     m.main_item,
           s.side_item
from       main_dish m 
inner join side_dish s;


use music;

-- A self join.  Joining the music_preference table to itself.
select	a.music_fan,
       b.music_fan
from   music_preference a
inner join music_preference b
on (a.favorite_genre = b.favorite_genre)
where  a.music_fan != b.music_fan
order by a.music_fan;
 