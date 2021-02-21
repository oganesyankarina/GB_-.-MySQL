-- Урок 6 Практическое задание по теме "Операторы, фильтрация, сортировка и ограничение"

-- Задание 2 ####################################################################
SELECT
	from_users_id, 
    COUNT(*)
FROM messages
WHERE 
	to_users_id=40 
    AND from_users_id IN (SELECT IF(from_users_id =40, to_users_id, from_users_id) FROM friend_requests
							WHERE (from_users_id=40 OR to_users_id=40) AND `status`=1)
GROUP BY from_users_id
ORDER BY COUNT(*) DESC;

-- Задание 3 ####################################################################
SELECT 
	users_id,
    TIMESTAMPDIFF(YEAR, birthday, NOW()) AS age,
    (SELECT COUNT(*) FROM vk.likes WHERE (SELECT users_id FROM media WHERE likes.media_id=media.id AND profiles.users_id=media.users_id)) AS c_likes
FROM profiles
ORDER BY TIMESTAMPDIFF(YEAR, birthday, NOW())
LIMIT 10;
-- Итоговую сумма лайков так и не смогла посчитать(((

-- Задание 4 ####################################################################
SELECT 
(SELECT gender FROM profiles WHERE likes.users_id=profiles.users_id) as `gender`,
COUNT(*) as `count likes`
FROM likes
GROUP BY (SELECT gender FROM profiles WHERE likes.users_id=profiles.users_id);

-- Задание 5 ####################################################################
SELECT 
	id,
    (SELECT COUNT(*) FROM messages WHERE from_users_id=users.id) +
    (SELECT COUNT(*) FROM friend_requests WHERE from_users_id=users.id) +
    (SELECT COUNT(*) FROM likes WHERE users_id=users.id) +
    (SELECT COUNT(*) FROM media WHERE users_id=users.id) +
    (SELECT COUNT(*) FROM posts WHERE users_id=users.id) AS count_active    
FROM users
ORDER BY count_active
LIMIT 10;


