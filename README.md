![GitHub top language](https://img.shields.io/github/languages/top/hbatistuzzo/SQL_study)
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/hbatistuzzo/SQL_study)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/hbatistuzzo/SQL_study)
![GitHub last commit](https://img.shields.io/github/last-commit/hbatistuzzo/SQL_study)


# Tips!
- Wildcards are extremely useful
	- SELECT * from movie_tables WHERE title = "story" will find a movie whose title is EXACTLY story
	- SELECT * from movie_tables WHERE title LIKE "story" will find a movie whose title is either story or Story or STORY etc
		- Use % with LIKE to match a sequence of 0 or more characters
			- SELECT * from movie_tables WHERE title LIKE "%story" will find Toy Story
			- SELECT * from movie_tables WHERE title LIKE "%story%" will find Toy Story, Toy Story 2 and Toy Story 3
		- Use _ in a similar fashion, but to match exactly 1 character
			- SELECT * FROM movies WHERE Title LIKE "WALL-_" will find WALL-E and WALL-G, but would not find WALL-EEE if it existed.


---------

## The Ultimate MySQL Bootcamp: Go from SQL Beginner to Expert

---

### Core and Installation

<p> Your app --> (R)DBMS --> Database</p>

> The (R)DBMS, (Relational) Database Management System would be PostgreSQL, Oracle, MySQL etc.

<p>We can define a Database as a ___structured set of computerized data with an accessible interface___.</p>


<p>Cool I didnt need to uninstall python to make this work. Great!</p>

---

### Manipulating Databases

To list available databases: ___show databases___;

To create: ___CREATE DATABASE <name>;___
To delete: ___DROP DATABASE <name>;___ * CAREFUL WITH THIS, it will delete everything * <br>
To use: ___USE <name>;___ | ___SELECT database();___ should confirm that its working. <br>

---

### Tables

Tables hold the data:
> A collection of related data held in a structured format within a database.

---

### Data Types

There is a whole bunch of Numeric Types, String Types and Date Types. Some need caution:
- INT: range from -2,147,483,647 to 2,147,483,647
- VARCHAT: a variable-length string e.g. 'coffee' or '-9999' or 'aASDJH daksjhdasj'. We can specify a maximum of chars e.g. varchar(100) to limit size.

---

### Create New Table:

| Syntax                   | Example           |
|--------------------------|-------------------|
| CREATE TABLE <tablename> | CREATE TABLE cats |
| (                        | (                 |
| column_name data_type    | name VARCHAR(100) |
| column_name data_type    | age INT           |
| );                       | );                |
It can be verified with SHOW TABLES or even SHOW COLUMNS FROM <tablename> or even DESC <tablename> (from describe). Not realy useful in GUI. <br>

### Delete Table:

DROP TABLE <tablename>; just like databases. No prompts to confirm so watch out.

---

### Inserting data into tables:

Insert a cat:
> INSERT INTO cats (name, age) VALUES ('Blue Steele', 5);

And another:

> INSERT INTO cats (name, age) VALUES ('Jenkins', 7);

Multi-inserts are useful as well, just need to be consistent with the order of columns:

> INSERT INTO cats (name, age) 
VALUES 
  ('Meatball', 5), 
  ('Turkey', 1), 
  ('Potato Face', 15);


By the way, we can tell a table that empty (NULL) values are not permitted when creating them:
> CREATE TABLE cats2 (
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL
);

___good practice: always use single quotes!___

... when needed e.g. ___INSERT INTO shops(name) VALUES 'mario's pizza'___ what you need is ___INSERT INTO shops(name) VALUES 'mario\'s pizza'___

---

### To set default values:


Define a table with a DEFAULT name specified:

> CREATE TABLE cats3  (    
>     name VARCHAR(20) DEFAULT 'no name provided',    
>     age INT DEFAULT 99  
> );

Notice the change when you describe the table:

> DESC cats3;

Insert a cat without a name:

> INSERT INTO cats3(age) VALUES(13);

Or a nameless, ageless cat:

> INSERT INTO cats3() VALUES();

Combine NOT NULL and DEFAULT:

> CREATE TABLE cats4  (		
>     name VARCHAR(20) NOT NULL DEFAULT 'unnamed',	
>     age INT NOT NULL DEFAULT 99 
> );

---

### KEYS

We use a primary key e.g. CatID to make each entry unique. It's an unique identifier. ___They cannot be NULL!!!___

-- Another option would be:

> CREATE TABLE unique_cats2 (	
> 	cat_id INT PRIMARY KEY,	
> 	name VARCHAR(100) NOT NULL,	
> 	age INT NOT NULL,
> );


-- AUTO-INCREMENT is useful here! It starts at 1 by default.

> CREATE TABLE unique_cats3 (	
> 	cat_id INT AUTO_INCREMENT,	
> 	name VARCHAR(100) NOT NULL,	
> 	age INT NOT NULL,	
> 	PRIMARY KEY (cat_id)	
> );

---


## CRUD

- ___WHERE___ is case insensitive.

- UPDATE and SET go together.
	- UPDATE <tablename> SET <attribute>.
	- A WHERE <condition> might be useful.

- A good rule of thumb is SELECTing before you UPDATE

- DELETE FROM <tablename> WHERE <attributes> = 'something'
	- DELETE FROM <tablename>; by itself will delete ___EVERYTHING___

---


### String Functions

All to do with texts!

- CONCAT()
	- Useful for joining, say, first and last names.
		- SELECT CONCAT(author_fname, ' ',author_lname) FROM books; ___that ' ' is handy for inserting a blank space___
- CONCAT_WS() is another flavor
	- first argument is separator. It goes between items.
		- SELECT CONCAT_WS('-',author_fname,author_lname) AS full_name FROM books;

- SUBSTRING
	- SELECT SUBSTRING('Hello World'), 1, 4).
		- Start at 1, go for the length of 4: 'Hell'.
		- The 3rd argument can be ommited, it will just go to the end.
	- SELECT SUBSTRING('Hello World'), -3).
		- Would give 'rld'. It starts at -3 and go to the end.
		
