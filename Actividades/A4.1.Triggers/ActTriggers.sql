--Víctor Rendón S. | A01022462

-- Trigger que no permite incrementar un salario por más del 30%
CREATE TRIGGER controlar_salario BEFORE UPDATE OF salary ON employee REFERENCING NEW AS new OLD AS old FOR EACH ROW MODE DB2SQL WHEN (new.salary > 1.3 * old.salary) BEGIN ATOMIC SIGNAL SQLSTATE '75000' SET MESSAGE_TEXT='No puedes hacer eso viejo.'; END

-- Trigger que permite crear/insertar una orden de compra si hay suficientes productos
CREATE TABLE ordenCompra(productId varchar(20) NOT NULL, quantity int NOT NULL, state varchar(20) NOT NULL)

CREATE TRIGGER admin_orden BEFORE UPDATE OF ordenCompra ON employee REFERENCING NEW AS new OLD AS old FOR EACH ROW MODE DB2SQL WHEN (new.salary > 1.3 * old.salary) BEGIN ATOMIC SIGNAL SQLSTATE '75000' SET MESSAGE_TEXT='No puedes hacer eso viejo.'; END

-- Trigger que cuando una orden de compra cambia a "Delivered" resta los productos del inventario
