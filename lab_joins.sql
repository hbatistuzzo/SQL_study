use sakila;

-- Write a query to display for each store its store ID, city and country.
select * from store; -- vai ter um groupby store (são duas lojas). store_id, manager_staff_id, ADDRESS_ID e last_update

select * from address; -- ADDRESS_ID, address, address2, district, city_id, postal_code, phone, location, last_update. 603 linhas

select * from city; -- city_id, city, COUNTRY_ID, last_update 600 linhas

select * from country; -- COUNTRY_ID, country, last_update 109 linhas

select store_id, city.city, country
from address
join city on address.city_id = city.city_id -- me retorna 603 linhas. Ok, falta juntar com store atraves do address_id, que tambem tem no address.
join country on city.country_id = country.country_id
join store on address.address_id = store.address_id
group by store_id;

-- guilherme:
SELECT 
	store_id
    , city.city
    , country
FROM store 
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON country.country_id = city.country_id
GROUP BY store_id;


-- Write a query to display how much benefit amount, in dollars, each store brought in.
select staff.staff_id,sum(amount) from payment -- payment_id, customer_id, !!staff_id!!, rental_id, amount, payment_date, last_update
join staff on staff.staff_id = payment.staff_id
group by store_id;

-- What is the average running time of films by category?
select * from film; -- film_id
select * from category; -- category_id, name, last_update
select * from film_category; -- film_id, category_id, last_update

select name, avg(length)
from film
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
group by name;

-- Which film categories are longest on average?
select name, avg(length)
from film
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
group by name
order by avg(length) desc;

-- Display the most frequently rented movies in descending order.
select * from rental; -- rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update
select * from inventory; -- inventory_id, film_id, store_id, last_update
select * from film; -- blablabalbal including filmd_id