___remember that you can combine string functions!___

e.g.

	SELECT CONCAT
   	 (
     	   SUBSTRING(title, 1, 10),
    	    '...'
  	  ) AS 'short title'
	FROM books;


- REPLACE
	- this does NOT update rows. It's for the output. Case matters.
		- SELECT REPLACE ('Hello World', 'Hell', '$&*@'); yields $&*@o World
		- SELECT REPLACE('cheese bread coffee milk', ' ', ' and '); yields cheese and bread and coffeee and milk

- REVERSE
	- It's self explanatory come on.
		- SELECT CONCAT(author_fname, REVERSE(author_fname)) FROM books;

- CHAR_LENGTH
	- not to be confused with LENGTH (that one is measured in bytes).
		- SELECT CONCAT(author_lname, ' is ', CHAR_LENGTH(author_lname), ' characters long') FROM books;


- UPPER and LOWER
	- to change the casing.
		- SELECT CONCAT('MY FAVORITE BOOK IS ', UPPER(title), ' !!!') FROM books;

- Other useful ones:
	- INSERT, LEFT, RIGHT, REPEAT, TRIM.
		- TRIM is worth checking the documentation, to use LEADING.


---

### REFINING SELECTIONS

#### DISTINCT

- SELECT DISTINCT author_lname FROM books;
	- works like "unique"

what about distinct full names?

- SELECT author_fname, author_lname FROM books;

- SELECT DISTINCT(CONCAT(author_fname, ' ' ,author_lname)) FROM books; -- yields 12 results!
	- This works, but even better...

- SELECT DISTINTC (author_fname, author_lname) FROM books;


#### ORDER BY

- SELECT book_id, author_fname, author_lname FROM books ORDER BY author_lname;
	- alphabetic by last name. NULL always come first
	- NULL always come first.
	- you can add DESC at the end to reverse the order.
	- and you can group by more than 1 attribute

#### LIMIT
	- self-explanatory, but you can use LIMIT 2,3 (starting row, and how many you want to retreat).

