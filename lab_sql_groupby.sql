use sakila;

-- Using the rental table, find out how many rentals were processed by each employee.
select staff_id, count(staff_id) from rental group by staff_id;

select * from rental;apple_tableapple_table

-- Using the film table, find out how many films were released.
select count(film_id) from film;

-- Using the film table, find out how many films there are of each rating. Sort the results in descending order of the number of films.
select rating, count(film_id) from film group by rating order by count(title) desc;

-- Which kind of movies (rating) have a mean duration of more than two hours?
select *,AVG(length) from film group by rating having avg(length) > 120; -- 


-- guilherme embaixo
SELECT 
	rating
    , AVG(length) as tamanho
FROM
	film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY AVG(length)DESC;


-- outro exercicio
drop database if exists lab_apple;

use lab_apple;

select * from apple_table;

-- **1. What are the different genres?**

select DISTINCT prime_genre from apple_table;

-- ou....

SELECT 
    prime_genre
FROM 
    apple_table
GROUP BY 
    prime_genre;

-- **2. Which is the genre with the highest number of ratings?**
select prime_genre,sum(rating_count_tot) as TOTAL_RATING from apple_table where rating_count_tot > 0 order by TOTAL_RATING DESC LIMIT 10;


-- **3. Which is the genre with most apps?** its games
select prime_genre,count(track_name) as COUNTER from apple_table group by prime_genre order by COUNTER desc;

-- **4. Which is the genre with the fewest apps?**
select prime_genre,count(track_name) as COUNTER from apple_table group by prime_genre order by COUNTER;

-- **5. Find the top 10 apps most rated.**
SELECT track_name,rating_count_tot from apple_table order by rating_count_tot desc;

-- **6. Find the top 10 apps best rated by users.**
SELECT track_name, user_rating FROM apple_table ORDER BY user_rating DESC;

-- **7. Using the same query from the previous exercise add the column `rating_count_tot`.**
SELECT track_name, user_rating, rating_count_tot FROM apple_table ORDER BY user_rating DESC;

-- **8. Now, find the top 5 ordering by ratings and number of votes.**
SELECT track_name, user_rating, rating_count_tot FROM apple_table ORDER BY user_rating DESC, rating_count_tot DESC;

-- **9. Find the total number of games available in more than 1 language.**
SELECT track_name, prime_genre, langnum FROM apple_table WHERE prime_genre = 'Games' AND langnum > 1;

-- **10. Find the number of free vs paid apps.**
SELECT COUNT(price = 0) as "free_app", COUNT(price > 0) as "paid_app" FROM apple_table;

SELECT COUNT(CASE WHEN price = 0 THEN 'free'  END) as "free_app", COUNT(CASE WHEN price > 0 THEN 'paid'  END) as "paid_app"
FROM apple_table;

-- **11. Find the number of free vs paid apps for each genre.**
SELECT 
	prime_genre,
	COUNT(CASE 
			WHEN price = 0 THEN 'free'  
		  END) as paid_app,
	COUNT(CASE 
			WHEN price > 0 THEN 'paid'  
		  END) as free_app
FROM 
	apple_table
GROUP BY
	prime_genre
ORDER BY
	paid_app DESC
