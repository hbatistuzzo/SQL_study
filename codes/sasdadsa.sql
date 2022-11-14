-- one to one: chave primaria leva à chave estrangeira sem repetição. O numero de linhas tem que ser a mesma nas duas.
-- one to many: ok. quando juntar as tabelas vai ter o numero de linhas da chave estrangeira.
-- many to many: ok. numero de linhas randomico. nunca vai ser feito entre 2 tabelas. Precisa de 3, exatamente porque uma chave primaria nao pode repetir.

-- as entradas da chave primária tem que existir ANTES de inserir uma entrada com chave estrangeira. É isso?

-- INNER JOIN = intersecção:
	-- SELECT * FROM table_a INNER JOIN table_b ON table_a.key = table_b.key e.g. alguem que tenha uma conta E tenha feito um emprestimo.

-- LEFT JOIN = just table_a
	-- SELECT * FROM table_a LEFT JOIN table_b ON table_a.key = table_b.key
    
-- OUTER JOIN = both
	-- SLECT * FROM table_a FULL OUTER JOIN table_b ON table_a.key = table_b.key

