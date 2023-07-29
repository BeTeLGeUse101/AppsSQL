DROP DATABASE IF EXISTS divDB;
CREATE DATABASE divDB;
USE divDB;

DROP PROCEDURE IF EXISTS division;

DELIMITER //
CREATE PROCEDURE division (IN seconds INT)
BEGIN
	DECLARE days, hours, minutes INT;
    SET days = seconds DIV (24 * 3600);
    SET seconds = seconds % (24 * 3600);
    SET hours = seconds DIV 3600;
    SET seconds = seconds % 3600;
    SET minutes = seconds DIV 60;
    SET seconds = seconds % 60;
    SELECT days, hours, minutes, seconds;
END //

CALL division(123456);

DROP PROCEDURE IF EXISTS even;

DELIMITER //
CREATE PROCEDURE even (IN count INT)
BEGIN
	DECLARE i INT DEFAULT 1;
    DECLARE result VARCHAR(100) DEFAULT '';
	WHILE i <= count DO
		IF i % 2 = 0 THEN
            SET result = CONCAT(result, i, ',');
        END IF;
        SET i = i + 1;
    END WHILE;
    SELECT result;
END //

CALL even(10);