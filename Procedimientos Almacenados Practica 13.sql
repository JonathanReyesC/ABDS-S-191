
-- CREAMOS EL PROCEDIMIENTO

CREATE PROCEDURE insertarUsuario
    @Nombre NVARCHAR(100),
	@Email NVARCHAR(100),
	@Pass NVARCHAR(100)
AS
BEGIN
          -- INSERTAMOS USUERIO EN LA TABLA 
          INSERT INTO Usuarios (Nombre, Email, Pass, FechaRegistro)
		  VALUES (@Nombre, @Email, @Pass, GETDATE());

		  ---RETORNAR ID DEL NUEVO USUARIO
          SELECT SCOPE_IDENTITY () AS NuevoUsuarioID;
END;

    
-- Insertar 3 usuarios

EXEC InsertarUsuario 
    @Nombre = 'Luis Mendoza',
    @Email = 'luis.mendoza@example.com',
    @Pass = 'contrase�a_segura';



EXEC InsertarUsuario 
    @Nombre = 'Carla Ruiz',
    @Email = 'carla.ruiz@example.com',
    @Pass = 'pass123';


EXEC InsertarUsuario 
    @Nombre = 'Fernando Castro',
    @Email = 'fernando.castro@example.com',
    @Pass = 'fernando2024';

-- Verificar la inserci�n del usuario
SELECT * FROM Usuarios;

-- Crear el procedimiento almacenado para editar una suscripci�n
CREATE PROCEDURE EditarSuscripcion
    @SuscripcionID INT,
    @FechaInicio DATE,
    @FechaFin DATE,
    @Tipo NVARCHAR(50)
AS
BEGIN
    -- Actualizar la suscripci�n en la tabla Suscripciones
    UPDATE Suscripciones
    SET 
        FechaInicio = @FechaInicio,
        FechaFin = @FechaFin,
        Tipo = @Tipo
    WHERE 
        SuscripcionID = @SuscripcionID;
END;

-- Llamar al procedimiento almacenado para editar una suscripci�n
EXEC EditarSuscripcion 
    @SuscripcionID = 1,
    @FechaInicio = '2023-01-01',
    @FechaFin = '2023-12-31',
    @Tipo = 'Anual';


EXEC EditarSuscripcion 
    @SuscripcionID = 2,
    @FechaInicio = '2023-02-01',
    @FechaFin = '2023-02-28',
    @Tipo = 'Mensual';

EXEC EditarSuscripcion 
    @SuscripcionID = 3,
    @FechaInicio = '2023-03-01',
    @FechaFin = '2023-05-31',
    @Tipo = 'Trimestral';

	
EXEC EditarSuscripcion 
    @SuscripcionID = 3,
    @FechaInicio = '2023-03-01',
    @FechaFin = '2023-05-31',
    @Tipo = 'Trimestral';


SELECT * FROM Suscripciones;

--Otro tipo de consulta 

SELECT * FROM Suscripciones WHERE SuscripcionID = 2;



-- Crear el procedimiento para eliminar historial de Visualizacion 
CREATE PROCEDURE EliminarHistorialVisualizacion
    @HistorialID INT
AS
BEGIN
    -- Eliminar el registro en la tabla HistorialVisualizacion
    DELETE FROM HistorialVisualizacion
    WHERE HistorialID = @HistorialID;
END;

-- Llamar al procedimiento almacenado 
EXEC EliminarHistorialVisualizacion 
    @HistorialID = 1;


EXEC EliminarHistorialVisualizacion 
    @HistorialID = 2;

EXEC EliminarHistorialVisualizacion 
    @HistorialID = 3;


SELECT * FROM HistorialVisualizacion WHERE HistorialID = 3;


-- Crear el procedimiento almacenado para consultar usuarios con suscripci�n por tipo
CREATE PROCEDURE ConsultarUsuariosPorTipoSuscripcion
    @Tipo NVARCHAR(50)
AS
BEGIN
    -- Seleccionar usuarios y suscripciones basadas en el tipo de suscripci�n
    SELECT 
        u.UsuarioID,
        u.Nombre AS NombreUsuario,
        u.Email,
        u.FechaRegistro,
        s.SuscripcionID,
        s.FechaInicio,
        s.FechaFin,
        s.Tipo
    FROM 
        Usuarios u
    INNER JOIN 
        Suscripciones s ON u.UsuarioID = s.UsuarioID
    WHERE 
        s.Tipo = @Tipo;
END;




-- Consultar usuarios con suscripci�n 
EXEC ConsultarUsuariosPorTipoSuscripcion 
    @Tipo = 'Anual';

EXEC ConsultarUsuariosPorTipoSuscripcion 
    @Tipo = 'Mensual';


EXEC ConsultarUsuariosPorTipoSuscripcion
    @Tipo = 'Trimestral';

-- Crear el procedimiento almacenado para consultar pel�culas reproducidas por usuarios seg�n el g�nero
CREATE PROCEDURE ConsultarPeliculasPorGenero
    @Genero NVARCHAR(50)
AS
BEGIN
    -- Seleccionar pel�culas y usuarios basadas en el g�nero de la pel�cula
    SELECT 
        u.UsuarioID,
        u.Nombre AS NombreUsuario,
        u.Email,
        p.PeliculaID,
        p.Titulo AS TituloPelicula,
        p.Genero,
        p.FechaEstreno,
        h.FechaVisualizacion
    FROM 
        Usuarios u
    INNER JOIN 
        HistorialVisualizacion h ON u.UsuarioID = h.UsuarioID
    INNER JOIN 
        Peliculas p ON h.PeliculaID = p.PeliculaID
    WHERE 
        p.Genero = @Genero;
END;

 ---Consultar pel�culas reproducidas de g�nero 'Acci�n'
EXEC ConsultarPeliculasPorGenero 
    @Genero = 'Acci�n';

EXEC ConsultarPeliculasPorGenero 
    @Genero = 'Comedia';

EXEC ConsultarPeliculasPorGenero 
    @Genero = 'Infantil';