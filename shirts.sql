CREATE DATABASE spring_cleaning;

USE spring_cleaning;

CREATE TABLE shirts(
shirt_id INT PRIMARY KEY AUTO_INCREMENT,
article VARCHAR(20),
color VARCHAR(20),
shirt_size VARCHAR(1),
last_worn INT
);

DESC shirts;

INSERT INTO shirts (article, color, shirt_size, last_worn)  
VALUES 
	('t-shirt', 'white', 'S', 10),
	('t-shirt', 'green', 'S', 200),
	('polo shirt', 'black', 'M', 10),
	('tank top', 'blue', 'S', 50),
	('t-shirt', 'pink', 'S', 0),
	('polo shirt', 'red', 'M', 5),
	('tank top', 'white', 'S', 200),
	('tank top', 'blue', 'M', 15);
    
   SELECT * FROM shirts;
   
 -- Add a new shirt: purple polo shirt, size M, last worn 50 days ago.
 
INSERT INTO shirts (article, color, shirt_size, last_worn) 
VALUES ('polo shirt', 'purple', 'M', 50);

-- Select all shirts but only print out article and color:
SELECT article, color FROM shirts;

-- Select all medium shirts. Print all
SELECT * FROM shirts WHERE shirt_size = 'M';

-- Update all polo shirts to size L:alter
SELECT * FROM shirts WHERE article = 'polo shirt';

UPDATE shirts SET shirt_size = 'L' WHERE article = 'polo shirt';

SET SQL_SAFE_UPDATES = 0;

SELECT * from shirts;

UPDATE shirts 
SET 
    last_worn = 0
WHERE
    last_worn = 15;
    
UPDATE shirts 
SET 
    color = 'off white',
    shirt_size = 'XS'
WHERE
    color = 'white';

ALTER TABLE shirts MODIFY COLUMN shirt_size VARCHAR(2);

SELECT * from shirts;

SELECT * FROM shirts WHERE last_worn=200;
DELETE FROM shirts WHERE last_worn=200;

SELECT * FROM shirts WHERE article='tank top';
DELETE FROM shirts WHERE article='tank top';

SELECT * from shirts;

DELETE FROM shirts;

DROP TABLE shirts;

show tables;