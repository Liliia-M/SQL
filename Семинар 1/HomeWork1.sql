-- 1. Создайте таблицу с мобильными телефонами, используя графический интерфейс. Заполните БД данными
SELECT * FROM home_work_1.mobile_phone;

-- 2. Выведите название, производителя и цену для товаров, количество которых превышает 2
SELECT ProductName, Manufacturer, Price
FROM mobile_phone
WHERE ProductCount > 2;

-- 3. Выведите весь ассортимент товаров марки “Samsung”
SELECT *
FROM mobile_phone
WHERE Manufacturer = "Samsung";

/*
4.*** С помощью регулярных выражений найти:
4.1. Товары, в которых есть упоминание "Iphone"
4.2. "Samsung"
4.3. Товары, в которых есть ЦИФРА "8"
*/

SELECT *
FROM mobile_phone
WHERE ProductName LIKE "IPhone";

SELECT *
FROM mobile_phone
WHERE Manufacturer LIKE "Samsung";

SELECT *
FROM mobile_phone
WHERE ProductName LIKE "%8";