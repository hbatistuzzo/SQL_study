-- Exercises from https://techtfq.com/blog/learn-how-to-write-sql-queries-practice-complex-sql-queries

USE study;

-- Tables Structure:
drop table users;
create table users
(
user_id int primary key,
user_name varchar(30) not null,
email varchar(50));

INSERT INTO users VALUES
(1, 'Sumit', 'sumit@gmail.com'),
(2, 'Reshma', 'reshma@gmail.com'),
(3, 'Farhana', 'farhana@gmail.com'),
(4, 'Robin', 'robin@gmail.com'),
(5, 'Robin', 'robin@gmail.com');

SELECT * FROM users;

-- FIND THE DUPLICATES
-- ... Using a window function!

SELECT 
	*,
    ROW_NUMBER() OVER (PARTITION BY user_name) as rn
FROM users
ORDER BY user_id;

-- now we can use this as a subquery!

SELECT * FROM
(
SELECT 
	*,
    ROW_NUMBER() OVER (PARTITION BY user_name) as rn
FROM users
ORDER BY user_id
) as x
WHERE x.rn != 1;

-- We could rewrite this as a CTE

WITH x AS
(
SELECT 
	*,
    ROW_NUMBER() OVER (PARTITION BY user_name) as rn
FROM users
ORDER BY user_id
)
SELECT * from x
WHERE x.rn != 1;

-- When to use one or the other is still unclear...



