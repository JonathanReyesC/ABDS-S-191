CREATE TABLE Autores (
    id_autor BIGINT IDENTITY(300,1) PRIMARY KEY,
    nombre NVARCHAR(100),
    pais_origen NVARCHAR(100)
);
-- Creaci�n de la tabla Autores
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

-- Establecer id_autor como clave for�nea en la tabla Comics
ALTER TABLE Comics
ADD CONSTRAINT FK_Comics_Autores FOREIGN KEY (id_autor) REFERENCES Autores(id_autor);



-- Inserci�n de 4 autores en la tabla Autores
INSERT INTO Autores (nombre, pais_origen) VALUES
('Carlos Ruiz', 'Espa�a'),
('Ana M�ndez', 'M�xico'),
('Luis Fern�ndez', 'Argentina'),
('Marta L�pez', 'Chile');


-- Actualizaci�n de la tabla Comics asignando autores
UPDATE Comics SET id_autor = 300 WHERE titulo = 'El vigilante';
UPDATE Comics SET id_autor = 301 WHERE titulo = 'Aventuras espaciales';
UPDATE Comics SET id_autor = 302 WHERE titulo = 'H�roe urbano';
UPDATE Comics SET id_autor = 303 WHERE titulo = 'Misterios del futuro';
UPDATE Comics SET id_autor = 300 WHERE titulo = 'La sombra nocturna';
UPDATE Comics SET id_autor = 301 WHERE titulo = 'Guardianes de la galaxia';
UPDATE Comics SET id_autor = 302 WHERE titulo = 'El �ltimo samur�i';
UPDATE Comics SET id_autor = 303 WHERE titulo = 'Los invencibles';
-- Deja los siguientes 4 c�mics sin autor
-- 'Cazadores de monstruos', 'La leyenda del drag�n', 'El enigma del fara�n', 'Los guardianes del tiempo'
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

