/* 1_1 */

/*
We want to understand more about the movies that families are watching.
The following categories are considered family movies: Animation, Children, Classics, Comedy, Family and Music.
Create a query that lists each movie, the film category it is classified in,
and the number of times it has been rented out.
*/

WITH fam_mov AS (
                 SELECT f.title,
                        c.name AS genre,
                        r.rental_id
                 FROM film AS f
                 JOIN film_category AS fc
                 ON fc.film_id = f.film_id
                 JOIN category AS c
                 ON c.category_id = fc.category_id
                 JOIN inventory AS i
                 ON i.film_id = f.film_id
                 JOIN rental AS r
                 ON r.inventory_id = i.inventory_id
                 WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
                 )

SELECT  title AS movie_title,
        genre,
        COUNT(rental_id) AS rent_frequency
FROM fam_mov
GROUP BY 1, 2
ORDER BY 3 DESC, 2, 1;
