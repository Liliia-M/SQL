DROP DATABASE IF EXISTS home_work_2;
CREATE DATABASE IF NOT EXISTS home_work_2;
USE home_work_2;

-- 1. Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными
DROP TABLE IF EXISTS sales;
CREATE TABLE IF NOT EXISTS sales
(Id INT PRIMARY KEY AUTO_INCREMENT,
Product VARCHAR(45) NOT NULL UNIQUE,
Manufacturer VARCHAR(45) NOT NULL,
Quantity INT,
UnitPrice INT,
Total INT
);

INSERT INTO sales (Product, Manufacturer, Quantity, UnitPrice, Total)
VALUES
	("Soap", "Henkel", 90, 35, 3150),
    ("Shampoo", "Loreal", 400, 15, 6000),
    ("Toothpaste", "Colgate", 500, 20, 10000),
    ("Toothbrush", "Rocs", 250, 25, 6250);

SELECT * FROM sales;

-- 2. Сгруппируйте значений количества в 3 сегмента — меньше 100, 100-300 и больше 300 (функция IF)
SELECT 
Id AS "Номер п/п", Product AS "Наименование товара",
IF (Quantity < 100, "Мало",
IF (Quantity > 300, "Много", "Достаточно"))
AS "Количество товара"
FROM sales;

-- 3. Создайте таблицу “orders”, заполните ее значениями. Покажите “полный” статус заказа, используя оператор CASE
DROP TABLE IF EXISTS orders;
CREATE TABLE IF NOT EXISTS orders
(Id INT PRIMARY KEY AUTO_INCREMENT,
Item VARCHAR(45) NOT NULL UNIQUE,
Quantity INT,
Done BOOL,
Price INT
);

INSERT INTO orders (Item, Quantity, Done, Price)
VALUES
	("Soup", 2, 1, 550),
    ("Fries", 4, 0, 100),
    ("Cutlet", 2, 1, 250),
    ("Juice", 6, 0, 270);
    
SELECT * FROM orders;

SELECT Item, Quantity,
CASE
WHEN Done = True THEN "Заказ готов"
ELSE "Заказ готовится"
END AS "Status"
FROM orders;

-- 4. Чем NULL отличается от 0?
-- NULL означает отсутствие данных в ячейке, а 0 это значение, говорит о наличии данных.