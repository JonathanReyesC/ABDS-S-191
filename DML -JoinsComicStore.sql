
--inner Join

Select c.id_compra, cl.nombre AS Cliente, c.fecha_compra, c.total
from Compras c
JOIN Clientes cl ON c.id_cliente = cl.id_cliente;

--LEFT

Select c.id_compra, cl.nombre AS Cliente, c.fecha_compra, c.total
from Compras c
LEFT JOIN Clientes cl ON c.id_cliente = cl.id_cliente;


--RIGHT
Select c.id_compra, cl.nombre AS Cliente, c.fecha_compra, c.total
from Compras c
RIGHT JOIN Clientes cl ON c.id_cliente = cl.id_cliente;

--Full Join

SELECT *

FROM Clientes cl
FULL JOIN Compras c
ON c.id_cliente = cl.id_cliente;