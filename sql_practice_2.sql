-- Find boat(s) that have never been reserved.
select b.bname,b.bid
from boats b
left join reserves r on b.bid = r.bid
where r.bid is null;

-- Find sailors who have never made any reservation.
select s.sname
from sailors s
left join reserves r on s.sid = r.sid
where r.sid is null;


-- Show sailors who reserved more than one boat.
select s.sname, count(r.bid) as num_of_boats
from sailors s
join reserves r on s.sid = r.sid
group by s.sid, s.sname
having count(r.bid) >1;

-- Find the average age of sailors for each rating.

select rating, avg(age) as avg_age
from sailors
group by rating;

--Show ratings that have more than 1 sailor.

select rating, count(rating) as num_of_sailors
from sailors
group by rating;

-- Find the minimum age for each rating.

select rating, min(age) as minimum_age
from sailors
group by rating;

-- Find number of sailors whose rating > 5 grouped by rating.

select rating, count(sid) as num_of_sailors
from sailors
where rating > 5
group by rating;

-- Show sailors whose total number of reservations is at least 2.

select s.sid, s.sname, count(r.bid) as num_of_reservations
from sailors s
join reserves r on s.sid = r.sid
group by s.sname, s.sid
having count(r.bid) >=2;

-- List boat colors and how many times they were reserved.

select b.bname, b.color, count(r.bid) as num_of_times_reserved
from boats b
join reserves r on b.bid = r.bid
group by b.bname, b.color;

-- Show the rating that has the oldest sailor.

select rating ,sname, age
from sailors 
order by age desc
limit 1;

--Find age difference between oldest and youngest sailor.

select max(age) - min(age) as age_difference
from sailors;

-- Show average rating of sailors who reserved a boat.

select avg(s.rating) as avg_rating
from sailors s
join reserves r on s.sid = r.sid;


-- Count reservations per month.

select month(day) as month, count(*) as num_reservations
from reserves r
group by month(day)
order by month(day);
