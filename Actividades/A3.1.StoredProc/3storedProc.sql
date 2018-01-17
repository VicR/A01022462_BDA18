--Víctor Rendón S. | A01022462

-- Muestra productos por "product line"
delimiter $$
create procedure show_products(
IN linea_producto varchar(50))

BEGIN
	declare line varchar(50);

	set line = concat(linea_producto, "%");
	select * from products
	where productLine like line;
END$$
delimiter ;

-- Muestra cuantos clientes inicia su nombre con la letra "variable"
delimiter $$
create procedure show_customer_letter(
IN letter CHAR)

BEGIN
	declare ctr int default 0;

	select count(*) into ctr from customers WHERE customerName LIKE CONCAT(letter, "%");
	select ctr;
END$$
delimiter ;

--Encontrar más caro y más barato
delimiter $$
create procedure find_prices(
)
BEGIN
	select MAX(buyPrice), MIN(buyPrice) from products;
END$$
delimiter ;
