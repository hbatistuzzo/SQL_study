CREATE DATABASE window_funcs;

CREATE TABLE employees (
    emp_no INT PRIMARY KEY AUTO_INCREMENT,
    department VARCHAR(20),
    salary INT
);

INSERT INTO employees (department, salary) VALUES
('engineering', 80000),
('engineering', 69000),
('engineering', 70000),
('engineering', 103000),
('engineering', 67000),
('engineering', 89000),
('engineering', 91000),
('sales', 59000),
('sales', 70000),
('sales', 159000),
('sales', 72000),
('sales', 60000),
('sales', 61000),
('sales', 61000),
('customer service', 38000),
('customer service', 45000),
('customer service', 61000),
('customer service', 40000),
('customer service', 31000),
('customer service', 56000),
('customer service', 55000);

SELECT * FROM employees;

SELECT emp_no, department, salary, AVG(SALARY) OVER() FROM employees; -- will repeat all info over all rows

SELECT
	emp_no,
	department,
    salary,
    AVG(salary) OVER(PARTITION BY department) as dept_average,
    AVG(salary) OVER() as company_average
FROM employees;

SELECT
	emp_no,
	department,
    salary,
    SUM(salary) OVER (PARTITION BY department) as total_dept_salary,
    SUM(salary) OVER (PARTITION BY department ORDER BY salary) as rolling_dept_salary
FROM employees;

-- RANK: order salaries
SELECT
	emp_no,
	department,
    salary,
	RANK() OVER(PARTITION by department ORDER BY salary DESC) as department_salary_rank,
    RANK() OVER(ORDER BY salary DESC) as overall_salary_rank
FROM employees;

SELECT
	emp_no,
	department,
    salary,
	RANK() OVER(PARTITION by department ORDER BY salary DESC) as department_salary_rank,
    RANK() OVER(ORDER BY salary DESC) as overall_salary_rank
FROM employees
ORDER BY department;

