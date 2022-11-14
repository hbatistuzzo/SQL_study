-- id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. If more than one wand has same power, sort the result in order of descending age.
SELECT id,age,coins_needed,power FROM
(SELECT id, age,first_value(id) OVER (partition by power,age order by coins_needed) correct_id,power,coins_needed FROM wands
JOIN wands_property ON wands.code = wands_property.code
WHERE is_evil =0
ORDER BY power DESC,age DESC) as a
where correct_id = id;

-- SELECT * from wands_property; -- need to join age through code

WITH min_coins AS
(SELECT age,power, MIN(coins_needed) AS coins_needed FROM wands
JOIN wands_property ON wands.code = wands_property.code
WHERE is_evil =0
GROUP BY power,age
ORDER BY power DESC,age DESC)

SELECT wands.id,wands_property.age,wands.power,wands.coins_needed FROM wands
JOIN wands_property ON wands.code = wands_property.code
JOIN min_coins ON min_coins.age = wands_property.age AND
				min_coins.power = wands.power AND
                min_coins.coins_needed = wands.coins_needed;

with min_coins AS
(SELECT
    age, 
    power,
    MIN(coins_needed) AS coins_needed
FROM wands
JOIN wands_property ON wands.code = wands_property.code
WHERE is_evil = 0
GROUP BY power,age
ORDER BY power DESC ,age DESC)

SELECT wands.id,wands_property.age,wands.power,wands.coins_needed FROM wands
JOIN wands_property ON wands.code = wands_property.code
JOIN min_coins ON min_coins.age = wands_property.age AND
				min_coins.power = wands.power AND
                min_coins.coins_needed = wands.coins_needed;

-- THIS ONE
SELECT 
min_price_rankded.id,
min_price_rankded.age,
min_price_rankded.coins_needed,
min_price_rankded.power
FROM(
SELECT
id,age,coins_needed,power,
ROW_NUMBER() OVER(PARTITION BY power,age ORDER BY coins_needed) AS min_price
FROM wands
JOIN wands_property on wands.code = wands_property.code
WHERE is_evil = 0) as min_price_rankded
WHERE min_price = 1
ORDER BY POWER DESC, AGE DESC;
