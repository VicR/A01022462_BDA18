--Víctor Rendón S. | A01022462 | Evaluación 1: Parte 2

CREATE TABLE gummies(
  id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  price DECIMAL(3,2) NOT NULL,
  period_start DATE NOT NULL,
  period_end DATE NOT NULL,
  period full_time(period_start, period_end),
);

INSERT INTO gummies (name, price, period_start, period_end)
VALUES ('Panditas', 15, '2018-1-1', '2019-1-1'),
       ('Gomitas', 16, '2018-1-1', '2019-1-1'),
       ('Droopies', 4, '2018-1-1', '2019-1-1'),
       ('Gums', 19, '2018-1-1', '2019-1-1'),
       ('Gomotas', 28, '2018-1-1', '2019-1-1'),
       ('Gomilocas', 12, '2018-1-1', '2019-1-1'),
       ('MegaGomas', 11, '2018-1-1', '2019-1-1'),
       ('Boligomas', 59, '2018-1-1', '2019-1-1'),
       ('Gomas de Borrar', 2, '2018-1-1', '2019-1-1'),
       ('MiniGomitas', 8, '2018-1-1', '2019-1-1'),
       ('Papas', 100, '2018-1-1', '2019-1-1'),
       ('Fin', 20, '2018-1-1', '2019-1-1');

UPDATE gummies FOR PORTION OF full_time
FROM '2018-2-1' to '2019-1-1'
SET price = price * 1.45;

UPDATE gummies FOR PORTION OF full_time
FROM '2018-4-25' to '2019-1-1'
SET price = price * 1.45;

UPDATE gummies FOR PORTION OF full_time
FROM '2018-10-25' to '2019-1-1'
SET price = price * 1.45;

UPDATE gummies FOR PORTION OF full_time
FROM '2018-2-15' to '2019-1-1'
SET price = (price * 1.45) + (price * 1.1);

UPDATE gummies FOR PORTION OF full_time
FROM '2018-5-5' to '2019-1-1'
SET price = (price * 1.45) + (price * 1.1);

UPDATE gummies FOR PORTION OF full_time
FROM '2018-11-5' to '2019-1-1'
SET price = (price * 1.45) + (price * 1.1);
