--Víctor Rendón Suárez | A01022462

CREATE INDEX index_1 ON orderdetails (orderLineNumber);
CREATE INDEX index_2 ON orderdetails (quantityOrdered, orderLineNumber);
CREATE INDEX index_3 ON orderdetails (orderLineNumber, quantityOrdered);

EXPLAIN format=json
SELECT * FROM orderdetails force index(index_1)
WHERE orderLineNumber = 1 and quantityOrdered > 50;

-- query_cost: 95.20

EXPLAIN format=json
SELECT productCode FROM orderdetails force index(index_2)
WHERE orderLineNumber = 1 and quantityOrdered > 50;

-- query_cost: 93.41

EXPLAIN format=json
SELECT orderLineNumber, count(*) FROM orderdetails force index(index_3)
WHERE orderLineNumber = 1 and quantityOrdered > 50;

-- query_cost: 93.41
