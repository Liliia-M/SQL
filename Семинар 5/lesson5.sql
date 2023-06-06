DROP DATABASE IF EXISTS lesson_5;
CREATE DATABASE lesson_5;
USE lesson_5;

-- Персонал
DROP TABLE IF EXISTS staff;
CREATE TABLE staff (
id INT AUTO_INCREMENT PRIMARY KEY,
firstname VARCHAR(45),
lastname VARCHAR(45),
post VARCHAR(100),
seniority INT,
salary INT,
age INT
);

-- Наполнение данными
INSERT INTO staff (firstname, lastname, post, seniority, salary, age)
VALUES
('Вася', 'Петров', 'Начальник', '40', 100000, 60),
('Петр', 'Власов', 'Начальник', '8', 70000, 30),
('Катя', 'Катина', 'Инженер', '2', 70000, 25),
('Саша', 'Сасин', 'Инженер', '12', 50000, 35),
('Ольга', 'Васютина', 'Инженер', '2', 70000, 25),
('Петр', 'Некрасов', 'Уборщик', '36', 16000, 59),
('Саша', 'Петров', 'Инженер', '12', 50000, 49),
('Иван', 'Сидоров', 'Рабочий', '40', 50000, 59),
('Петр', 'Петров', 'Рабочий', '20', 25000, 40),
('Сидр', 'Сидоров', 'Рабочий', '10', 20000, 35),
('Антон', 'Антонов', 'Рабочий', '8', 19000, 28),
('Юрий', 'Юрков', 'Рабочий', '5', 15000, 25),
('Максим', 'Максимов', 'Рабочий', '2', 11000, 22),
('Юрий', 'Галкин', 'Рабочий', '3', 12000, 24),
('Людмила', 'Маркина', 'Уборщик', '10', 10000, 49),
('Юрий', 'Онегин', 'Начальник', '8', 100000, 39);

-- Ранжирование : DENSE_RANK RANK ROW_NUMBER NTILE
-- Выведем всех сотрудников и укажем место в рейтинге по зарплатам 

SELECT
DENSE_RANK() OVER(ORDER BY salary DESC) AS `dense_rank`,
RANK() OVER(ORDER BY salary DESC) AS `rank`,
ROW_NUMBER() OVER(ORDER BY salary DESC) AS `number`,
NTILE(4) OVER(ORDER BY salary DESC) AS `groups`,
post,
salary
FROM staff;

SELECT *
FROM staff;

-- Выведем список всех сотрудников и укажем их место по зарплатам, внутри каждой должности
SELECT 
DENSE_RANK() OVER(PARTITION BY post ORDER BY salary DESC) AS `dense_rank`,
CONCAT(firstname, ' ',lastname) AS `fullname`,
post, salary
FROM staff;

-- Выведем список всех сотрудников и укажем их место по зарплатам, внутри каждой должности
SELECT 
DENSE_RANK() OVER(PARTITION BY post ORDER BY salary DESC) AS `dense_rank`,
CONCAT(firstname, ' ',lastname) AS `fullname`,
post, salary
FROM staff;

SELECT post, salary,
`fullname`,
`dense_rank`
FROM
(SELECT 
DENSE_RANK() OVER(PARTITION BY post ORDER BY salary DESC) AS `dense_rank`,
CONCAT(firstname, ' ',lastname) AS `fullname`,
post, salary
FROM staff) AS `rank_list`
WHERE `dense_rank` = 1
ORDER BY salary DESC;

-- Агрегатные функции SUM AVG COUNT
/*
Выведем всех сотрудников, отсортировав их по зарплатам в рамках каждой должности и рассчитаем:ALTER
Общую сумму зарплат каждой должности
Процентное соотношение каждой зарплаты к общей сумме по должности
Среднее зарплату по каждой должности
Процентное соотношение каждой зарплаты к средней зарплате по должности
*/

SELECT
id,
CONCAT(firstname, ' ',lastname) AS `fullname`,
post,
salary,
SUM(salary) OVER w AS `sum_salary`,
ROUND(salary*100/SUM(salary) OVER w) AS `percent_sum`,
AVG(salary) OVER w AS `avg_salary`,
ROUND(salary*100/AVG(salary) OVER w, 3) AS `percent_avg`
FROM staff
WINDOW w AS (PARTITION BY post);

-- Получить с помощью оконных функции:
-- 1. Средний балл ученика
-- 2. Наименьшую оценку ученика
-- 3. Наибольшую оценку ученика
-- 4. Выведите всех

DROP TABLE IF EXISTS academic_record;
CREATE TABLE IF NOT EXISTS academic_record (	student_name varchar(45),
	quartal  varchar(45),
    course varchar(45),
	grade int
);

INSERT INTO academic_record
VALUES	('Александр','1 четверть', 'математика', 4),
	('Александр','2 четверть', 'русский', 4),
	('Александр', '3 четверть','физика', 5),
	('Александр', '4 четверть','история', 4),
	('Антон', '1 четверть','математика', 4),
	('Антон', '2 четверть','русский', 3),
	('Антон', '3 четверть','физика', 5),
	('Антон', '4 четверть','история', 3),
    ('Петя', '1 четверть', 'физика', 4),
	('Петя', '2 четверть', 'физика', 3),
	('Петя', '3 четверть', 'физика', 4),
	('Петя', '4 четверть', 'физика', 5);
    
