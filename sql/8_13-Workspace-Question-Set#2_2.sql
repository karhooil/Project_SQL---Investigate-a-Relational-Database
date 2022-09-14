/* 2_2 */

/*
We would like to know who were our top 10 paying customers, how many payments they made on a monthly basis during
2007, and what was the amount of the monthly payments. Can you write a query to capture the customer name,
month and year of payment, and total payment amount for each month by these top 10 paying customers?
*/

SELECT  DATE_PART('month', t2.month) AS month,
        DATE_PART('year', t2.month) AS year,
        t2.name,
        t2.pymt_count,
        t2.pymt_sum
FROM(SELECT CONCAT(c.first_name, ' ', c.last_name) AS name,
            SUM(p.amount) AS pymt_sum
     FROM payment AS p
     JOIN customer AS c
     ON c.customer_id = p.customer_id
     GROUP BY 1
     ORDER BY 2 DESC
     LIMIT 10) AS t1
JOIN(SELECT DATE_TRUNC('month', p.payment_date) AS month,
            CONCAT(c.first_name, ' ', c.last_name) AS name,
            COUNT(p.payment_date) AS pymt_count,
            SUM(p.amount) AS pymt_sum
     FROM payment AS p
     JOIN customer AS c
     ON c.customer_id = p.customer_id
     GROUP BY 1, 2) AS t2
ON t2.name = t1.name
ORDER BY 3, 2, 1;
