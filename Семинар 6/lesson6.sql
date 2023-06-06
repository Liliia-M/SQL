DROP DATABASE IF EXISTS  lesson6;
CREATE DATABASE IF NOT EXISTS  lesson6;
USE lesson6;

DELIMITER //
CREATE PROCEDURE proc1()
	BEGIN
		CASE
			WHEN CURTIME() BETWEEN '06:00:00' AND '11:59:59' THEN
				SELECT 'Доброе утро';
			WHEN CURTIME() BETWEEN '12:00:00' AND '17:59:59' THEN
				SELECT 'Добрый день';
			WHEN CURTIME() BETWEEN '18:00:00' AND '23:59:59' THEN
				SELECT 'Добрый вечер';
			ELSE
				SELECT 'Доброй ночи';
		END CASE;
	END //
    DELIMITER ;
    
    CALL proc1();
    
    DELIMITER //
    CREATE FUNCTION fibo(num INT)
    RETURNS VARCHAR(45)
    DETERMINISTIC
    BEGIN
    DECLARE fib1 INT DEFAULT 0; -- fib1 = 0
    DECLARE fib2 INT DEFAULT 1;
    DECLARE fib3 INT DEFAULT 0;
    DECLARE result VARCHAR(45) DEFAULT '0 1';
    
    IF num = 1 THEN
    RETURN fib1;
    ELSEIF num = 2 THEN
    RETURN CONCAT(fib1,' ', fib2);
    ELSE
    WHILE num > 2 
    DO
		SET fib3 = fib1+fib2;
        SET fib1 = fib2;
        SET fib2 = fib3;
        SET num = num-1;
        SET result = CONCAT(result,' ', fib3);
     END WHILE;
     RETURN result;
     END IF;
     END //
     delimiter ;
     
     SELECT fibo(9);
     
     /* Создайте и вызовите процедуру, которая при ее вызове будет выводить:
«Однозначное число» - если ее параметр равен от 1 до 9
«Двухзначное число» - если ее параметр равен от 10 до 99
«Трехзначное число» - если ее параметр равен от 100 до 999

Создайте функцию которая будет вычислять сумму трех переменных
a = 2030, b = 5124, c = 7903. */

DELIMITER //
CREATE PROCEDURE proc2(num INT)
	BEGIN
		CASE
			WHEN num BETWEEN 1 AND 9 THEN
				SELECT 'Однозначное число';
			WHEN num BETWEEN 10 AND 99 THEN
				SELECT 'Двухзначное число';
			WHEN num BETWEEN 100 AND 999 THEN
				SELECT 'Трехзначное число';
			ELSE
				SELECT 'Введите другое число';
		END CASE;
	END //
    DELIMITER ;
    
    CALL proc2(555);
    
    DELIMITER //
    CREATE FUNCTION sum1(a INT, b INT, c INT)
    RETURNS INT
    DETERMINISTIC
    BEGIN
    DECLARE result INT;
    
    SET result = a + b + c;
    
    RETURN result;
    END //
    delimiter ;
     
    SELECT sum1(1, 2, 3);
    
    /*Создайте и вызовите процедуру, которая при ее вызове будет выводить:
«Однозначное число» - если ее параметр равен от 1 до 9
«Двухзначное число» - если ее параметр равен от 10 до 99
«Трехзначное число» - если ее параметр равен от 100 до 999
*/

delimiter //
CREATE PROCEDURE pr2(num INT)
BEGIN
CASE
WHEN num > 0  AND num < 10 THEN
SELECT 'однозначное';
WHEN num > 9  AND num < 99 THEN
SELECT 'двузначное';
ELSE
SELECT 'трехзначное';
END CASE;
END //
delimiter ;

-- Создайте функцию которая будет вычислять сумму трех переменных a = 2030, b = 5124, c = 7903.

DROP FUNCTION pt;
delimiter $$
CREATE FUNCTION pt() 
RETURNS INT
DETERMINISTIC
BEGIN
SET @result = 0;
SET @a = 2030; 
SET @b = 5124; 
SET @c = 7903; 
SET @result = @a+@b+@c;
RETURN @result;
END $$
delimiter ;

SELECT pt();

DROP FUNCTION pt1;
delimiter $$
CREATE FUNCTION pt1(a INT, b INT, c INT) 
RETURNS INT
DETERMINISTIC
BEGIN
SET @result = 0;
SET @result = a+b+c;
RETURN @result;
END $$
delimiter ;

SELECT pt1(2030, 5124, 7903);

-- Транзакции


    


