-- 5 SELECT
-- 1 FROM
-- 1 JOIN
-- 2 WHERE
-- 3 GROUP BY
-- 4 HAVING
-- 6 ORDER BY
-- 7 LIMIT

-- WHERE is the filter structure, can be used with >, <, =>,<=,<>,!=,BETWEEN,LIKE, REGEXP as well as using multiple conditions with AND/OR
SELECT
	`card_id` AS ID
	,type
FROM card AS c
WHERE card_id<1000 AND card_id >500; 

SELECT
	`card_id` AS ID
	,type
FROM card AS c
WHERE card_id BETWEEN 500 AND 1000 AND type = 'junior';

SELECT DISTINCT
	-- `card_id` AS ID
	type
FROM card AS c
WHERE type LIKE '%o%'; -- específico para caracteres, pega tudo com um o entre as outras letras. _ especificaria apenas um caractere.

SELECT DISTINCT
	-- `card_id` AS ID
	type
FROM card AS c
WHERE type LIKE '_o%';

SELECT DISTINCT
	-- `card_id` AS ID
	type
FROM card AS c
WHERE type REGEXP '^[a-g]';
-- In the SELECT statement we can use several columns calculations 
-- text REPLACE, REGEX_REPLACE, lenght, concat, lower, upper, left, right, substring documentation https://dev.mysql.com/doc/refman/8.0/en/string-functions.html
-- numeric count, AVG, floor, ceiling, MAX, MIN, round and numeric operations +,-,/,* https://dev.mysql.com/doc/refman/8.0/en/numeric-functions.html
-- date functions https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html

-- bora fazer um exercicio da hora
SELECT 
    A2 AS district_name, A11 AS average_salary
FROM
    district
WHERE
    A11 > 10000;

SELECT * from loan WHERE status = 'B';

SELECT * from card WHERE type = 'junior' LIMIT 10;

SELECT loan_id, account_id, amount from loan WHERE status = 'B';

SELECT A2 AS district_name, A10 AS urban_population FROM district; -- whoops round(A4*(A10/100))

SELECT A2 AS district_name, A10 AS urban_population FROM district WHERE A10 > 50.0; -- whoops WHERE (100 - A10)>50

-- voltando ao conteúdo
SELECT 
	REGEXP_REPLACE(type,'[a-g]','aaargh')
FROM card AS c;

SELECT 
	length(A3)
    ,A3 AS regiao
    ,A4
    ,concat(A3,' ', A4)
    ,lower(A3)
    ,upper(A3)
    ,left(A3,2)
    ,right(A3,3)
    ,substring(A3,2,4) 
FROM district AS c;



SELECT
date_format(left(date,6),'%Y')
FROM
trans;


SELECT 
	count(amount)
    , AVG(amount)
    , MAX(amount)
    , MIN(amount)
FROM `order`;


SELECT 
	amount
    , round((amount/3), 4) AS round
    , floor((amount/3)) AS floor
    , ceiling((amount/3)) AS ceiling
FROM `order`;

SELECT 
	amount/3
    ,bank_to
    , round((amount/3), -3) AS round
    , floor((amount/3)) AS floor
    , ceiling((amount/3)) AS ceiling
FROM `order`
WHERE bank_to REGEXP('[N-Z]');

-- LIMIT(how many lines you get) AND OFFSET (line to start)
SELECT 
	amount/3
    ,bank_to
    , round((amount/3), -3) AS round
    , floor((amount/3)) AS floor
    , ceiling((amount/3)) AS ceiling
FROM `order`
WHERE not bank_to REGEXP('[N-Z]')
LIMIT 2 OFFSET 3;

-- ORDER BY can be ASC(lower to bigger) or DESC (bigger to lower) and have multiple columns

SELECT 
	amount/3
    ,bank_to
    , round((amount/3), -3) AS round
    , floor((amount/3)) AS floor
    , ceiling((amount/3)) AS ceiling
FROM `order`
WHERE not bank_to REGEXP('[N-Z]')
ORDER BY bank_to DESC
LIMIT 10;

