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

# The Ultimate MySQL Bootcamp: Go from SQL Beginner to Expert

## Core and Installation

<p> Your app --> (R)DBMS --> Database</p>

> The (R)DBMS, (Relational) Database Management System would be PostgreSQL, Oracle, MySQL etc.

<p>We can define a Database as a __structured set of computerizared data with an accessible interface__.</p>


<p>Cool I didnt need to uninstall python to make this work. Great!</p>

## Creating Databases and Tables
