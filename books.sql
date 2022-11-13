/* CREATE DATABASE book_shop;

CREATE TABLE books 
	(
		book_id INT AUTO_INCREMENT,
		title VARCHAR(100),
		author_fname VARCHAR(100),
		author_lname VARCHAR(100),
		released_year INT,
		stock_quantity INT,
		pages INT,
		PRIMARY KEY(book_id)
	);
 
INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343); */

SELECT * FROM books;

DESC books;

SELECT CONCAT(author_fname, ' ',author_lname) AS full_name FROM books;

SELECT CONCAT_WS('-',author_fname,author_lname) AS full_name FROM books;

INSERT INTO books
    (title, author_fname, author_lname, released_year, stock_quantity, pages)
    VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
           ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
           ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);

SELECT * FROM books;

SELECT author_lname FROM books; -- yields 19 results
SELECT DISTINCT author_lname FROM books; -- only yields 11 results

SELECT author_fname, author_lname FROM books;

-- what about distinct full names?

SELECT DISTINCT CONCAT(author_fname, ' ' ,author_lname) FROM books; -- yields 12 results!

SELECT DISTINCT author_fname, author_lname FROM books; -- also yields 12 results. But no parenthesis.. huh..


SELECT book_id, author_fname, author_lname FROM books ORDER BY author_lname; -- alphabetic by last name. NULL always come first

SELECT title, author_fname, author_lname FROM books WHERE author_fname LIKE '%Da%'; -- gets Dave, Dan or even Freida

SELECT * FROM books WHERE author_fname LIKE '____'; -- will retrieve all authors with a first name of 4 characters! 

SELECT * FROM books WHERE author_fname LIKE '%n'; -- will retrieve all authors with a first name that ends with n! 