SELECT DISTINCT student_name,
AVG(grade) OVER(PARTITION BY student_name) AS 'Средний балл',
MIN(grade) OVER(PARTITION BY student_name) AS 'Min',
MAX(grade) OVER(PARTITION BY student_name) AS 'MAX'
FROM academic_record;

SELECT  DISTINCT -- второй вариант
student_name,
AVG(grade) OVER w AS `Средний балл`,
MIN(grade) OVER w AS `Наименьший балл`,
MAX(grade) OVER w AS `Наибольший балл`
FROM academic_record
WINDOW w AS (PARTITION BY student_name);

-- Смещающие функции LAG LEAD FIRST_VALUE LAST_VALUE
SELECT
post,
salary,
id,
LAG(id) OVER w AS `lag`,
LEAD(id) OVER w AS `lead`,
FIRST_VALUE(id) OVER w AS `first_value`,
LAST_VALUE(id) OVER w AS `last_value`
FROM staff
WINDOW w AS (PARTITION BY post);

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
    
CREATE OR REPLACE VIEW teacher_web AS
SELECT t.surname ,web_lesson.*
FROM teacher t
JOIN (SELECT course, teacher_id
FROM lesson WHERE course = "Знакомство с веб-технологиями") AS web_lesson
ON t.id = web_lesson.teacher_id;

SELECT *
FROM teacher_web;


ALTER VIEW teacher_web AS
SELECT t.surname ,web_lesson.*, t.salary
FROM teacher t
JOIN (SELECT course, teacher_id
FROM lesson WHERE course = "Знакомство с веб-технологиями") AS web_lesson
ON t.id = web_lesson.teacher_id;



DROP TABLE IF EXISTS summer_medals;
CREATE TABLE IF NOT EXISTS summer_medals 
(
	year INT,
    city VARCHAR(45),
    sport VARCHAR(45),
    discipline VARCHAR(45),
    athlete VARCHAR(45),
    country VARCHAR(45),
    gender VARCHAR(45),
    event VARCHAR(45),
    medal VARCHAR(45)
);

SELECT *
FROM summer_medals;
INSERT summer_medals
VALUES
	(1896, "Athens", "Aquatics", "Swimming", "HAJOS ALfred", "HUN", "Men","100M Freestyle", "Gold"),
	(1896, "Athens", "Archery", "Swimming", "HERSCHMANN Otto", "AUT", "Men","100M Freestyle", "Silver"),
    (1896, "Athens", "Athletics", "Swimming", "DRIVAC Dimitros", "GRE", "Men","100M Freestyle For Saliors", "Bronze"),
    (1900, "Athens", "Badminton", "Swimming", "MALOKINIS Ioannis", "GRE", "Men","100M Freestyle For Saliors", "Gold"),
    (1896, "Athens", "Aquatics", "Swimming", "CHASAPIS Spiridon", "GRE", "Men","100M Freestyle For Saliors", "Silver"),
    (1896, "Athens", "Aquatics", "Swimming", "CHOROPHAS Elfstathios", "GRE", "Men","1200M Freestele", "Bronze"),
    (1905, "Athens", "Aquatics", "Swimming", "HAJOS ALfred", "HUN", "Men","100M Freestyle For Saliors", "Gold"),
    (1896, "Athens", "Aquatics", "Swimming", "ANDREOU Joannis", "GRE", "Men","1200M Freestyle", "Silver"),
    (1896, "Athens", "Aquatics", "Swimming", "CHOROPHAS Elfstathios", "GRE", "Men","400M Freestyle", "Bronze");

-- 1.	Выберите имеющиеся виды спорта и пронумеруем их в алфавитном порядке
-- 2.	Создайте представление, в которое попадает информация о спортсменах (страна, пол, имя)
-- 3.   Создайте представление, в котором будет храниться информация о спортсменах по конкретному виду спорта (Aquatics)

SELECT DISTINCT `sport`
FROM summer_medals ORDER BY sport ASC;

SELECT
sport,
ROW_NUMBER() OVER(ORDER BY sport ASC) AS Row_N
FROM (
SELECT DISTINCT sport
FROM Summer_Medals
) AS sports
ORDER BY sport ASC;


CREATE OR REPLACE VIEW web_athlete AS
SELECT s.athlete, s.country, s.gender
FROM summer_medals s;



CREATE OR REPLACE VIEW web_athlete2 AS
SELECT s.athlete, s.country, s.gender, s.sport
FROM summer_medals s
WHERE  sport = "Aquatics";

SELECT
id,
CONCAT(firstname, ' ',lastname) AS `fullname`,
post,
salary,
SUM(salary) OVER (PARTITION BY post ORDER BY salary ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS `sum_salary`
FROM staff;

SELECT
id,
CONCAT(firstname, ' ',lastname) AS `fullname`,
post,
salary,
SUM(salary) OVER (PARTITION BY post ORDER BY salary RANGE BETWEEN CURRENT ROW AND 1 FOLLOWING) AS `sum_salary`
FROM staff;
