--Víctor Rendón Suárez | A01022462

explain
SELECT textDescription
FROM customers c, orders o, orderdetails od, products p, productlines, pl,
WHERE c.customernumber = 112
AND c.customerNumber = o.customerNumber
AND o.orderNumber = od.orderNumber
AND od.productCode = p.productCode
AND p.productCode = pl.productLine
