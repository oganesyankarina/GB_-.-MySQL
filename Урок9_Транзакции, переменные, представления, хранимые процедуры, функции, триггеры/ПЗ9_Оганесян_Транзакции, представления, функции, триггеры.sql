-- Практическое задание к Уроку 9

-- Практическое задание по теме “Транзакции, переменные, представления”

-- Задание 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. 
-- Используйте транзакции.

START TRANSACTION;
INSERT INTO `sample`.`users`  SELECT * FROM `shop`.`users` WHERE `shop`.`users`.`id`=1; 
DELETE FROM `shop`.`users` WHERE `shop`.`users`.`id`=1 LIMIT 1;
COMMIT;

-- Задание 2. Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.

CREATE VIEW `prod_cat` AS
    SELECT 
        `products`.`name` AS `product_name`,
        (SELECT `catalogs`.`name` FROM `catalogs` WHERE (`catalogs`.`id` = `products`.`catalog_id`)) AS `catalog_name`
    FROM
        `products`
        
-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"

-- Задание 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

CREATE FUNCTION `hello`() RETURNS varchar(45) DETERMINISTIC
BEGIN
	IF CURTIME()<'06:00:))' THEN RETURN 'Доброй ночи';
    END IF ;
    IF CURTIME()<'12:00:))' THEN RETURN 'Доброе утро';
    END IF ;
    IF CURTIME()<'18:00:))' THEN RETURN 'Добрый день';
    END IF ;
    IF CURTIME()<'06:00:))' THEN RETURN 'Добрый вечер'; 
    END IF ;    
END

-- Задание 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие обоих полей или одно из них. 
-- Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.

CREATE TRIGGER `products_BEFORE_INSERT` BEFORE INSERT ON `products` FOR EACH ROW BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Необходимо заполнить хотя бы одно поле из name и description';
		END IF;
END

CREATE TRIGGER `products_BEFORE_UPDATE` BEFORE UPDATE ON `products` FOR EACH ROW BEGIN
	IF NEW.name=''  THEN SET NEW.name = OLD.name;                       
		END IF;
	IF NEW.description='' THEN SET NEW.description = OLD.description;                     
		END IF;         
END
