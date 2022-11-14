use bank;
SELECT MAX(amount) FROM -- agora sim, com a subquery abaixo, da pra fazer o MAX
(SELECT status, duration, AVG(amount) as amount FROM loan
group by status, duration) as avg_amount; -- se tem groupby não funciona função agregadora tipo max


with avg_amount as (SELECT status, duration, AVG(amount) as amount FROM loan
group by status, duration) SELECT MAX(amount) FROM avg_amount; -- CTE é uma outra forma de escrever isso aqui

SELECT * FROM avg_amount; -- vai falar que não existe. A sub-query só existe na estrutura que ela foi criada.
-- mas da pra criar uma tabela temporaria...



CREATE TEMPORARY TABLE avg_amount as (SELECT status, duration, AVG(amount) as amount FROM loan
group by status, duration);

SELECT MAX(amount) FROM avg_amount;



CREATE VIEW avg_amount_view as (SELECT status, duration, AVG(amount) as amount FROM loan
group by status, duration);

SELECT MAX(amount) FROM avg_amount_view;  