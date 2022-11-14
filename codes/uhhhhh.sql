-- Setting the working database
use bank;

-- Selecting all the data from table trans
select * from trans;

-- Selecting all the data from table trans of database bank
select * from bank.trans; -- melhor assim convenhamos

-- To select some columns instead of all
select trans_id, account_id, date, type from bank.trans; -- mas a convenção costuma ser tudo maiúsculo pra comandos

-- Esse tipo de seleção abaixo pode ser util quando utilizando mais de uma tabela:
SELECT 
    bank.trans.trans_id,
    bank.trans.account_id,
    bank.trans.date,
    bank.trans.type
FROM
    bank.trans
LIMIT 2; -- this can be used for limiting the rows

-- Check the number of records in a table
select count(*) from bank.trans;

-- Get the unique values of
SELECT DISTINCT status FROM bank.loan; -- Status, in this case, is a column! I'll rewrite with caps lock format. This is better. This is the unique of python

SELECT trans_id AS Transaction_ID, account_id AS Account_ID, date AS Date, type AS Type_of_account -- alias can be helpful sometimes. Aspas funcionam pra conter caract especiais
from bank.trans;

-- Activity 3
select 'Hello World';

select 2 + 3;

SELECT DISTINCT type FROM card;

select DISTINCT A2 from bank.district limit 30;







