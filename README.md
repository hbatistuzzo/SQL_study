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