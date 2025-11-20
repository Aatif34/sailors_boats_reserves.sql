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

-- 4. Basic Queries
-- Select all sailors
SELECT * FROM Sailors;

-- Select sailors with age > 30
SELECT * FROM Sailors WHERE age > 30;

-- Order sailors by age ascending
SELECT * FROM Sailors ORDER BY age ASC;

-- Sailors with rating > 5
SELECT * FROM Sailors WHERE rating > 5;

-- Boats of color red
SELECT * FROM Boats WHERE color = 'red';

-- Reservations in January 2025
SELECT * FROM Reserves
WHERE day >= '2025-01-01' AND day < '2025-02-01';

-- Sailors whose name starts with 'H'
SELECT * FROM Sailors WHERE sname LIKE 'H%';

-- Distinct boat colors
SELECT DISTINCT color FROM Boats;

-- Oldest sailor
SELECT * FROM Sailors ORDER BY age DESC LIMIT 1;

-- Youngest sailor
SELECT * FROM Sailors ORDER BY age ASC LIMIT 1;

-- Count of sailors with rating 10
SELECT COUNT(*) FROM Sailors WHERE rating = 10;

-- Top 3 oldest sailors
SELECT * FROM Sailors ORDER BY age DESC LIMIT 3;

-- Sailors aged between 20 and 40
SELECT * FROM Sailors WHERE age BETWEEN 20 AND 40;

-- Sailors whose name contains 'o'
SELECT * FROM Sailors WHERE sname LIKE '%o%';

-- Count of reservations
SELECT COUNT(*) FROM Reserves;

-- Join sailors, boats, and reserves
SELECT s.sname, b.bname, r.bid, s.sid, r.day
FROM Sailors s
JOIN Reserves r ON s.sid = r.sid
JOIN Boats b ON r.bid = b.bid;

-- Boats reserved by 'Dustin'
SELECT b.bname, s.sname
FROM Boats b
JOIN Reserves r ON b.bid = r.bid
JOIN Sailors s ON r.sid = s.sid
WHERE s.sname = 'Dustin';

-- Count of boats reserved by each sailor
SELECT s.sname, COUNT(r.bid) AS total_boats
FROM Sailors s
LEFT JOIN Reserves r ON s.sid = r.sid
GROUP BY s.sid, s.sname;
