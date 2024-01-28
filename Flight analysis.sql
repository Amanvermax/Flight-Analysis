-- Airport database 

SELECT * FROM airport_database.economy;

SELECT * FROM airport_database.business;

-- Highest price of tickets in business class from delhi to mumbai

SELECT MAX(price) 
FROM business
WHERE `departure` = 'Delhi' AND `arrival` = 'Mumbai';

-- Lowest price of tickets in business class from delhi to mumbai 
SELECT min(price) 
FROM business 
WHERE `departure` = 'Delhi' AND `arrival` = 'Mumbai';

-- Describe the table

DESCRIBE TABLE business;

select * from business;

-- Longest time duration of which flight
SELECT airline, MAX(time_taken) AS max_time_taken
FROM business
GROUP BY airline;

-- Finding the non-stop flights details
select * from economy 
where stop = 'non-stop ';

SELECT *
FROM business
WHERE Stop = 'non-stop';

-- count non-stop

SELECT COUNT(*)
FROM economy
WHERE Stop = 'non-stop '; 


SELECT COUNT(*)
FROM business
WHERE stop = 'Air India';

-- Rename 'from' to 'departure' and 'to' to 'arrival'
 
ALTER TABLE economy
RENAME COLUMN `from` TO departure;

ALTER TABLE economy
RENAME COLUMN `to` TO arrival;

-- Here I am find out the date, price of delhi to mumbai Air India flight who took less than 2 hours 

SELECT date, price, time_taken
FROM economy
WHERE departure = 'Delhi' AND arrival = 'Mumbai'  AND airline = 'Air India' AND time_taken <= '02h 00m';

--  finding every flights minimum time 
 
select min(time_taken) as min_time, airline
from economy
group by airline;  

-- Minimum time taken by airlines in "non-stop"
SELECT MIN_SUB.min_time, e.airline
FROM economy e
JOIN (
    SELECT MIN(time_taken) AS min_time, airline
    FROM economy
    WHERE Stop = 'non-stop '
    GROUP BY airline
) AS MIN_SUB ON e.airline = MIN_SUB.airline AND e.time_taken = MIN_SUB.min_time
WHERE e.Stop = 'non-stop ';

-- Minimum time taken from delhi to mumbai 

select min(time_taken) as min_time, airline
from economy
where departure = 'Delhi' and arrival='Mumbai'
group by airline;  

-- unique departure and arrival

SELECT DISTINCT departure 
FROM economy;

SELECT DISTINCT arrival
FROM economy;

-- Minimum time taken from delhi to banglore

select min(time_taken) as min_time, airline
from economy
where departure = 'Delhi' and arrival='Bangalore'
group by airline;

-- min time and last date of the dataset 

SELECT MIN(time_taken) AS min_time, airline, max(date) AS max_date
FROM economy
WHERE departure = 'Delhi' AND arrival = 'Bangalore'
GROUP BY airline;

-- on 22-03-2022 min time taken from delhi to banglore of which flight
SELECT MIN(time_taken) AS min_time, airline ,date
FROM economy
WHERE departure = 'Delhi' AND arrival = 'Bangalore' and date = '22-03-2022'
GROUP BY date,airline;


-- Lowest price and lowest time duration flight name and date ,time. 

SELECT MIN(time_taken) AS min_time, MIN(price) AS min_price, airline, date, dep_time,arr_time
FROM economy
GROUP BY date, airline,dep_time,arr_time; 


SELECT *
FROM economy
WHERE price = (
    SELECT MIN(price)
    FROM economy
);

SELECT *
FROM economy
WHERE time_taken = (
    SELECT MIN(time_taken)
    FROM economy
);

-- From which airport highest number of flights take-off and airline per departure
  
  select  max(departure) as max_departure_city, count(departure), airline
  from economy
  group by airline;

-- total departure of max departure city
SELECT MAX(departure) AS max_departure_city, COUNT(departure) AS departure_count
FROM economy;

-- From which airport lowest number of flights take-off

SELECT MIN(departure) AS min_departure_city, COUNT(departure) AS departure_count
FROM economy;

--  Which flights are running more on the particular day

select airline, count(airline) as total_airline
from economy
where date = '15-02-2022' 
group by airline
order by total_airline desc ;


--  If flight is going to delhi to Mumbai, bengluru, Chennai, heydrabad and Kolkata how much time it will take in non-stop

select avg(time_taken) as avgtt, airline
from economy
where stop='non-stop ' and departure='Delhi' and arrival='Mumbai' 
group by airline;

Select distinct(departure)
from economy;

-- average time taken of non-stop from delhi to kolkata
select avg(time_taken) as avgtt, airline
from economy
where stop='non-stop ' and departure='Delhi' and arrival='Kolkata' 
group by airline;

-- average time taken of non-stop from delhi to hyderabad

select avg(time_taken) as avgtt, airline
from economy
where stop='non-stop ' and departure='Delhi' and arrival='Hyderabad' 
group by airline;

--  Which flight is taking highest time and how many stops it is taking



SELECT airline, time_taken, stop
FROM economy
WHERE time_taken = (
    SELECT MAX(time_taken)
    FROM economy
);


-- maximum time taken in non-stop

select max(time_taken), airline, stop
from economy
where stop = 'non-stop '
group by airline;

-- Comparing flights as compared to their price and time durations also business class and economy class.

SELECT  price,time_taken, airline
FROM economy
WHERE departure = 'Delhi' AND arrival = 'Mumbai' and date= '10-03-2022'; 

SELECT  price,time_taken, airline
FROM business
WHERE departure = 'Delhi' AND arrival = 'Mumbai' and date= '10-03-2022'; 

-- rename from to departure and to to arrival

ALTER TABLE business
RENAME COLUMN `from` TO departure;

ALTER TABLE business
RENAME COLUMN `to` TO arrival;

-- delhi to mumbai on 10-03-2022 from air india in business class maximum price
SELECT  price,time_taken
FROM business
WHERE departure = 'Delhi' AND arrival = 'Mumbai' and date= '10-03-2022'and airline ='Air India' 
order by price desc; 

-- delhi to mumbai on 10-03-2022 from air india in economy class maximum price
SELECT  price,time_taken
FROM economy
WHERE departure = 'Delhi' AND arrival = 'Mumbai' and date= '10-03-2022'and airline ='Air India' 
order by price desc; 


-- In this query I found out the flights from delhi to mumbai and their departure time is 6 to 7 on '12-03-2022'

SELECT airline, departure, arrival, dep_time, arr_time, date, price
FROM economy
WHERE date = '12-03-2022'
  AND dep_time IN (
    SELECT dep_time
    FROM economy
    WHERE dep_time >= 6 AND dep_time <= 7
  )
  AND departure = 'Delhi'
  AND arrival = 'Mumbai';

-- distinct stop

select distinct(stop) 
from economy;

-- add coloumn class
alter table economy
Add column class varchar (30);

alter table business
Add column class varchar (30);

alter table economy
drop column MyUnknownColumn ;

-- fill economy in economy class'
UPDATE economy
SET class = 'Economy'
WHERE class IS NULL;

-- fill business in business class'
UPDATE business
SET class = 'business'
WHERE class IS NULL;