#### LIKE
	- SELECT title, author_fname, author_lname FROM books WHERE author_fname = 'David'
		- Has to be an EXACT MATCH!
	- SELECT title, author_fname, author_lname FROM books WHERE author_fname LIKE '%Da%'; % implies 0 or more characters
		- '_' will be a useful wildcard as well. It means exactly ONE character.
	- SELECT * FROM books WHERE author_fname LIKE '____'; -- will retrieve all authors with a first name of 4 characters!
		- btw use \ to escape wildcards.

---

### AGGREGATE FUNCTIONS

	- Count basics

---

### REVISING DATA TYPES


CREATE TABLE people (
	name VARCHAR(100),
    birthdate DATE,
    birthtime TIME,
    birthdt DATETIME
);
 
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Elton', '2000-12-25', '11:00:00', '2000-12-25 11:00:00');
 
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Lulu', '1985-04-11', '9:45:10', '1985-04-11 9:45:10');
 
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Juan', '2020-08-15', '23:59:00', '2020-08-15 23:59:00');

SELECT CURTIME();
 
SELECT CURDATE();
 
SELECT NOW();
 
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Hazel', CURDATE(), CURTIME(), NOW());

SELECT 
    birthdate,
    DAY(birthdate),
    DAYOFWEEK(birthdate),
    DAYOFYEAR(birthdate)
FROM people;
 
SELECT 
    birthdate,
    MONTHNAME(birthdate),
    YEAR(birthdate)
FROM people;

SELECT 
    birthtime,
    HOUR(birthtime),
    MINUTE(birthtime)
FROM people;
 
SELECT 
    birthdt,
    MONTH(birthdt),
    DAY(birthdt),
    HOUR(birthdt),
    MINUTE(birthdt)
FROM people;

SELECT birthdate, DATE_FORMAT(birthdate, '%a %b %D') FROM people;
 
SELECT birthdt, DATE_FORMAT(birthdt, '%H:%i') FROM people;
 
SELECT birthdt, DATE_FORMAT(birthdt, 'BORN ON: %r') FROM people;

CREATE TABLE captions (
  text VARCHAR(150),
  created_at TIMESTAMP default CURRENT_TIMESTAMP
);
 
