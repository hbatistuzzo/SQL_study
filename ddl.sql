-- CREATE TABLE table (column_name type, ...);

-- data types: BLOB, INTEGER (smallint, integer, bigint), NUMERIC (boolean, date, datetime, scale/precision, time, timestamp), REAL (real, double precision), TEXT

-- INSERT INTO table (column, ...) VALUES (value, ...),(value, ...);

-- UPDATE table SET column = new_value WHERE condition;

-- DELETE FROM table WHERE condition;

-- ver exemplos nos slides.

-- bora criar um novo esquema. Done.

CREATE TABLE example_table (nome VARCHAR(50), nota SMALLINT);

SELECT * from example_table;

/* 
Trying to recreate a table that 
already exists leads to an error.
*/
DROP TABLE IF EXISTS example_table;
CREATE TABLE example_table (
	nome VARCHAR(50), -- poderia adicionar algum tipo de constraint e.g. VARCHAR(50) NOT NULL / ,
	nota SMALLINT,  -- nota SMALLINT CHECK (nota<10) ,
	idade SMALLINT); -- e.g. pra especificar uma chave estrangeira
    
-- Inserting elements into a table.
insert into example_table (nome, nota, idade) VALUES ('Andre', 10, 28);

SELECT * FROM example_table