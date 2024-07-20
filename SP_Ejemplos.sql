--Explorar las propiedades de una base de Datos

EXEC sp_helpdb

EXEC sp_helpdb 'ComicStore'


--Explorar las propiedades de un obejto de la BD

EXEC sp_help 'clientes'


-- llaves primarias de una tabla 
EXEC sp_helpindex 'clientes'

--informacion de los usuarios y procesos actuales

EXEC sp_who

--rendimiento del servidor 

EXEC sp_monitor

--Espacio usado por la BD

EXEC sp_spaceused

-- puerto de escucha del SQL SERVER

EXEC sp_readerrorlog 0,1





----Nuestros procedimientos Almacenados 

-- Proceminiento para consultar el historial 
CREATE PROCEDURE sp_ObtenerHistorial
@usuarioId INT
AS

BEGIN
SELECT h.HistorialID, p.Titulo, h.FechaVisualizacion
FROM HistorialVisualizacion h
JOIN Peliculas P ON h.PeliculaID = P.PeliculaID
WHERE h.UsuarioID = @usuarioId
ORDER BY h.FechaVisualizacion DESC
END;

--Ejecucion del Historial

EXEC sp_ObtenerHistorial 3
--SP para insertar peliculas 
CREATE PROCEDURE sp_insertarPeliculas 
@Titulo NVARCHAR (100),
@Genero NVARCHAR (50),
@FechaEstreno DATE

AS
BEGIN
INSERT INTO Peliculas(Titulo,Genero,FechaEstreno) VALUES(@Titulo, @Genero, @FechaEstreno)

END;

EXEC  sp_insertarPeliculas @Titulo = 'Intensamente 2', @Genero = 'Infantil',@FechaEstreno = '2024-06-13'


SELECT * FROM Peliculas;