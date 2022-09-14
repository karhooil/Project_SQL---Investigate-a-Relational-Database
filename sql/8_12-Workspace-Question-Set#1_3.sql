/* 1_3 */

/*
Finally, provide a table with the family-friendly film category, each of the quartiles,
and the corresponding count of movies within each combination of film category for
each corresponding rental duration category.
*/

WITH fammov_rentdurquar AS (
                             SELECT  f.title AS movie_title,
                                     c.name AS genre,
                                     f.rental_duration AS rental_duration,
                                     NTILE(4) OVER (ORDER BY f.rental_duration) AS rental_duration_quartile
                             FROM film AS f
                             JOIN film_category AS fc
                             ON fc.film_id = f.film_id
                             JOIN category AS c
                             ON c.category_id = fc.category_id
                             WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
                             )

SELECT  genre,
        rental_duration_quartile,
        COUNT(movie_title) AS movie_title_count
FROM fammov_rentdurquar
GROUP BY 1, 2
ORDER BY 3 DESC, 2, 1;
