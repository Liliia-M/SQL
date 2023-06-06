DROP DATABASE IF EXISTS home_work_6;
CREATE DATABASE IF NOT EXISTS home_work_6;
USE home_work_6;

-- 1. Создайте процедуру, которая принимает кол-во сек и формат их в кол-во дней часов. Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds'

-- Первый вариант, работает если 99 часов и меньше, потому что не знаю как учесть срез от 1 до -4 и выбираю просто первые два символа из строки при переводе секунд в строковый формат (часы минуты секунды). Можно наверное сделать это условием, которое бы учитывало количество символов в получившейся строке.

DELIMITER //
CREATE PROCEDURE proc_sec(sec INT)
	BEGIN
	    SELECT (CONCAT((SUBSTRING((sec_to_time(sec)+0),1,2)) DIV 24,' ', 'days',
		' ', (SUBSTRING((sec_to_time(sec)+0),1,2))%24,' ', 'hours',
		' ', SUBSTRING((sec_to_time(sec)+0),-4,2),' ', 'minutes',
		' ', SUBSTRING((sec_to_time(sec)+0),-2),' ', 'seconds')) AS 'Формат';
	END //
	DELIMITER ;
    
	CALL proc_sec(123456);
    
-- Второй вариант

DELIMITER //
CREATE PROCEDURE proc_sec_(num INT)
BEGIN
	CASE
		WHEN num < 60 THEN
			SELECT CONCAT(num, ' ', 'seconds') AS 'Формат';
        WHEN num >= 60 AND num < 3600 THEN
			SELECT CONCAT_WS(' ', num DIV 60, 'minutes', MOD(num, 60), 'seconds') AS 'Формат';
        WHEN num >= 3600 AND num < 86400 THEN
			SELECT CONCAT_WS(' ', num DIV 3600, 'hours', MOD(num, 3600) DIV 60, 'minutes', MOD(MOD(num, 3600),60), 'seconds') AS 'Формат';
        ELSE
			SELECT CONCAT_WS(' ', num DIV 86400, 'days', MOD(num, 86400) DIV 3600, 'hours', MOD(MOD(num, 86400),3600) DIV 60, 'minutes',
                             MOD(MOD(MOD(num, 86400),3600),60), 'seconds') AS 'Формат';
    END CASE;
END//

DELIMITER ;
CALL proc_sec_(123456);
    
        
-- 2. Создайте функцию, которая выводит только четные числа от 1 до 10. Пример: 2,4,6,8,10 
	DROP FUNCTION IF EXISTS even;
    DELIMITER //
    CREATE FUNCTION even(num INT)
    RETURNS VARCHAR(45)
    DETERMINISTIC
    BEGIN
    DECLARE i INT DEFAULT 1; 
    DECLARE result VARCHAR(45) DEFAULT '0 1';
    
    WHILE i < num 
    DO
		IF i % 2 = 0 THEN
			SET result = CONCAT(result,' ', i);
            END IF;
		    SET i = i + 2;         
     END WHILE;
     RETURN result;
     END //
     delimiter ;
     
     SELECT even(10);
     
