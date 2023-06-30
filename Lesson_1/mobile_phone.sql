# 1. Создание таблицы с мобильными телефонами

-- Создание БД
CREATE DATABASE IF NOT EXISTS catalogDB;

-- Подключение к базе данных
USE catalogDB;

-- Создание таблицы с мобильными телефонами
DROP TABLE IF EXISTS mobile_phone;
CREATE TABLE mobile_phone
(
	Id INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(45) UNIQUE NOT NULL,
    Manufacturer VARCHAR(45) NOT NULL,
    ProductCount INT NOT NULL,
    Price INT NOT NULL
);

-- Заполнение таблицы телефонами
INSERT mobile_phone(ProductName, Manufacturer, ProductCount, Price)
VALUE
	("iPhone X", "Apple", "3", "76000"),
    ("iPhone 8", "Apple", "2", "51000"),
    ("Galaxy S9", "Samsung", "2", "56000"),
    ("Galaxy S8", "Samsung", "1", "41000"),
    ("P20 Pro", "Huawei", "5", "36000");
    
-- Вывод данных таблицы
SELECT *
FROM mobile_phone;

# 2. Выведите название, производителя и цену для товаров, количество которых превышает 2
SELECT ProductName, Manufacturer, Price
FROM mobile_phone
WHERE ProductCount > 2;

# 3. Выведите весь ассортимент товаров марки “Samsung”
SELECT *
FROM mobile_phone
WHERE Manufacturer = "Samsung";

# ** 4. Выведите информацию о телефонах, где суммарный чек больше 100 000 и меньше 145 000
SELECT *
FROM mobile_phone
WHERE (Price * ProductCount) > "100000" and (Price * ProductCount) < "145000";

# *** 5. С помощью регулярных выражений найти (можно использовать операторы “LIKE”, “RLIKE”):
# 5.1. Товары, в которых есть упоминание "Iphone"
SELECT *
FROM mobile_phone
WHERE ProductName LIKE "%iphone%";

# 5.2. "Galaxy"
SELECT *
FROM mobile_phone
WHERE ProductName RLIKE "galaxy";

# 5.3.  Товары, в которых есть ЦИФРЫ
SELECT *
FROM mobile_phone
WHERE ProductName RLIKE "[0-9]";

# 5.4.  Товары, в которых есть ЦИФРА "8"
SELECT *
FROM mobile_phone
WHERE ProductName RLIKE "[8]";