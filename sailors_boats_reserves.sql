-- ===============================
-- Database: ds3334
-- Tables: Sailors, Boats, Reserves
-- ===============================

-- 1. Use database
USE ds3334;

-- 2. Create Tables
CREATE TABLE Sailors (
    sid INT PRIMARY KEY,
    sname VARCHAR(20),
    rating INT,
    age REAL
);

CREATE TABLE Boats (
    bid INT PRIMARY KEY,
    bname VARCHAR(20),
    color VARCHAR(10)
);

CREATE TABLE Reserves (
    sid INT,
    bid INT,
    day DATE,
    PRIMARY KEY (sid, bid, day),
    FOREIGN KEY (sid) REFERENCES Sailors(sid),
    FOREIGN KEY (bid) REFERENCES Boats(bid)
);

-- 3. Insert Data
INSERT INTO Sailors VALUES
(22, 'Dustin', 7, 45.0),
(29, 'Brutus', 1, 33.0),
(31, 'Lubber', 8, 55.5),
(32, 'Andy', 8, 25.5),
(58, 'Rusty', 10, 35.0),
(64, 'Horatio', 7, 35.0),
(71, 'Zorba', 10, 16.0),
(74, 'Horatio', 9, 35.0),
(85, 'Art', 3, 25.5),
(95, 'Bob', 3, 63.5);

INSERT INTO Boats VALUES
(101, 'Interlake', 'blue'),
(102, 'Interlake', 'red'),
(103, 'Clipper', 'green'),
(104, 'Marine', 'red');

INSERT INTO Reserves VALUES
(22, 101, '2025-01-01'),
(22, 102, '2025-01-02'),
(22, 103, '2025-01-03'),
(31, 102, '2025-01-04'),
(31, 103, '2025-01-05'),
(31, 104, '2025-01-06'),
(64, 101, '2025-02-01'),
(64, 102, '2025-02-02'),
(74, 103, '2025-03-01');

-- 4. basic queries
-- select all sailors
select * from sailors;

-- select sailors with age > 30
select * from sailors where age > 30;

-- order sailors by age ascending
select * from sailors order by age asc;

-- sailors with rating > 5
select * from sailors where rating > 5;

-- boats of color red
select * from boats where color = 'red';

-- reservations in january 2025
select * from reserves
where day >= '2025-01-01' and day < '2025-02-01';

-- sailors whose name starts with 'h'
select * from sailors where sname like 'h%';

-- distinct boat colors
select distinct color from boats;

-- oldest sailor
select * from sailors order by age desc limit 1;

-- youngest sailor
select * from sailors order by age asc limit 1;

-- count of sailors with rating 10
select count(*) from sailors where rating = 10;

-- top 3 oldest sailors
select * from sailors order by age desc limit 3;

-- sailors aged between 20 and 40
select * from sailors where age between 20 and 40;

-- sailors whose name contains 'o'
select * from sailors where sname like '%o%';

-- count of reservations
select count(*) from reserves;

-- join sailors, boats, and reserves
select s.sname, b.bname, r.bid, s.sid, r.day
from sailors s
join reserves r on s.sid = r.sid
join boats b on r.bid = b.bid;

-- boats reserved by 'dustin'
select b.bname, s.sname
from boats b
join reserves r on b.bid = r.bid
join sailors s on r.sid = s.sid
where s.sname = 'dustin';

-- count of boats reserved by each sailor
select s.sname, count(r.bid) as total_boats
from sailors s
left join reserves r on s.sid = r.sid
group by s.sid, s.sname;
