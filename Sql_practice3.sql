-- Count reservations per month.

select month(day) as month, count(*) as num_reservations
from reserves r
group by month(day)
order by month(day);

--Find sailors with rating higher than the average rating.
select sname, rating
from sailors
where rating> (select avg (rating) from sailors);

--Find the oldest sailor(s) — using subquery.
select sname, age
from sailors
where age = (select max(age) from sailors);

--Find sailors who reserved at least one red boat.
select distinct s.sname
from sailors s 
join reserves r on s.sid = r.sid
join boats b on r.bid = b.bid
where b.color = 'red';

--Find sailors who have reserved all boats.
select  s.sname
from sailors s 
join reserves r on s.sid = r.sid
group by s.sid, s.sname
having count(distinct r.bid) = (select count(*) from boats);

-- Find boats reserved by sailors older than 40.
select b.bname, b.bid, s.sname, s.age
from boats b
join reserves r on b.bid = r.bid
join sailors s on r.sid = s.sid
where s.age > 40;

-- Find sailors whose age is above the average age of sailors with rating=10.
select sname, age
from sailors
where age > (select avg(age) from sailors where rating = 10 );

--Find sailors who reserved only green boats.
select s.sname
from sailors s
join reserves r on s.sid = r.sid
join boats b on r.bid = b.bid
where b.color = 'green';

-- Find the youngest sailor who has at least one reservation.
select distinct s.sname, s.age
from sailors s
join reserves r on s.sid = r.sid
where s.age  = (select min(age) from sailors where sid in (select sid from reserves)
);

-- Find sailors who reserved the boat that Dustin reserved.
select distinct s.sname, 
from sailors s
join reserves r on s.sid = r.sid
where r.bid in (select bid from reserves  r2 join sailors s2 on r2.sid = s2.sid where s2.sname = 'Dustin');
