--Víctor Rendón S. | A01022462 | Evaluación 1: Parte 1

--Crear tabla LOG_FILM
CREATE TABLE LOG_FILM (
  id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  type VARCHAR(15) NOT NULL,
  film_id SMALLINT UNSIGNED NOT NULL,
  old_value SMALLINT UNSIGNED,
  new_value SMALLINT UNSIGNED,
  time_stamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
);

--Stored Procedure
DELIMITER $$
CREATE PROCEDURE insert_to_log_film(
	IN insert_type varchar(15), IN insert_film_id SMALLINT,
  IN insert_old_value SMALLINT, IN insert_new_value SMALLINT, IN insert_timestamp TIMESTAMP
)
  BEGIN
  	INSERT INTO LOG_FILM (type, film_id, old_value, new_value, time_stamp)
    VALUES (insert_type, insert_film_id, insert_old_value, insert_new_value, insert_timestamp)
  END $$
DELIMITER ;

--Trigger
DELIMITER $$
CREATE TRIGGER store_log_film
AFTER UPDATE OF original_language_id ON film
FOR EACH ROW
BEGIN
  CALL insert_to_log_film(type, film_id, old_value, new_value, time_stamp);
END;
DELIMITER ;

 --Stored procedure con Cursores
DELIMITER $$
CREATE PROCEDURE update_original_language()
  BEGIN
    DECLARE ids int;
    DECLARE done int DEFAULT FALSE;
    DECLARE cursor1 CURSOR FOR SELECT film_id FROM film;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = true;

    OPEN cursor1;
    read_loop: LOOP
      FETCH cursor1 INTO ids;
      IF done THEN
        LEAVE read_loop;
      END IF;
      IF (SELECT category_id FROM film_category WHERE film_id = ids) = 6
        THEN UPDATE film SET original_language_id=2 WHERE film_id = ids;

      ELSEIF (SELECT category_id FROM film_category WHERE film_id = ids) = 9
        THEN UPDATE film SET original_language_id=3 WHERE film_id = ids;

      ELSEIF (SELECT COUNT(*) FROM film_actor WHERE film_id = ids AND actor_id= 31) = 1
        THEN UPDATE film SET original_language_id=6 WHERE film_id = ids;

      ELSEIF (SELECT COUNT(*) FROM film_actor WHERE film_id = ids AND actor_id= 3) = 1
        THEN UPDATE film SET original_language_id=4 WHERE film_id = ids;

      ELSEIF (SELECT COUNT(*) FROM film_actor WHERE film_id = ids AND actor_id= 34) = 1
        THEN UPDATE film SET original_language_id=5 WHERE film_id = ids;

      ELSE
        UPDATE film SET original_language_id=1 WHERE film_id = ids;
      END IF;
    END LOOP;
    CLOSE cursor1;
  END $$
DELIMITER ;
