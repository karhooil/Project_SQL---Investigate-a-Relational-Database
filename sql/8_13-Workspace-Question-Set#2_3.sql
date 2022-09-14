/* 2_3 */

/*
Finally, for each of these top 10 paying customers, I would like to find out the difference across
their monthly payments during 2007. Please go ahead and write a query to compare the payment amounts in
each successive month. Repeat this for each of these 10 paying customers. Also, it will be tremendously helpful if
you can identify the customer name who paid the most difference in terms of payments.
*/

WITH sub AS (
             SELECT DATE_PART('month', t2.month) AS month,
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
             ORDER BY 3, 2, 1)

SELECT month,
       year,
       name,
       pymt_count,
       pymt_sum,
       LEAD(pymt_sum) OVER (PARTITION BY name ORDER BY year, month) AS lead,
       LEAD(pymt_sum) OVER (PARTITION BY name ORDER BY year, month) - pymt_sum AS lead_diff
FROM sub
WHERE name = (
              SELECT name
              FROM(SELECT month,
                          year,
                          name,
                          pymt_count,
                          pymt_sum,
                          LEAD(pymt_sum) OVER (PARTITION BY name ORDER BY year, month) AS lead,
                          LEAD(pymt_sum) OVER (PARTITION BY name ORDER BY year, month) - pymt_sum AS lead_diff
                   FROM sub
                   ORDER BY 7 DESC NULLS LAST
                   LIMIT 1) AS temp
              );
