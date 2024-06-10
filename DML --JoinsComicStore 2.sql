--Crea una consulta para obtener el nombre del cómic con los disponibles en el inventario

SELECT c.titulo, i.cantidad_disponible
FROM Comics c
INNER JOIN Inventario i ON c.id_comic = i.id_comic
WHERE i.cantidad_disponible > 0;


--Crea una consulta para desplegar los detalles de las compras realizadas por cada cliente y los cómics comprados
SELECT 
    cl.nombre AS NombreCliente, 
    cl.apellido AS ApellidoCliente,
    c.id_compra, 
    c.fecha_compra, 
    cc.cantidad, 
    com.titulo AS TituloComic, 
    com.autor AS AutorComic, 
    com.precio AS PrecioComic
FROM 
    Compras c
INNER JOIN 
    Clientes cl ON c.id_cliente = cl.id_cliente
INNER JOIN 
    Comic_Compras cc ON c.id_compra = cc.id_compra
INNER JOIN 
    Comics com ON cc.id_comic = com.id_comic
ORDER BY 
    cl.id_cliente, c.fecha_compra;

--Crea una consulta para obtener todas las compras junto con la cantidad disponible de cómics en el inventario incluidos los que no han sido comprados

SELECT 
    c.id_compra,
    cl.nombre AS NombreCliente,
    cl.apellido AS ApellidoCliente,
    com.titulo AS TituloComic,
    com.autor AS AutorComic,
    cc.cantidad,
    COALESCE(i.cantidad_disponible, 0) AS cantidad_disponible
FROM 
    Compras c
LEFT JOIN 
    Comic_Compras cc ON c.id_compra = cc.id_compra
LEFT JOIN 
    Clientes cl ON c.id_cliente = cl.id_cliente
LEFT JOIN 
    Comics com ON cc.id_comic = com.id_comic
LEFT JOIN 
    Inventario i ON com.id_comic = i.id_comic
ORDER BY 
    c.id_compra;

--Consulta para enlistar todos los cómics y su cantidad disponible en el inventario

SELECT 
    com.id_comic,
    com.titulo AS TituloComic,
    com.autor AS AutorComic,
    COALESCE(i.cantidad_disponible, 0) AS cantidad_disponible
FROM 
    Comics com
LEFT JOIN 
    Inventario i ON com.id_comic = i.id_comic
ORDER BY 
    com.id_comic;

--Crea una consulta todos datos de los comics, comics compras e inventario disponible
SELECT 
    com.id_comic,
    com.titulo AS TituloComic,
    com.autor AS AutorComic,
    com.precio AS PrecioComic,
    com.fecha_publicacion AS FechaPublicacion,
    COALESCE(cc.cantidad, 0) AS CantidadComprada,
    COALESCE(i.cantidad_disponible, 0) AS CantidadDisponible
FROM 
    Comics com
LEFT JOIN 
    Comic_Compras cc ON com.id_comic = cc.id_comic
LEFT JOIN 
    Inventario i ON com.id_comic = i.id_comic
ORDER BY 
    com.id_comic;

--Crea una consulta que muestre solo los clientes que compraron algo con su id de compra nombre del comic ,cantidad de compra y los disponibles en inventario
SELECT 
    cl.id_cliente,
    cl.nombre AS NombreCliente,
    cl.apellido AS ApellidoCliente,
    c.id_compra,
    com.titulo AS TituloComic,
    cc.cantidad AS CantidadComprada,
    COALESCE(i.cantidad_disponible, 0) AS CantidadDisponible
FROM 
    Clientes cl
INNER JOIN 
    Compras c ON cl.id_cliente = c.id_cliente
INNER JOIN 
    Comic_Compras cc ON c.id_compra = cc.id_compra
INNER JOIN 
    Comics com ON cc.id_comic = com.id_comic
LEFT JOIN 
    Inventario i ON com.id_comic = i.id_comic
ORDER BY 
    cl.id_cliente, c.id_compra;

