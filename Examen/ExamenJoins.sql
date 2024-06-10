CREATE TABLE Autores (
    id_autor BIGINT IDENTITY(300,1) PRIMARY KEY,
    nombre NVARCHAR(100),
    pais_origen NVARCHAR(100)
);
-- Creación de la tabla Autores
CREATE TABLE Autores (
    id_autor BIGINT IDENTITY(300,1) PRIMARY KEY,
    nombre NVARCHAR(100),
    pais_origen NVARCHAR(100)
);
ALTER TABLE Comics
ADD id_autor BIGINT;

ALTER TABLE Comics
ADD FOREIGN KEY (id_autor) REFERENCES Autores(id_autor);

-- Agregar columna id_autor a la tabla Comics
ALTER TABLE Comics
ADD id_autor BIGINT;

-- Establecer id_autor como clave foránea en la tabla Comics
ALTER TABLE Comics
ADD CONSTRAINT FK_Comics_Autores FOREIGN KEY (id_autor) REFERENCES Autores(id_autor);



-- Inserción de 4 autores en la tabla Autores
INSERT INTO Autores (nombre, pais_origen) VALUES
('Carlos Ruiz', 'España'),
('Ana Méndez', 'México'),
('Luis Fernández', 'Argentina'),
('Marta López', 'Chile');


-- Actualización de la tabla Comics asignando autores
UPDATE Comics SET id_autor = 300 WHERE titulo = 'El vigilante';
UPDATE Comics SET id_autor = 301 WHERE titulo = 'Aventuras espaciales';
UPDATE Comics SET id_autor = 302 WHERE titulo = 'Héroe urbano';
UPDATE Comics SET id_autor = 303 WHERE titulo = 'Misterios del futuro';
UPDATE Comics SET id_autor = 300 WHERE titulo = 'La sombra nocturna';
UPDATE Comics SET id_autor = 301 WHERE titulo = 'Guardianes de la galaxia';
UPDATE Comics SET id_autor = 302 WHERE titulo = 'El último samurái';
UPDATE Comics SET id_autor = 303 WHERE titulo = 'Los invencibles';
-- Deja los siguientes 4 cómics sin autor
-- 'Cazadores de monstruos', 'La leyenda del dragón', 'El enigma del faraón', 'Los guardianes del tiempo'
UPDATE Comics SET id_autor = 300 WHERE titulo = 'Aventuras medievales';
UPDATE Comics SET id_autor = 301 WHERE titulo = 'El reino perdido';
UPDATE Comics SET id_autor = 302 WHERE titulo = 'Los secretos del universo';



SELECT 
    a.nombre AS autor, 
    c.titulo AS comic, 
    i.cantidad_disponible
FROM 
    Comics c
LEFT JOIN 
    Autores a ON c.id_autor = a.id_autor
LEFT JOIN 
    Inventario i ON c.id_comic = i.id_comic;


SELECT 
    a.pais_origen, 
    a.nombre AS autor, 
    c.titulo AS comic
FROM 
    Comics c
INNER JOIN 
    Autores a ON c.id_autor = a.id_autor
WHERE 
    c.id_autor IS NOT NULL;

