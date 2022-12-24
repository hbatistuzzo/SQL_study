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

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- 2)

drop table employee;
create table employee
( emp_ID int primary key
, emp_NAME varchar(50) not null
, DEPT_NAME varchar(50)
, SALARY int);

insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh',  'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);

select * from employee;

-- Write a SQL query to fetch the second last record from employee table.

WITH x AS
(
SELECT *,
ROW_NUMBER() OVER (ORDER BY emp_id DESC) as rn
FROM employee
)
SELECT * FROM x
WHERE x.rn = 2;

-- This works. It's important to note that when you apply an aggregate function like ROW_NUMBER() OVER something,
-- it DOES NOT NEED TO BE A PARTITION BY.
-- it can straight up be an ORDER BY!

-- Below I created an exercise that one day I will upload to codewars. Must learn Ruby first..
-- WITH x AS
-- (
-- SELECT *,
-- ROW_NUMBER() OVER (ORDER BY SALARY DESC) as rn
-- FROM employee
-- )
-- SELECT * FROM x
-- WHERE x.SALARY > 9000;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- 3)

-- Write a SQL query to display only the details of employees who either earn the highest salary or the lowest salary in each department from the employee table.

WITH w as 
(SELECT *,
MAX(salary) OVER (PARTITION BY dept_name) AS max_salary,
MIN(salary) OVER (PARTITION BY dept_name) AS min_salary
FROM employee)
SELECT *
FROM w
WHERE salary = max_salary OR salary = min_salary
ORDER BY dept_name, salary;

-- His crazy solution uses a JOIN
select x.*
from employee e
join (select *,
max(salary) over (partition by dept_name) as max_salary,
min(salary) over (partition by dept_name) as min_salary
from employee) x
on e.emp_id = x.emp_id
and (e.salary = x.max_salary or e.salary = x.min_salary)
order by x.dept_name, x.salary;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- 4)

drop table doctors;
create table doctors
(
id int primary key,
name varchar(50) not null,
speciality varchar(100),
hospital varchar(50),
city varchar(50),
consultation_fee int
);

insert into doctors values
(1, 'Dr. Shashank', 'Ayurveda', 'Apollo Hospital', 'Bangalore', 2500),
(2, 'Dr. Abdul', 'Homeopathy', 'Fortis Hospital', 'Bangalore', 2000),
(3, 'Dr. Shwetha', 'Homeopathy', 'KMC Hospital', 'Manipal', 1000),
(4, 'Dr. Murphy', 'Dermatology', 'KMC Hospital', 'Manipal', 1500),
(5, 'Dr. Farhana', 'Physician', 'Gleneagles Hospital', 'Bangalore', 1700),
(6, 'Dr. Maryam', 'Physician', 'Gleneagles Hospital', 'Bangalore', 1500);

select * from doctors;
-- From the doctors table, fetch the details of doctors who work in the same hospital but in different specialty.

SELECT a.*
FROM doctors a
JOIN doctors b on a.id <> b.id -- THIS IS NEW!!!!! the primary key MUST NOT be the same otherwise I'm comparing the same people
WHERE a.hospital = b.hospital AND a.speciality != b.speciality;

SELECT a.*
FROM doctors a
JOIN doctors b on a.id <> b.id
WHERE a.hospital = b.hospital; -- this is for the extra exercise 4b



