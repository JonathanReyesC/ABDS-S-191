-- Crear el procedimiento almacenado 
CREATE PROCEDURE InsertarSuscripcion
    @UsuarioID INT,
    @FechaInicio DATE,
    @FechaFin DATE,
    @Tipo NVARCHAR(50)
AS
BEGIN
    -- Iniciar una transacci�n
    BEGIN TRANSACTION;
    BEGIN TRY
        -- Insertar la nueva suscripci�n
        INSERT INTO Suscripciones (UsuarioID, FechaInicio, FechaFin, Tipo)
        VALUES (@UsuarioID, @FechaInicio, @FechaFin, @Tipo);

        -- Actualizar la fecha de registro
        UPDATE Usuarios
        SET FechaRegistro = @FechaInicio
        WHERE UsuarioID = @UsuarioID;

        -- Confirmar la transacci�n
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Si ocurre un error elimina latransaccion
        ROLLBACK TRANSACTION;
		
END CATCH;
END;
