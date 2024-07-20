-- Crear el procedimiento almacenado para insertar una pel�cula y un registro en HistorialVisualizacion
CREATE PROCEDURE InsertarPeliculaYHistorialVisualizacion
    @Titulo NVARCHAR(100),
    @Genero NVARCHAR(50),
    @FechaEstreno DATE,
    @UsuarioID INT
AS
BEGIN
    -- Iniciar una transacci�n
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Insertar la nueva pel�cula en la tabla Peliculas
        INSERT INTO Peliculas (Titulo, Genero, FechaEstreno)
        VALUES (@Titulo, @Genero, @FechaEstreno);

        -- Obtener el ID de la pel�cula reci�n insertada
        DECLARE @NuevoPeliculaID INT;
        SET @NuevoPeliculaID = SCOPE_IDENTITY();

        -- Insertar un registro en la tabla HistorialVisualizacion para el usuario especificado
        INSERT INTO HistorialVisualizacion (UsuarioID, PeliculaID, FechaVisualizacion)
        VALUES (@UsuarioID, @NuevoPeliculaID, GETDATE());

        -- Confirmar la transacci�n
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Si ocurre un error, deshacer la transacci�n
        ROLLBACK TRANSACTION;
        -- Lanzar el error de nuevo para que pueda ser manejado por el cliente
        THROW;
    END CATCH;
END;

-- Insertar 3 peliculas 
EXEC InsertarPeliculaYHistorialVisualizacion 
    @Titulo = 'Rapidos Y Furiosos 11', 
    @Genero = 'Accion', 
    @FechaEstreno = '2025-04-04', 
    @UsuarioID = 1;

EXEC InsertarPeliculaYHistorialVisualizacion 
    @Titulo = 'Mickey 17', 
    @Genero = 'Ciencia Ficcion', 
    @FechaEstreno = '2025-01-31', 
    @UsuarioID = 1;

EXEC InsertarPeliculaYHistorialVisualizacion 
    @Titulo = 'Minecraft', 
    @Genero = 'Infantil', 
    @FechaEstreno = '2025-04-04', 
    @UsuarioID = 1;


	SElECT * FROM Peliculas;

	SElECT * FROM HistorialVisualizacion;



-- Crear el procedimiento almacenado para insertar un usuari
CREATE PROCEDURE InsertarUsuarioConSuscripcionYVisualizacion
    @Nombre NVARCHAR(100),
    @Email NVARCHAR(100),
    @Pass NVARCHAR(100),
    @FechaInicio DATE,
    @FechaFin DATE,
    @TipoSuscripcion NVARCHAR(50),
    @PeliculaID INT
AS
BEGIN
    -- Iniciar una transacci�n
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Insertar el nuevo usuario en la tabla Usuarios
        INSERT INTO Usuarios (Nombre, Email, Pass, FechaRegistro)
        VALUES (@Nombre, @Email, @Pass, GETDATE());

        -- Obtener el ID del usuario reci�n insertado
        DECLARE @NuevoUsuarioID INT;
        SET @NuevoUsuarioID = SCOPE_IDENTITY();

        -- Insertar la suscripci�n para el nuevo usuario
        INSERT INTO Suscripciones (UsuarioID, FechaInicio, FechaFin, Tipo)
        VALUES (@NuevoUsuarioID, @FechaInicio, @FechaFin, @TipoSuscripcion);

        -- Insertar un registro en la tabla HistorialVisualizacion para el nuevo usuario y la pel�cula especificada
        INSERT INTO HistorialVisualizacion (UsuarioID, PeliculaID, FechaVisualizacion)
        VALUES (@NuevoUsuarioID, @PeliculaID, GETDATE());

        -- Confirmar la transacci�n
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Si ocurre un error, deshacer la transacci�n
        ROLLBACK TRANSACTION;
        -- Lanzar el error de nuevo para que pueda ser manejado por el cliente
        THROW;
    END CATCH;
END;

EXEC InsertarUsuarioConSuscripcionYVisualizacion
    @Nombre = 'Jose jose', 
    @Email = 'jose.jose@outlook.com', 
    @Pass = 'Buenosdiasse�ors0l', 
    @FechaInicio = '2024-07-01', 
    @FechaFin = NULL, 
    @TipoSuscripcion = 'Mensual', 
    @PeliculaID = 1;

EXEC InsertarUsuarioConSuscripcionYVisualizacion
    @Nombre = 'Pedro Navajas', 
    @Email = 'Pedro.Navajas@outlook.com', 
    @Pass = 'Medebes400dolares@', 
    @FechaInicio = '2024-07-02', 
    @FechaFin = NULL, 
    @TipoSuscripcion = 'Semanal', 
    @PeliculaID = 1;

	EXEC InsertarUsuarioConSuscripcionYVisualizacion
    @Nombre = 'Mayweather', 
    @Email = 'May.weather@outlook.com', 
    @Pass = 'Invicto_0_Derrotas', 
    @FechaInicio = '2024-07-03', 
    @FechaFin = NULL, 
    @TipoSuscripcion = 'Mensual', 
    @PeliculaID = 1;

Select * From Suscripciones;




-- Crear el procedimiento almacenado para actualizar el correo de los usuarios y cambiar el tipo de suscripci�n a Anual
CREATE PROCEDURE ActualizarCorreoYCambiarTipoSuscripcion
    @UsuarioID INT,
    @NuevoEmail NVARCHAR(100)
AS
BEGIN
    -- Iniciar una transacci�n
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Actualizar el correo del usuario en la tabla Usuarios
        UPDATE Usuarios
        SET Email = @NuevoEmail
        WHERE UsuarioID = @UsuarioID;

        -- Cambiar el tipo de suscripci�n a 'Anual' en la tabla Suscripciones
        UPDATE Suscripciones
        SET Tipo = 'Anual'
        WHERE UsuarioID = @UsuarioID;

        -- Confirmar la transacci�n
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Si ocurre un error, deshacer la transacci�n
        ROLLBACK TRANSACTION;
        -- Lanzar el error de nuevo para que pueda ser manejado por el cliente
        THROW;
    END CATCH;
END;

EXEC ActualizarCorreoYCambiarTipoSuscripcion 
    @UsuarioID = 1, 
    @NuevoEmail = 'nuevo.email.Juan@example.com';

EXEC ActualizarCorreoYCambiarTipoSuscripcion 
    @UsuarioID = 2, 
    @NuevoEmail = 'nuevo.email.Maria@example.com';

EXEC ActualizarCorreoYCambiarTipoSuscripcion 
    @UsuarioID = 3, 
    @NuevoEmail = 'nuevo.email.Carlos@example.com';

Select * From Usuarios;

-- Crear el procedimiento almacenado para eliminar una pel�cula y todos los registros de esa pel�cula en HistorialVisualizacion
CREATE PROCEDURE EliminarPeliculaYHistorial
    @PeliculaID INT
AS
BEGIN
    -- Iniciar una transacci�n
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Eliminar los registros en HistorialVisualizacion para la pel�cula especificada
        DELETE FROM HistorialVisualizacion
        WHERE PeliculaID = @PeliculaID;

        -- Eliminar la pel�cula de la tabla Peliculas
        DELETE FROM Peliculas
        WHERE PeliculaID = @PeliculaID;

        -- Confirmar la transacci�n
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Si ocurre un error, deshacer la transacci�n
        ROLLBACK TRANSACTION;
        -- Lanzar el error de nuevo para que pueda ser manejado por el cliente
        THROW;
    END CATCH;
END;


