CREATE TABLE captions2 (
  text VARCHAR(150),
  created_at TIMESTAMP default CURRENT_TIMESTAMP,
  updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

---

### COMPARISON AND LOGICAL OPERATORS

#### Not equal:

	SELECT * FROM books WHERE released_year != 2017;


#### Not like:

	SELECT * FROM books WHERE title NOT LIKE '%e%';

#### Greater than:

	SELECT * FROM books WHERE released_year > 2005;
 
	SELECT * FROM books WHERE pages > 500;

#### Less than or equal to:

	SELECT * FROM books
	WHERE pages < 200;
 
	SELECT * FROM books
	WHERE released_year < 2000;
 
	SELECT * FROM books
	WHERE released_year <= 1985;

#### Logical AND:

	SELECT title, author_lname, released_year FROM books
	WHERE released_year > 2010
	AND author_lname = 'Eggers';
 
	SELECT title, author_lname, released_year FROM books
	WHERE released_year > 2010
	AND author_lname = 'Eggers'
	AND title LIKE '%novel%';

#### Logical OR:

	SELECT title, pages FROM books 
	WHERE CHAR_LENGTH(title) > 30
	AND pages > 500;
 
	SELECT title, author_lname FROM books
	WHERE author_lname='Eggers' AND
	released_year > 2010;
 
	SELECT title, author_lname, released_year FROM books
	WHERE author_lname='Eggers' OR
	released_year > 2010;
 
	SELECT title, pages FROM books
	WHERE pages < 200 
	OR title LIKE '%stories%';

#### Between:

	SELECT title, released_year FROM books
	WHERE released_year <= 2015
	AND released_year >= 2004;
 
	SELECT title, released_year FROM books
	WHERE released_year BETWEEN 2004 AND 2014;

#### Comparing Dates:

	SELECT * FROM people WHERE birthtime 
	BETWEEN CAST('12:00:00' AS TIME) 
	AND CAST('16:00:00' AS TIME);
 
 
	SELECT * FROM people WHERE HOUR(birthtime)
	BETWEEN 12 AND 16;

#### The IN operator:

	SELECT title, author_lname FROM books
	WHERE author_lname = 'Carver' 
	OR author_lname = 'Lahiri'
	OR author_lname = 'Smith';
 
	SELECT title, author_lname FROM books
	WHERE author_lname IN ('Carver', 'Lahiri', 'Smith');
 
	SELECT title, author_lname FROM books
	WHERE author_lname NOT IN ('Carver', 'Lahiri', 'Smith');
 
	SELECT title, released_year FROM books
	WHERE released_year >= 2000 
	AND released_year % 2 = 1;

#### Case:

	SELECT title, released_year,
	CASE
		WHEN released_year >= 2000 THEN 'modern lit'
	    ELSE '20th century lit' 
	END AS genre
	FROM books;
 
 
	SELECT 
	    title,
	    stock_quantity,
	    CASE
	        WHEN stock_quantity BETWEEN 0 AND 40 THEN '*'
	        WHEN stock_quantity BETWEEN 41 AND 70 THEN '**'
	        WHEN stock_quantity BETWEEN 71 AND 100 THEN '***'
	        WHEN stock_quantity BETWEEN 101 AND 140 THEN '****'
	        ELSE '*****'
	    END AS stock
	FROM
	    books;
 
 
	SELECT 
	    title,
	    stock_quantity,
 	   CASE
 	       WHEN stock_quantity <= 40 THEN '*'
 	       WHEN stock_quantity <= 70 THEN '**'
 	       WHEN stock_quantity <= 100 THEN '***'
	       WHEN stock_quantity <= 140 THEN '****'
 	       ELSE '*****'
	    END AS stock
	FROM
	    books;
    
---

### CONSTRAINTS and ALTER TABLE

#### UNIQUE:

	CREATE TABLE contacts (
	name VARCHAR(100) NOT NULL,
	phone VARCHAR(15) NOT NULL UNIQUE);
 
	INSERT INTO contacts (name, phone)
	VALUES ('billybob', '8781213455');
 
	-- This insert would result in an error:
	INSERT INTO contacts (name, phone)
	VALUES ('billybob', '8781213455');

#### CHECK: these are extra fancy, to make sure a condition is met otherwise display error

	CREATE TABLE users (
	username VARCHAR(20) NOT NULL,
	age INT CHECK (age > 0));
 
	CREATE TABLE palindromes (
	word VARCHAR(100) CHECK(REVERSE(word) = word))

#### NAMED CONSTRAINTS:

	CREATE TABLE users2 (
	username VARCHAR(20) NOT NULL,
	age INT,
	CONSTRAINT age_not_negative CHECK (age >= 0));
 
	CREATE TABLE palindromes2 (
	word VARCHAR(100),
	CONSTRAINT word_is_palindrome CHECK(REVERSE(word) = word));

#### MULTIPLE COLUMNS CONSTRAINTS:

	CREATE TABLE companies (
	name VARCHAR(255) NOT NULL,
	address VARCHAR(255) NOT NULL,
	CONSTRAINT name_address UNIQUE (name , address));
 
	CREATE TABLE houses (
	purchase_price INT NOT NULL,
	sale_price INT NOT NULL,
	CONSTRAINT sprice_gt_pprice CHECK(sale_price >= purchase_price));

#### ALTER TABLE - adding columns:

	ALTER TABLE companies 
	ADD COLUMN phone VARCHAR(15);
 
	ALTER TABLE companies
	ADD COLUMN employee_count INT NOT NULL DEFAULT 1;

#### ALTER TABLE - dropping columns:

	ALTER TABLE companies DROP COLUMN phone;

#### ALTER TABLE - renaming:

	ALTER TABLE companies RENAME COLUMN name TO company_name;

#### ALTER TABLE - modifying columns:

	ALTER TABLE companies MODIFY company_name VARCHAR(100) DEFAULT 'unknown';

#### ALTER TABLE - constraints:

	ALTER TABLE houses ADD CONSTRAINT positive_pprice CHECK (purchase_price >= 0);

---

### One to Many Joins

#### Primary and Foreign Keys

	CREATE TABLE customers (id INT PRIMARY KEY AUTO_INCREMENT, first_name VARCHAR(50), last_name VARCHAR(50), email VARCHAR(50));
 
	CREATE TABLE orders (id INT PRIMARY KEY AUTO_INCREMENT, order_date DATE, amount DECIMAL(8,2), customer_id INT, FOREIGN KEY (customer_id) REFERENCES customers(id));
 
	INSERT INTO customers (first_name, last_name, email) 
	VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
       
	INSERT INTO orders (order_date, amount, customer_id)
	VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);

