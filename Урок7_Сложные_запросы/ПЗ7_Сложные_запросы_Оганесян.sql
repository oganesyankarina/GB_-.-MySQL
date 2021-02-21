-- Практическое задание к Уроку 7 Тема “Сложные запросы”

-- Задание 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT * FROM users
WHERE EXISTS ( SELECT * FROM orders WHERE user_id = users.id);

-- Задание 2. Выведите список товаров products и разделов catalogs, который соответствует товару.

-- Вариант через вложенный запрос
SELECT 
	name AS product,
    (SELECT name FROM catalogs WHERE products.catalog_id=catalogs.id) AS catalog
FROM products;
-- Вариант через JOIN
SELECT p.name, c.name
FROM 
	products as p JOIN catalogs as c
ON p.catalog_id=c.id;

-- Задание 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.
SELECT 
(SELECT `name` FROM cities WHERE cities.label=flights.from) AS `from`,
(SELECT `name` FROM cities WHERE cities.label=flights.to) AS `to`
FROM flights;