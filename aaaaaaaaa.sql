-- subqueries

use bank;

Select * from loan;

SELECT 
    status,
	ROUND(AVG(amount), 2),
    (SELECT ROUND(AVG(amount), 2) AS average1 from loan)-- uma é agregada então precisa de group by
FROM
    loan
group by status;

SELECT
	*
FROM loan
WHERE status in
(SELECT
	status
FROM
(SELECT 
    status,
	ROUND(AVG(amount), 2) AS group_average,
    (SELECT ROUND(AVG(amount), 2) from loan) AS total_average -- uma é agregada então precisa de group by
FROM
    loan
group by status
having avg(amount) > (SELECT ROUND(AVG(amount), 2) AS average1 from loan)) as table_1); -- precisa dar esse nome as table_1 ou da erro


-- 
SELECT ROUND(AVG(amount), 2) AS average1 from loan;


SELECT 
    status, ROUND(AVG(amount), 2) AS average1 -- uma é agregada então precisa de group by
FROM
    loan
group by status
having avg(amount) > (SELECT ROUND(AVG(amount), 2) AS average1 from loan);


-- CTEs jesus christ