SELECT
* 
FROM bank.order
ORDER BY bank_to DESC, amount DESC;


-- Case when will show results depending in a condition, the result can be a constant or a operation with columns. We can do multiple conditions
SELECT 
*,
CASE WHEN amount<1000 THEN 
	CASE WHEN amount<500 THEN 'Muito pequeno' ELSE 'pequeno' END 
ELSE CASE WHEN amount<1500 THEN 'MEdio' ELSE 'GRANDE' END END AS Tamanho,

CASE
WHEN amount<1000 THEN 'Pequeno'
WHEN amount<1500 THEN 'Medio'
ELSE 'Grande' END
FROM `order`
WHERE not bank_to REGEXP('[N-Z]')
ORDER BY bank_to DESC
LIMIT 10;

-- Group by show the result of a aggregation function to all the possible groups in the group by clause
-- All the columns in the select statement have to be either in a aggregation function or in the group by statement

SELECT
	AVG(amount),
	account_id,
	operation,
    MAX(amount),
	min(amount),
	AVG(balance)
FROM 
	trans
WHERE account_id>1000 
GROUP BY account_id, operation
HAVING max(amount)>30000
ORDER BY operation DESC, account_id DESC
LIMIT 1000;



SELECT DISTINCT
account_id, operation
FROM 
trans
ORDER BY account_id;


SELECT
*
FROM 
trans
WHERE account_id=576 AND operation = 'VKLAD' ;

-------------------------------------------------------------------------------------------------------

/*
RESUMO

SELECT 
	REGEX_REPLACE(),
	REPLACE(),
	ROUND(),
	FLOOR(),
	CEILING(),
	CASE WHEN THEN END,
	DATE_FORMAT(),
FROM 
	table_name
WHERE column >, <, =>,<=,<>,!= value AND  column BETWEEN value1 and value 2 OR column LIKE '%value_' AND column REGEXP 'pattern';


SELECT
	column1,
	MAX(column2),
	MEAN(column2)
FROM
	table
groupby column1
HAVING mean(column2)>value;


*/

-- Late exercise

SELECT type,issued FROM card WHERE type ='junior' AND issued > 980000;

SELECT DISTINCT type FROM trans WHERE operation='VYBER'; -- baah então vem os 2 tipos, VYDAJ e VYBER

SELECT * FROM trans WHERE operation='VYBER';

SELECT loan_id, account_id, amount-payments FROM loan WHERE amount-payments > 1000 AND status = 'B';

SELECT max(amount),min(amount) FROM trans WHERE amount != 0;

SELECT *,date_format(date,'%Y'),year(date),concat('19',left(date,2)) FROM account;

-- 
SELECT * FROM `order` WHERE amount<500;

SELECT *, CASE WHEN amount<500 THEN 'Pequeno' ELSE 'Grande' END AS tamanho FROM `order`;

SELECT 
    *,
    CASE WHEN amount < 500 THEN 'Pequeno'
		WHEN amount < 1000 THEN 'Medio'
        ELSE 'Grande'
		END AS tamanho
FROM
    `order`;
    
    SELECT 
    *,
    CASE WHEN amount < 500 THEN 'Pequeno'
		WHEN bank_to='YZ' THEN 'Transação grande para banco Y'
        ELSE 'Grande'
		END AS tamanho
FROM
    `order`;

    SELECT 
    *,
    CASE WHEN amount > 500 AND bank_to='YZ' THEN 'Transação grande para banco Y'
		WHEN amount BETWEEN 0 AND 500 THEN NULL
        ELSE 'Grande'
		END AS tamanho
FROM
    `order`;

-- activity 4

SELECT * FROM trans WHERE amount IS NULL;

SELECT * FROM trans WHERE k_symbol LIKE '';

SELECT
	COUNT(CASE WHEN k_symbol <> '' THEN 1 ELSE NULL END),
    COUNT(CASE WHEN k_symbol = '' THEN 1 ELSE NULL END)
FROM
	trans;










