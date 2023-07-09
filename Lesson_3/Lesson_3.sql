-- Создание БД 
CREATE DATABASE IF NOT EXISTS lesson_3; -- Создали БД lesson_3

USE lesson_3;

DROP TABLE IF EXISTS staff;
CREATE TABLE staff
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(45),
    lastname VARCHAR(45),
    post VARCHAR(45),
    seniority INT, 
    salary DECIMAL(8,2),
    age INT
);

INSERT INTO staff (firstname, lastname, post, seniority, salary, age)
VALUES
 ('Вася', 'Петров', 'Начальник', 40, 100000, 60),
 ('Петр', 'Власов', 'Начальник', 8, 70000, 30),
 ('Катя', 'Катина', 'Инженер', 2, 70000, 25),
 ('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
 ('Иван', 'Петров', 'Рабочий', 40, 30000, 59),
 ('Петр', 'Петров', 'Рабочий', 20, 55000, 60),
 ('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
 ('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
 ('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
 ('Максим', 'Петров', 'Рабочий', 2, 11000, 19),
 ('Юрий', 'Петров', 'Рабочий', 3, 12000, 24),
 ('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);
 
SELECT * FROM staff;

-- 1. Отсортируйте данные по полю заработная плата (salary) в порядке: убывания; возрастания
SELECT salary
FROM staff
ORDER BY salary DESC;

SELECT salary
FROM staff
ORDER BY salary;

-- 2. Выведите 5 максимальных заработных плат (saraly)
SELECT DISTINCT post, salary
FROM staff
ORDER BY salary DESC
LIMIT 5;

-- 3. Посчитайте суммарную зарплату (salary) по каждой специальности (роst)
SELECT post, SUM(salary) AS summ_salary
FROM staff
GROUP BY post;

-- 4. Найдите кол-во сотрудников с специальностью (post) «Рабочий» в возрасте от 24 до 49 лет включительно.
SELECT COUNT(*) AS count_staff, post
FROM staff
WHERE age >= 24 AND age <= 49
GROUP BY post
HAVING post = 'Рабочий';

-- 5. Найдите количество специальностей
SELECT COUNT(DISTINCT post) AS count_post
FROM staff;

-- 6. Выведите специальности, у которых средний возраст сотрудников меньше 30 лет
SELECT post, AVG(age) AS sum_age
FROM staff
GROUP BY post
HAVING sum_age <= 30;

-- * Внутри каждой должности вывести ТОП-2 по ЗП (2 самых высокооплачиваемых сотрудника по ЗП внутри каждой должности)
SELECT firstname, post, salary
FROM staff AS s1
WHERE (
  SELECT COUNT(*) 
  FROM staff AS s2
  WHERE s2.post = s1.post AND s2.salary >= s1.salary
) <= 2
ORDER BY post, salary DESC;