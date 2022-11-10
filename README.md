# Tips
3) Wildcards are extremely useful
	- SELECT * from movie_tables WHERE title = "story" will find a movie whose title is EXACTLY story
	- SELECT * from movie_tables WHERE title LIKE "story" will find a movie whose title is either story or Story or STORY etc
		- Use % with LIKE to match a sequence of 0 or more characters
			- SELECT * from movie_tables WHERE title LIKE "%story" will find Toy Story
			- SELECT * from movie_tables WHERE title LIKE "%story%" will find Toy Story, Toy Story 2 and Toy Story 3
		- Use _ in a similar fashion, but to match exactly 1 character
			- SELECT * FROM movies WHERE Title LIKE "WALL-_" will find WALL-E and WALL-G, but would not find WALL-EEE if it existed.


---------

## The Ultimate MySQL Bootcamp: Go from SQL Beginner to Expert

### Core and Installation

<p> Your app --> (R)DBMS --> Database</p>

> The (R)DBMS, (Relational) Database Management System would be PostgreSQL, Oracle, MySQL etc.

<p>We can define a Database as a ___structured set of computerized data with an accessible interface___.</p>


<p>Cool I didnt need to uninstall python to make this work. Great!</p>

### Manipulating Databases

To list available databases: ___show databases___;

To create: ___CREATE DATABASE <name>;___
To delete: ___DROP DATABASE <name>;___ * CAREFUL WITH THIS, it will delete everything * <br>
To use: ___USE <name>;___ | ___SELECT database();___ should confirm that its working. <br>

### Tables

Tables hold the data:
> A collection of related data held in a structured format within a database.

### Data Types

There is a whole bunch of Numeric Types, String Types and Date Types. Some need caution:
- INT: range from -2,147,483,647 to 2,147,483,647
- VARCHAT: a variable-length string e.g. 'coffee' or '-9999' or 'aASDJH daksjhdasj'. We can specify a maximum of chars e.g. varchar(100) to limit size.

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

