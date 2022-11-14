use lab17;

DROP TABLE IF EXISTS cars;
CREATE TABLE cars(car_id SMALLINT, vin VARCHAR(50), manufacturer VARCHAR(50), model VARCHAR(50), car_year SMALLINT, color VARCHAR(50));

DROP TABLE IF EXISTS customers;
CREATE TABLE customers(cust_id SMALLINT, cust_name VARCHAR(50), cust_phone VARCHAR(50), cust_email VARCHAR(50), cust_address VARCHAR(50), cust_zipcode INT);

insert into cars(car_id, vin, manufacturer, model, car_year, color) VALUES (0, '3K096I98581DHSNUP', 'Volkswagen', 'Tiguan', 2019, 'Blue');
insert into cars(car_id, vin, manufacturer, model, car_year, color) VALUES (1, 'ZM8G7BEUQZ97IH46V', 'Peugeot', 'Rifter', 2019, 'Red');
insert into cars(car_id, vin, manufacturer, model, car_year, color) VALUES (2, 'RKXVNNIHLVVZOUB4M', 'Ford', 'Fusion', 2018, 'White');
insert into cars(car_id, vin, manufacturer, model, car_year, color) VALUES (3, 'HKNDGS7CU31E9Z7JW', 'Toyota', 'RAV4', 2018, 'Silver');
insert into cars(car_id, vin, manufacturer, model, car_year, color) VALUES (4, 'DAM41UDN3CHU2WVF6', 'Volvo', 'V60', 2019, 'Gray');
insert into cars(car_id, vin, manufacturer, model, car_year, color) VALUES (5, 'DAM41UDN3CHU2WVF6', 'Volvo', 'V60 Cross Country', 2019, 'Gray');

SELECT * from cars;

insert into customers(cust_id, cust_name, cust_phone, cust_email, cust_address, cust_zipcode) VALUES (10001, 'Pablo Picasso', '+34 636 17 63 82', NULL, 'Paseo de la Chopera 14 Madrid Spain', 28045);
insert into customers(cust_id, cust_name, cust_phone, cust_email, cust_address, cust_zipcode) VALUES (20001, 'Abraham Lincoln', '+1 305 907 7086', NULL, '120 SW 8th St Mimia United States', 33130);
insert into customers(cust_id, cust_name, cust_phone, cust_email, cust_address, cust_zipcode) VALUES (30001, 'Napoléon Bonaparte ', '+33 1 79 75 40 00', NULL, '40 Rue du Colisée Paris France', 75008);

SELECT * from customers;

UPDATE customers SET cust_address = '120 SW 8th St Miami United States' WHERE cust_address = '120 SW 8th St Mimia United States';

SET SQL_SAFE_UPDATES = 0;

UPDATE customers SET cust_email = 'ppicasso@gmail.com' WHERE cust_name = 'Pablo Picasso';
UPDATE customers SET cust_email = 'lincoln@us.gov' WHERE cust_name = 'Abraham Lincoln';
UPDATE customers SET cust_email = 'hello@napoleon.me' WHERE cust_name = 'Napoléon Bonaparte ';

SELECT * from cars;

DELETE FROM cars WHERE car_id = 4;