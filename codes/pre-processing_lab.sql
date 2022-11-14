use sakila;

-- 1
select * from actor WHERE first_name = 'Scarlett';

-- 2 16044 it seems
select count(*) from rental; -- is this the total movies that have been rented?
select count(*) from film;

-- 3
select max(length) AS max_duration, min(length) AS min_duration from film;

-- 4 What's the average movie duration expressed in format (hours, minutes)?
select floor(AVG(length) / 60) AS hours, round(AVG(length) % 60) as minutes from film;

-- 5 How many distinct (different) actors' last names are there?
select count(DISTINCT last_name) from actor;

-- 6 Since how many days has the company been operating (check DATEDIFF() function)?
select DATEDIFF(max(last_update),min(create_date)) from customer;

-- 7 Show rental info with additional columns month and weekday. Get 20 results.
select *, date_format(rental_date, '%M') as 'month', date_format(rental_date, '%W') as 'weekday' from rental; 

-- 8 Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
select *, case when date_format(rental_date, '%W') in ('Saturday', 'Sunday')
          then 'weekend'
          else 'workday' end as day_type
from rental;

-- 9 How many rentals were in the last month of activity?
select date(max(rental_date))- INTERVAL 30 DAY, date(max(rental_date)) from rental;

SELECT count(rental_id) AS total_rentals
FROM rental
WHERE YEAR(rental_date) = 2006 AND MONTH(rental_date) = 2;


-- bah que da hora
SELECT SEC_TO_TIME(AVG(length)*60)  FROM film;

-- usando o concat
select
concat(floor(avg(length)/60),'H ', floor(avg(length)%60), 'M') as 'Duração Média'
From
Film;

use bank;
select issued, str_to_date(issued, '%y%m%d %H:%i:%s') from card;
