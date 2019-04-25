# chris flint sql homework
# 3/18/2019

use sakila;

# 1a
SELECT first_name, last_name
FROM actor;

# 1b
SELECT CONCAT(UPPER(first_name), ' ', UPPER(last_name)) AS 'Actor Name'
FROM actor;

# 2a
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';

# 2b
SELECT * FROM actor
WHERE last_name LIKE '%GEN%';

# 2c
SELECT * FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name , first_name;

# 2d
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan' , 'Bangladesh', 'China');

# 3a
ALTER TABLE actor
ADD description BLOB;

# 3b 
ALTER TABLE actor
DROP description;

# 4a
SELECT  last_name, COUNT(last_name) AS 'Last Name Count'
FROM actor
GROUP BY last_name;

# 4b
SELECT last_name, COUNT(last_name) AS 'Last Name Count'
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) >= 2;

# 4c
SELECT * FROM actor
WHERE first_name = 'GROUCHO'
	AND last_name = 'WILLIAMS';

UPDATE actor SET first_name = 'HARPO'
WHERE actor_id = 172;

-- verify new name 
SELECT * FROM actor
WHERE first_name = 'GROUCHO'
	AND last_name = 'WILLIAMS';

-- verify old name gone
SELECT * FROM actor
WHERE first_name = 'HARPO'
AND last_name = 'WILLIAMS';

# 4d
UPDATE actor SET first_name = 'GROUCHO'
WHERE actor_id = 172;

# 5a
DESCRIBE address;

# 6a
SELECT s.first_name, s.last_name, a.address
FROM staff AS s JOIN
address AS a ON a.address_id = s.address_id;

# 6b
SELECT s.first_name, s.last_name, SUM(p.amount) AS 'Total Amount'
FROM staff AS s JOIN
payment AS p ON p.staff_id = s.staff_id
GROUP BY s.first_name , s.last_name;

# 6c
SELECT f.title, COUNT(fa.actor_id) AS 'Count of Actors'
FROM film AS f INNER JOIN
film_actor AS fa ON fa.film_id = f.film_id
GROUP BY title;

# 6d
SELECT COUNT(i.inventory_id)
FROM inventory AS i JOIN
film AS f ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible';

# 6e
SELECT c.first_name, c.last_name, SUM(p.amount) AS 'Total Amount'
FROM customer AS c JOIN
payment AS p ON p.customer_id = c.customer_id
GROUP BY c.first_name , c.last_name
ORDER BY c.last_name ASC;

# 7a
SELECT * FROM
    (SELECT title
    FROM film
    WHERE
        LEFT(title, 1) IN ('K' , 'Q')
            AND language_id = (SELECT 
                language_id
            FROM
                language
            WHERE
name = 'English')) AS a;

# 7b
SELECT first_name, last_name
FROM actor
WHERE
    actor_id IN (SELECT 
            actor_id
        FROM
            film_actor
        WHERE
            film_id = (SELECT 
                    film_id
                FROM
                    film
                WHERE
title = 'Alone Trip'));

# 7c
SELECT 
    c.first_name, c.last_name, c.email
FROM
    customer AS c
        LEFT JOIN
    address AS a ON a.address_id = c.address_id
        LEFT JOIN
    city AS city ON city.city_id = a.city_id
        LEFT JOIN
    country AS co ON co.country_id = city.country_id
WHERE
co.country = 'Canada';

# 7d
SELECT 
    f.title
FROM
    film AS f
        LEFT JOIN
    film_category fc ON fc.film_id = f.film_id
        LEFT JOIN
    category AS c ON c.category_id = fc.category_id
WHERE
c.name = 'family';

# 7e
SELECT 
    f.title
FROM
    film AS f
        LEFT JOIN
    inventory AS i ON i.film_id = f.film_id
        LEFT JOIN
    (SELECT 
        COUNT(rental_id) AS 'RentalCount', inventory_id
    FROM
        rental
    GROUP BY inventory_id) AS r ON r.inventory_id = i.inventory_id
GROUP BY f.title
ORDER BY SUM(r.RentalCount) DESC;

# 7f
SELECT 
    s.store_id, ROUND(SUM(p.amount), 0) AS 'Income'
FROM
    store AS s
        JOIN
    inventory AS i ON i.store_id = s.store_id
        JOIN
    rental AS r ON r.inventory_id = i.inventory_id
        JOIN
    payment AS p ON p.rental_id = r.rental_id
GROUP BY store_id;

# 7g
SELECT 
    s.store_id, c.city, co.country
FROM
    store AS s
        JOIN
    address AS a ON a.address_id = s.address_id
        JOIN
    city AS c ON c.city_id = a.city_id
        JOIN
country AS co ON co.country_id = c.country_id;

# 7h
SELECT 
    cat.name, SUM(p.Amount) AS 'gross_amt'
FROM
    category AS cat
        LEFT JOIN
    film_category AS fc ON fc.category_id = cat.category_id
        LEFT JOIN
    inventory AS i ON i.film_id = fc.film_id
        LEFT JOIN
    rental AS r ON r.inventory_id = i.inventory_id
        LEFT JOIN
    payment AS p ON p.rental_id = r.rental_id
GROUP BY cat.name
ORDER BY SUM(p.Amount) DESC
LIMIT 5;

# 8a
CREATE VIEW top_genres_by_revenue AS
    (SELECT 
        cat.name
    FROM
        category AS cat
            LEFT JOIN
        film_category AS fc ON fc.category_id = cat.category_id
            LEFT JOIN
        inventory AS i ON i.film_id = fc.film_id
            LEFT JOIN
        rental AS r ON r.inventory_id = i.inventory_id
            LEFT JOIN
        payment AS p ON p.rental_id = r.rental_id
    GROUP BY cat.name
    ORDER BY SUM(p.Amount) DESC
LIMIT 5);

# 8b 
select * from top_genres_by_revenue;

# 8c
drop view top_genres_by_revenue;