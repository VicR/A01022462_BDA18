drop procedure if exists concat_film_category;
delimiter //
CREATE PROCEDURE concat_film_category()
BEGIN
  DECLARE ids int;
  DECLARE done INT DEFAULT FALSE;
  DECLARE cursor1 CURSOR FOR SELECT film_id FROM film;
  DECLARE CONTINUE HANDLER
	FOR NOT FOUND
	SET done = TRUE;

  OPEN cursor1;
  read_loop: LOOP
    IF done THEN
      LEAVE read_loop;
    END IF;
		FETCH cursor1 INTO ids;
			UPDATE film as a JOIN film_category as b ON a.film_id = b.film_id JOIN category as c on b.category_id = c.category_id
            SET title = concat(c.name,"_",title);
			WHERE a.film_id = ids;
	END LOOP;
  CLOSE cursor1;
END//
delimiter;
