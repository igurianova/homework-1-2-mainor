-- 1) Написать запрос, который выведет такую таблицу:
--  • id пользователя
--  • имя
--  • лайков получено
--  • лайков поставлено
--  • взаимных лайков
SELECT u.id,
       u.nick,
       (SELECT COUNT(p.author_id)
        FROM publications p
                 INNER JOIN likes l on p.id = l.publication_id
        WHERE p.author_id = u.id) as recive_like,
       (SELECT COUNT(l.user_id)
        FROM likes l
        WHERE l.user_id = u.id)   as put_like
FROM users u
         INNER JOIN publications p on u.id = p.author_id
         INNER JOIN likes l on u.id = l.user_id
group by u.id, u.nick;

-- Запрос на самых популярных пользователей (топ 5)
SELECT u.nick, COUNT(*) as recive_like
FROM publications p
         INNER JOIN likes l on p.id = l.publication_id
         INNER JOIN users u on u.id = p.author_id
GROUP BY u.nick
ORDER BY recive_like DESC
LIMIT 5;

-- 2
-- Поставить лайк на конкретную публикацию
INSERT INTO likes (user_id, publication_id)
VALUES (16, 65);

-- Отозвать лайк пользователя на конкретную публикацию
DELETE
FROM likes l
WHERE l.publication_id = 65
  AND l.user_id = 16;

-- Число лайков для конкретной публикации
SELECT COUNT(*)
FROM publications p
         INNER JOIN likes l on p.id = l.publication_id
WHERE p.id = 29
GROUP BY p.id;
-- Число лайков для каждой публикации
SELECT p.id, COUNT(*)
FROM publications p
         INNER JOIN likes l on p.id = l.publication_id
GROUP BY p.id;

-- Список пользователей поставивших лайки по конкретной публикации
SELECT u.nick
FROM likes l
         INNER JOIN users u on u.id = l.user_id
WHERE l.publication_id = 4;