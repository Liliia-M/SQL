CREATE DATABASE working;
#CREATE SCHEMA working
-- это комментарий

/*
Это 
многострочный
комментарий
*/

USE working;

CREATE TABLE worker
(id INT PRIMARY KEY NOT NULL,
name_worker VARCHAR(30) NOT NULL,
dept VARCHAR(30) NOT NULL,
salary VARCHAR(30)
);

INSERT worker(id, name_worker, dept, salary)
VALUES
(100, "AndreyEX", "Sales", "5000"),
(200, "Boris", "IT", "5500"),
(300, "Anna", "IT", "7000"),
(400, "Anton", "Marketing", "9500"),
(500, "Dima", "IT", "6000"),
(501, "Maxs", "Accounting", "");

SELECT * 
FROM worker;

SELECT *
FROM worker
WHERE salary > 6000;

SELECT * 
FROM worker
WHERE dept LIKE "IT";

SELECT * 
FROM worker
WHERE NOT dept LIKE "IT";

SELECT * 
FROM worker
WHERE dept NOT LIKE "IT";

SELECT * 
FROM worker
WHERE dept !="IT";
