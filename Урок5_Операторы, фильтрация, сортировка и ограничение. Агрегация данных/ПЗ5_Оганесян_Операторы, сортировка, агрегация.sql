-- Практическое задание по теме "Операторы, фильтрация, сортировка и ограничение"

-- Задание 1
UPDATE profiles SET created_at = NOW();
UPDATE profiles SET updated_at = NOW();
SELECT * FROM profiles;

-- Задание 2
UPDATE profiles2 SET
	updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');
UPDATE profiles2 SET
	created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i');
SELECT * FROM vk.profiles2;

-- Задание 3
SELECT * FROM shop.storehouses_products ORDER BY value = 0, value;

-- Практическое задание по теме "Агрегация данных"

-- Задание 1
SELECT AVG(TIMESTAMPDIFF(YEAR, birthday, NOW())) as 'Средний возраст пользователей' FROM profiles;

-- Задание 2
SELECT 
	DAYNAME( CONCAT(YEAR(NOW()), '-', MONTH(birthday), '-', DAY(birthday))) as 'День недели',
    COUNT(*)
FROM vk.profiles
GROUP BY DAYNAME( CONCAT(YEAR(NOW()), '-', MONTH(birthday), '-', DAY(birthday)));
