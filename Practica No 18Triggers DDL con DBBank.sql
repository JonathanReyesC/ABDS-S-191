Use DBBank;



-- Crear Trigger DDL para detectar la creación de tablas
CREATE TRIGGER Trigger_CreacionTabla
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
    PRINT 'Se ha creado una nueva tabla en DBBANK.';
END;




-- Crear tabla Prestamos
CREATE TABLE Prestamos (
    PrestamoID INT IDENTITY(1,1) PRIMARY KEY,
    ClienteID INT,
    Monto DECIMAL(18, 2),
    TasaInteres DECIMAL(5, 2),
    FechaInicio DATE,
    FechaFin DATE,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);


-- Insertar registros en la tabla Prestamos
INSERT INTO Prestamos (ClienteID, Monto, TasaInteres, FechaInicio, FechaFin) VALUES 
(1, 10000.00, 5.5, '2023-01-01', '2024-01-01'),
(2, 15000.00, 6.0, '2023-02-01', '2024-02-01'),
(3, 20000.00, 4.5, '2023-03-01', '2024-03-01');

Select * From Prestamos;

-- Crear tabla Pagos
CREATE TABLE Pagos (
    PagoID INT IDENTITY(1,1) PRIMARY KEY,
    PrestamoID INT,
    MontoPagado DECIMAL(18, 2),
    FechaPago DATE,
    FOREIGN KEY (PrestamoID) REFERENCES Prestamos(PrestamoID)
);

-- Insertar registros en la tabla Pagos
INSERT INTO Pagos (PrestamoID, MontoPagado, FechaPago) VALUES 
(1, 1000.00, '2023-02-01'),
(2, 1500.00, '2023-03-01'),
(3, 2000.00, '2023-04-01');

Select * from Pagos;




-- Eliminar el Trigger si ya existe para evitar errores de duplicación
IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'Trigger_CreacionProcedimiento')
BEGIN
    DROP TRIGGER Trigger_CreacionProcedimiento ON DATABASE;
END;
GO

-- Crear Trigger DDL para detectar la creación de Procedimientos Almacenados
CREATE TRIGGER Trigger_CreacionProcedimiento
ON DATABASE
FOR CREATE_PROCEDURE
AS
BEGIN
    PRINT 'Se ha creado un Nuevo Procedimiento en DBBANK.';
END;





-- Crear el Procedimiento para ingresar un nuevo préstamo y el primer pago
CREATE PROCEDURE InsertarPrestamoYPago
    @ClienteID INT,
    @Monto DECIMAL(18, 2),
    @TasaInteres DECIMAL(5, 2),
    @FechaInicio DATE,
    @FechaFin DATE,
    @MontoPagado DECIMAL(18, 2),
    @FechaPago DATE
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRANSACTION;

    BEGIN TRY
        -- Insertar el nuevo préstamo
        DECLARE @PrestamoID INT;

        INSERT INTO Prestamos (ClienteID, Monto, TasaInteres, FechaInicio, FechaFin)
        VALUES (@ClienteID, @Monto, @TasaInteres, @FechaInicio, @FechaFin);

        -- Obtener el ID del préstamo recién insertado
        SET @PrestamoID = SCOPE_IDENTITY();

        -- Insertar el primer pago del préstamo
        INSERT INTO Pagos (PrestamoID, MontoPagado, FechaPago)
        VALUES (@PrestamoID, @MontoPagado, @FechaPago);

        -- Confirmar la transacción
        COMMIT TRANSACTION;

        PRINT 'Préstamo y primer pago insertados correctamente.';
    END TRY
    BEGIN CATCH
        -- Deshacer la transacción en caso de error
        ROLLBACK TRANSACTION;
        PRINT 'Ocurrió un error, se deshizo la transacción.';
    END CATCH
END;






-- Crear el Procedimiento para consultar los clientes con sus préstamos y pagos
CREATE PROCEDURE ConsultarClientesPrestamosYPagos
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        c.ClienteID,
        c.Nombre,
        c.Direccion,
        c.Telefono,
        c.Email,
        p.PrestamoID,
        p.Monto,
        p.TasaInteres,
        p.FechaInicio,
        p.FechaFin,
        pa.PagoID,
        pa.MontoPagado,
        pa.FechaPago
    FROM 
        Clientes c
    INNER JOIN 
        Prestamos p ON c.ClienteID = p.ClienteID
    LEFT JOIN 
        Pagos pa ON p.PrestamoID = pa.PrestamoID
    ORDER BY 
        c.ClienteID, p.PrestamoID, pa.PagoID;
END;





---- Ejecutar el procedimiento para ingresar un nuevo préstamo y el primer pago
EXEC InsertarPrestamoYPago 
    @ClienteID = 1,
    @Monto = 5000.00,
    @TasaInteres = 5.0,
    @FechaInicio = '2023-07-01',
    @FechaFin = '2024-07-01',
    @MontoPagado = 500.00,
    @FechaPago = '2023-07-10';

Verifiaciones 


-- Ejecutar el procedimiento para consultar los clientes con sus préstamos y pagos
EXEC ConsultarClientesPrestamosYPagos;
