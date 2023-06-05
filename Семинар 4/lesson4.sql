DROP DATABASE IF EXISTS lesson4;
CREATE DATABASE IF NOT EXISTS lesson4;
USE lesson4;

DROP TABLE IF EXISTS teacher;
CREATE TABLE IF NOT EXISTS teacher
(	
	id INT NOT NULL PRIMARY KEY,
    surname VARCHAR(45),
    salary INT
);

INSERT teacher
VALUES
	(1,"Авдеев", 17000),
    (2,"Гущенко",27000),
    (3,"Пчелкин",32000),
    (4,"Питошин",15000),
    (5,"Вебов",45000),
    (6,"Шарпов",30000),
    (7,"Шарпов",40000),
    (8,"Питошин",30000);
    
SELECT * from teacher; 

DROP TABLE IF EXISTS lesson;
CREATE TABLE IF NOT EXISTS lesson
(	
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    course VARCHAR(45),
    teacher_id INT,
    FOREIGN KEY (teacher_id)  REFERENCES teacher(id)
);
INSERT INTO lesson(course,teacher_id)
VALUES
	("Знакомство с веб-технологиями",1),
    ("Знакомство с веб-технологиями",2),
    ("Знакомство с языками программирования",3),
    ("Базы данных и SQL",4);
    
-- Получить фамилии и курсы, которые ведут преподаватели    
SELECT teacher.surname, lesson.course
FROM teacher 
JOIN lesson -- INNER JOIN = JOIN одно и то же
ON teacher.id = lesson.teacher_id;

SELECT *
FROM teacher, lesson
WHERE teacher.id = lesson.teacher_id;

-- Получить фамилии преподавателей, которые не ведут никакие курсы
SELECT t.surname, l.course
FROM teacher AS t
LEFT JOIN lesson AS l
ON t.id = l.teacher_id
WHERE l.course IS NULL;

SELECT t.surname, l.course
FROM lesson AS l
RIGHT JOIN teacher AS t
ON t.id = l.teacher_id
WHERE l.course IS NULL;

-- Вывести фамилии и курсы всех преподавателей
SELECT t.surname, l.course
FROM lesson AS l
RIGHT JOIN teacher AS t
ON t.id = l.teacher_id;

SELECT *
FROM teacher
WHERE EXISTS (SELECT * FROM lesson -- EXISTS работает дольше чем JOIN и просто WHERE, JOIN работает быстрее всех из трех способов
WHERE teacher.id = lesson.teacher_id);

-- CROSS JOIN - декартово произведение строк из соединенных таблиц, все со всеми
SELECT t.*, l.*
FROM teacher t
CROSS JOIN lesson l;

SELECT t.*, l.*,
(SELECT COUNT(*)
FROM teacher t
CROSS JOIN lesson l) t2
FROM teacher t
CROSS JOIN lesson l;

/*
Получить информацию по учителям, которые ведут курс 
"Знакомство с веб-технологиями"
5.1. 	С помощью фильтра “WHERE”
5.2. 	С помощью подзапроса (выборка с помощью с SELECT-a)
*/
SELECT t.*, l.course
FROM teacher AS t
LEFT JOIN lesson AS l
ON t.id = l.teacher_id
WHERE l.course = "Знакомство с веб-технологиями";

SELECT t.* ,web_lesson.*
FROM teacher t
JOIN (SELECT course, teacher_id
FROM lesson WHERE course = "Знакомство с веб-технологиями") AS web_lesson
ON t.id = web_lesson.teacher_id;


SELECT *
FROM teacher
UNION
SELECT *
FROM lesson; -- запрос не правильный - должно быть соответствие столбцов - одинаковое количество столбцов и одинаковые названия

SELECT id
FROM teacher
UNION
SELECT teacher_id
FROM lesson;

SELECT id
FROM teacher
UNION ALL
SELECT teacher_id
FROM lesson;

/*
1. Получить список логинов пользователей и клиентов, удалив одинаковых клиентов и пользователей
2.	Получить список логинов пользователей и клиентов. Дубликаты удалять не нужно
3. Получить список логинов, которые являются и пользователями, и клиентами
4. Вывести информацию о пользователях и клиентах мужского пола.
5. Вывести декартово произведение всех значений двух таблиц.
6. Получить все строчки левой и правой таблицы.
*/

DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users
(
    id  int auto_increment primary key,
    login varchar(255) null,
    pass  varchar(255) null,
    male  tinyint      null
);

DROP TABLE IF EXISTS clients;
CREATE TABLE IF NOT EXISTS clients
(
    id    int auto_increment primary key,
    login varchar(255) null,
    pass  varchar(255) null,
    male  tinyint      null
);

INSERT INTO users (login, pass, male) 
VALUES 
('alex', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1),
('Mikle', '$ws$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1),
 ('Olia', '$2y$10$88zbBCKLJklStIgTqBKIluijJUnbeZ5WqJI4RJgkksnFZon5kH14y', 2),
 ('Tom', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH20y', 1),
('Margaret', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ4wqIu4RJgkksnFZon5kH20y', 2);

INSERT INTO clients (login, pass, male)
VALUES
('alexander', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1),
 ('Mikle', '$ws$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1),
('Olia', '$2y$10$88zbBCKLJklStIgTqBKIluijJUnbeZ5WqJI4RJgkksnFZon5kH14y', 2),
('Dmitry', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH20y', 1),
 ('Margaret', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ4wqIu4RJgkksnFZon5kH20y', 2),
('Leonid', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1),
 ('Olga', '$2y$10$88zbBCKLJklStIgTqBKIluijJUnbeZ5WqJI4RJgkksnFZon5kH14y', 2),
 ('Tom', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH20y', 1),
('Masha', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ4wqIu4RJgkksnFZon5kH20y', 2),
 ('alex', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);
 
 -- 1. Получить список логинов пользователей и клиентов, удалив одинаковых клиентов и пользователей
SELECT login
FROM users
UNION
SELECT login
FROM clients;

-- 2.	Получить список логинов пользователей и клиентов. Дубликаты удалять не нужно
SELECT login
FROM users
UNION ALL
SELECT login
FROM clients;

-- 3. Получить список логинов, которые являются и пользователями, и клиентами
SELECT DISTINCT u.login
FROM users AS u
LEFT JOIN clients AS c
ON u.login = c.login;

-- 4. Вывести информацию о пользователях и клиентах мужского пола.
SELECT *
FROM users
WHERE male = 1
UNION
SELECT *
FROM clients
WHERE male = 1;

-- 5. Вывести декартово произведение всех значений двух таблиц.
SELECT u.login, c.login, u.id, c.id
FROM users u
CROSS JOIN clients c;

-- 6. Получить все строчки левой и правой таблицы.
SELECT u.login, u.pass, c.login, c.pass FROM users u
LEFT JOIN clients c ON u.login=c.login
UNION ALL
SELECT u.login, u.pass, c.login, c.pass FROM users u
RIGHT JOIN clients c ON u.login=c.login;

