use solar_system;

-- Exercise 5-1: Inner Join
select	p.planet_name,
		r.ring_tot
from    planet p 
inner join ring r
on		r.planet_id = p.planet_id;

-- Exercise 5-2: Outer Join with planet as the left table
select	p.planet_name,
		r.ring_tot
from    planet p left join ring r
on		r.planet_id = p.planet_id;

-- Exercise 5-3: Outer Join with planet as the right table
select	p.planet_name,
		r.ring_tot
from    ring r right join planet p
on		r.planet_id = p.planet_id;

-- Exercise 5-4: Column Aliasing
--Showing ring_tot column as "rings"
select	p.planet_name,
		r.ring_tot as rings
from    ring r right join planet p
on		r.planet_id = p.planet_id;

