-- How many copies of the film Hunchback Impossible exist in the inventory system?
use sakila;

SELECT 
    *
FROM
    inventory
join film on film.film_id = inventory.film_id
having title = 'Hunchback Impossible'; -- precisa do film_id do Hunchback Impossible
-- tem 6 copias


-- List all films whose length is longer than the average of all the films.
SELECT 
    *
FROM
    film
where length > (SELECT AVG(length) FROM film); -- average of all films is 115.2720


-- Use subqueries to display all actors who appear in the film Alone Trip.
SELECT *
FROM film_actor
WHERE film_id in
(SELECT film_id FROM film where actor_id in (select actor_id FROM actor));

SELECT * from actor where actor_id in (SELECT actor_id from film_actor where film_id in (SELECT film_id from film where title = 'Alone Trip'));

	-- com join:
	SELECT 
		*
	FROM
		film_actor
	join actor on actor.actor_id = film_actor.actor_id
	join film on film.film_id = film_actor.film_id
	having title = 'Alone Trip';


-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT * from film where film_id in (SELECT film_id from film_category where category_id in (SELECT category_id from category where name = 'Family'));

SELECT
	*
FROM film
join film_category on film_category.film_id = film.film_id
join category on category.category_id = film_category.category_id
where category.name = 'Family'; -- deu 69 filmes


-- Get name and email from customers from Canada using subqueries. Do the same with joins.
-- Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.

select * from customer where address_id in (select address_id from address where city_id in (SELECT city_id from city where country_id in (SELECT country_id from country where country = 'Canada')));

SELECT
	first_name, last_name, email, country
FROM customer -- 559 on customer
join address on address.address_id = customer.address_id -- 599
join city on city.city_id = address.city_id -- 599
join country on country.country_id = city.country_id
having country = 'Canada'; -- 5 lucky customers

-- Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films.
-- First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

select * from film_actor join (SELECT actor_id FROM film_actor GROUP BY actor_id order by count(*) DESC limit 1) as a on film_actor.actor_id = a.actor_id;

select actor_id, COUNT(film_id) from film_actor where actor_id in (SELECT actor_id FROM film_actor GROUP BY actor_id) group by actor_id order by count(film_id) desc;

select * from actor where actor_id = (select actor_id from actor where actor_id = (select actor_id from film_actor group by actor_id order by count(film_id) desc limit 1));

SELECT * FROM FILM where film_id in (select film_id from film_actor join(SELECT actor_id FROM film_actor
GROUP BY actor_id
order by count(*) DESC
limit 1) as a on film_actor.actor_id = a.actor_id);


-- Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments
SELECT *
FROM customer;

SELECT customer_id from payment group by customer_id order by sum(amount) desc; -- ok isso acha o most profitable customer

select * from film where film_id in (select film_id from inventory where inventory_id in (select inventory_id from rental where customer_id = (SELECT customer_id from payment group by customer_id order by sum(amount) desc limit 1))) order by film_id;

-- Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.
SELECT customer_id, sum(amount) as total from payment group by customer_id having total > AVG(amount); -- having sum(amount) > AVG(sum(amount);

select avg(bla.total) from (select *,sum(amount) as total from payment group by customer_id) as bla;

SELECT customer_id, sum(amount) as total from payment group by customer_id having total > (select avg(bla.total) from (select *,sum(amount) as total from payment group by customer_id) as bla);
