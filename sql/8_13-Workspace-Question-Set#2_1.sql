/* 2_1 */

/*
We want to find out how the two stores compare in their count of rental orders during every month for
all the years we have data for. Write a query that returns the store ID for the store,
the year and month and the number of rental orders each store has fulfilled for that month.
*/

SELECT  DATE_PART('month', r.rental_date) AS month,
        DATE_PART('year', r.rental_date) AS year,
        str.store_id,
        COUNT(r.rental_date) AS rental_count
FROM store AS str
JOIN staff AS stf
ON stf.store_id = str.store_id
JOIN rental AS r
ON r.staff_id = stf.staff_id
GROUP BY 1, 2, 3
ORDER BY 4 DESC;