#### CROSS JOINS (aka Dumb Join)

	SELECT id FROM customers WHERE last_name = 'George';
	SELECT * FROM orders WHERE customer_id = 1;
 
 
	SELECT * FROM orders 
	WHERE customer_id = (SELECT id FROM customers WHERE last_name = 'George');
 
	-- To perform a (kind of useless) cross join:
	SELECT * FROM customers, orders;

#### INNER JOINS

	-- Our first inner join!
	SELECT * FROM customers
	JOIN orders ON orders.customer_id = customers.id;
 
	SELECT first_name, last_name, order_date, amount FROM customers
	JOIN orders ON orders.customer_id = customers.id;
 
	-- The order doesn't matter here:
	SELECT * FROM orders
	JOIN customers ON customers.id = orders.customer_id;

	-- And we can even use group by too:
	SELECT 
		first_name, last_name, SUM(amount) AS total
	FROM
    		customers
        JOIN
    		orders ON orders.customer_id = customers.id
	GROUP BY first_name , last_name
	ORDER BY total;

#### LEFT JOIN

	SELECT 
    		first_name, last_name, order_date, amount
	FROM
    		customers
        LEFT JOIN
    		orders ON orders.customer_id = customers.id;
 
 
	SELECT 
    		order_date, amount, first_name, last_name
	FROM
    		orders
        LEFT JOIN
    		customers ON orders.customer_id = customers.id

	-- once again group by can be useful:

	SELECT 
    		first_name, last_name, IFNULL(SUM(amount), 0) AS money_spent
	FROM
    		customers
        LEFT JOIN
    		orders ON customers.id = orders.customer_id
	GROUP BY first_name , last_name;

#### RIGHT JOIN

	SELECT 
    		first_name, last_name, order_date, amount
	FROM
    		customers
        RIGHT JOIN
    		orders ON customers.id = orders.customer_id;

#### DELETE CASCADE

	CREATE TABLE customers (
    	id INT PRIMARY KEY AUTO_INCREMENT,
    	first_name VARCHAR(50),
    	last_name VARCHAR(50),
    	email VARCHAR(50)
	);
 
	CREATE TABLE orders (
    	id INT PRIMARY KEY AUTO_INCREMENT,
    	order_date DATE,
    	amount DECIMAL(8 , 2 ),
    	customer_id INT,
    	FOREIGN KEY (customer_id)
        	REFERENCES customers (id)
        	ON DELETE CASCADE
	);

---

### MANY TO MANY

### CREATING THE TABLES

	CREATE TABLE reviewers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);
 
	CREATE TABLE series (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    released_year YEAR,
    genre VARCHAR(100)
);
 
	CREATE TABLE reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    rating DECIMAL(2 , 1 ),
    series_id INT,
    reviewer_id INT,
    FOREIGN KEY (series_id)
        REFERENCES series (id),
    FOREIGN KEY (reviewer_id)
        REFERENCES reviewers (id)
);
 
	INSERT INTO series (title, released_year, genre) VALUES
    ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ("Fargo", 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');
 
 
	INSERT INTO reviewers (first_name, last_name) VALUES
    ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');
    
 
	INSERT INTO reviews(series_id, reviewer_id, rating) VALUES
    (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
    (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
    (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
    (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
    (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
    (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
    (7,2,9.1),(7,5,9.7),
    (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
    (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
    (10,5,9.9),
    (13,3,8.0),(13,4,7.2),
    (14,2,8.5),(14,3,8.9),(14,4,8.9);

- Challenges on ´movies.sql´


