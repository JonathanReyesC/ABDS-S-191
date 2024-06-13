-- Crear la vista Vista_ComprasComic
CREATE VIEW Vista_ComprasComic AS
SELECT
    cc.id_cc,
    cc.cantidad,
    com.titulo AS nombre_comic,
    c.id_compra,
    c.fecha_compra,
    c.total
FROM 
    Comic_Compras cc
JOIN 
    Comics com ON cc.id_comic = com.id_comic
JOIN 
    Compras c ON cc.id_compra = c.id_compra;


-- Seleccionar datos de la vista
SELECT * FROM Vista_ComprasComic;



-- Crear la vista Vista_ComicsComprados
CREATE VIEW Vista_ComicsComprados AS
SELECT
    cl.id_cliente,
    cl.nombre + ' ' + cl.apellido AS nombre_cliente,
    SUM(cc.cantidad) AS cantidad_comics_comprados
FROM 
    Clientes cl
JOIN 
    Compras c ON cl.id_cliente = c.id_cliente
JOIN 
    Comic_Compras cc ON c.id_compra = cc.id_compra
GROUP BY 
    cl.id_cliente, 
    cl.nombre, 
    cl.apellido;



-- Seleccionar datos de la vista para verificar
SELECT * FROM Vista_ComicsComprados;





