DROP DATABASE IF EXISTS dbstations;

CREATE DATABASE dbstations;

USE dbstations;

DROP TABLE IF EXISTS stations;

CREATE TABLE stations
(
	train_id INT NOT NULL,
    station VARCHAR(45) NOT NULL,
    station_time TIME NOT NULL
);

INSERT INTO stations(train_id, station, station_time) VALUES
	('110', 'San Francisco', '10:00:00'),
    ('110', 'Redwood City', '10:54:00'),
    ('110', 'Palo Alto', '11:02:00'),
    ('110', 'San Jose', '12:35:00'),
    ('120', 'San Francisco', '11:00:00'),
    ('120', 'Palo Alto', '12:49:00'),
    ('120', 'San Jose', '13:30:00');

SELECT * FROM stations;

-- Добавляем новый столбец и заносим в него разницу по времени станций
CREATE OR REPLACE VIEW stations_time_next AS
	SELECT *,
	TIMEDIFF(LEAD(station_time) OVER w, station_time) AS `time_to_next`
	FROM stations
	WINDOW w AS (PARTITION BY train_id);

SELECT * FROM stations_time_next;