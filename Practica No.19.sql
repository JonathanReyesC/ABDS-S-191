
-- Crear Trigger para avisar después de insertar un nuevo cliente
CREATE TRIGGER Trigger_AvisoInsercionCliente
ON Clientes
AFTER INSERT
AS
BEGIN
    PRINT 'Se ha insertado un nuevo cliente en DBBANK.';
END;

-- Insertar un nuevo cliente
INSERT INTO Clientes (Nombre, Direccion, Telefono, Email)
VALUES ('Emiliano Zapata', 'Calle Desconocida', '442-5678-567', 'Emilio987@gmail.com');


-- Crear Trigger para avisar después de eliminar un cliente
CREATE TRIGGER Trigger_AvisoEliminacionCliente
ON Clientes
AFTER DELETE
AS
BEGIN
    PRINT 'Se ha eliminado un cliente de DBBANK.';
END;

-- Eliminar las transacciones asociadas a las cuentas del cliente
DELETE FROM Transacciones WHERE CuentaID IN (SELECT CuentaID FROM Cuentas WHERE ClienteID = 1);


-- Eliminar las cuentas del cliente
DELETE FROM Cuentas WHERE ClienteID = 1;


-- Eliminar los préstamos asociados al cliente
DELETE FROM Pagos WHERE PrestamoID IN (SELECT PrestamoID FROM Prestamos WHERE ClienteID = 1);


-- Eliminar los préstamos del cliente
DELETE FROM Prestamos WHERE ClienteID = 1;


-- Eliminar el cliente
DELETE FROM Clientes WHERE ClienteID = 1;



-- Crear Trigger para validar la existencia del cliente antes de insertar una cuenta
CREATE TRIGGER Trigger_ValidarClienteCuenta
ON Cuentas
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @ClienteID INT;

    SELECT @ClienteID = ClienteID FROM INSERTED;

    IF EXISTS (SELECT 1 FROM Clientes WHERE ClienteID = @ClienteID)
    BEGIN
        INSERT INTO Cuentas (ClienteID, TipoCuenta, Saldo, FechaApertura)
        SELECT ClienteID, TipoCuenta, Saldo, FechaApertura FROM INSERTED;
        PRINT 'Cuenta creada exitosamente.';
    END
    ELSE
    BEGIN
        PRINT 'Error: El cliente no existe en DBBANK.';
    END;
END;

-- Crear una nueva cuenta
INSERT INTO Cuentas (ClienteID, TipoCuenta, Saldo, FechaApertura)
VALUES (1, 'Ahorros', 1000.00, '2024-07-10');

CREATE TRIGGER Trigger_ValidarSaldoCuenta
ON Cuentas
INSTEAD OF UPDATE
AS
BEGIN
    -- Verificar si hay saldos negativos en la tabla INSERTED
    IF EXISTS (SELECT 1 FROM inserted WHERE Saldo < 0)
    BEGIN
        -- Generar un error y revertir la transacción si se encuentra saldo negativo
        RAISERROR ('Error: No se puede actualizar la cuenta con un saldo negativo.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        -- Actualizar los registros si no hay saldos negativos
        UPDATE Cuentas
        SET Saldo = inserted.Saldo,
            TipoCuenta = inserted.TipoCuenta,
            FechaApertura = inserted.FechaApertura,
            ClienteID = inserted.ClienteID
        FROM inserted
        WHERE Cuentas.CuentaID = inserted.CuentaID;
    END
END;

Verificamos con un saldo negativo:

UPDATE Cuentas
SET Saldo = -500.00
WHERE CuentaID = 1;

-- Crear Trigger para evitar eliminar préstamos con pagos asociados
CREATE TRIGGER Trigger_EvitarEliminacionPrestamo
ON Prestamos
INSTEAD OF DELETE
AS
BEGIN
    DECLARE @PrestamoID INT;

    SELECT @PrestamoID = PrestamoID FROM DELETED;

    IF EXISTS (SELECT 1 FROM Pagos WHERE PrestamoID = @PrestamoID)
    BEGIN
        PRINT 'Error: No se puede eliminar el préstamo porque tiene pagos asociados.';
    END
    ELSE
    BEGIN
        DELETE FROM Prestamos WHERE PrestamoID = @PrestamoID;
        PRINT 'Préstamo eliminado exitosamente.';
    END;
END;
GO


-- Crear la tabla logClientes
CREATE TABLE logClientes (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    Operacion NVARCHAR(10),
    FechaHora DATETIME DEFAULT GETDATE()
);
GO

-- Eliminar los pagos del préstamo antes de eliminar el préstamo
DELETE FROM Pagos WHERE PrestamoID = 1;
GO

-- Eliminar un préstamo
DELETE FROM Prestamos WHERE PrestamoID = 1;
GO



-- Crear Trigger para registrar operaciones en la tabla logClientes
CREATE TRIGGER Trigger_RegistroLogClientes
ON Clientes
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @Operacion NVARCHAR(10);

    IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
        SET @Operacion = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM INSERTED)
        SET @Operacion = 'INSERT';
    ELSE IF EXISTS (SELECT * FROM DELETED)
        SET @Operacion = 'DELETE';

    INSERT INTO logClientes (Operacion)
    VALUES (@Operacion);
END;
GO

-- Crear Trigger para validar que no se ingrese un saldo negativo en la tabla Cuentas
CREATE TRIGGER Trigger_ValidarSaldoCuenta
ON Cuentas
AFTER UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE Saldo < 0)
    BEGIN
        RAISERROR ('Error: No se puede actualizar la cuenta con un saldo negativo.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- Verificar la existencia del Trigger
SELECT * FROM sys.triggers WHERE name = 'Trigger_ValidarSaldoCuenta';
GO

-- Eliminar el Trigger existente si es necesario
DROP TRIGGER IF EXISTS Trigger_ValidarSaldoCuenta;
GO





-- Eliminar el Trigger existente
DROP TRIGGER IF EXISTS Trigger_ValidarSaldoCuenta;
GO

GO













