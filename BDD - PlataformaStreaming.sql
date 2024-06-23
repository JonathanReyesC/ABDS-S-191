-- Crear la base de datos PlataformaStreaming
CREATE DATABASE PlataformaStreaming;

-- Seleccionar la base de datos PlataformaStreaming
USE PlataformaStreaming;

CREATE TABLE Usuarios (
  UsuarioID INT IDENTITY(1,1) PRIMARY KEY,
  Nombre NVARCHAR (100) NOT NULL,
  Email NVARCHAR(100) NOT NULL UNIQUE,
  Pass NVARCHAR(100) NOT NULL,
  FechaRegistro DATE NOT NULL DEFAULT GETDATE()
);

CREATE TABLE Peliculas (
  PeliculaID INT IDENTITY(1,1) PRIMARY KEY,
  Titulo NVARCHAR (100) NOT NULL,
  Genero NVARCHAR(50),
  FechaEstreno DATE
);

CREATE TABLE Suscripciones (
  SuscripcionID INT IDENTITY (1,1) PRIMARY KEY,
  UsuarioID INT NOT NULL,
  FechaInicio DATE NOT NULL,
  FechaFin DATE,
  Tipo NVARCHAR(50),
  FOREIGN KEY (UsuarioID) REFERENCES Usuarios (UsuarioID)
);

CREATE TABLE HistorialVisualizacion (
  HistorialID INT IDENTITY (1,1) PRIMARY KEY,
  UsuarioID INT NOT NULL,
  PeliculaID INT NOT NULL,
  FechaVisualizacion DATETIME NOT NULL DEFAULT GETDATE(),
  FOREIGN KEY (UsuarioID) REFERENCES Usuarios (UsuarioID),
  FOREIGN KEY (PeliculaID) REFERENCES Peliculas (PeliculaID)
);

-- Insertar datos en la tabla Usuarios
INSERT INTO Usuarios (Nombre, Email, Pass, FechaRegistro) VALUES
('Juan Pérez', 'juan.perez@example.com', 'pass123', '2023-01-01'),
('María López', 'maria.lopez@example.com', 'pass456', '2023-02-15'),
('Carlos García', 'carlos.garcia@example.com', 'pass789', '2023-03-10'),
('Ana Martínez', 'ana.martinez@example.com', 'pass321', '2023-04-20'),
('Pedro Sánchez', 'pedro.sanchez@example.com', 'pass654', '2023-05-25'),
('Laura Fernández', 'laura.fernandez@example.com', 'pass987', '2023-06-30'),
('Miguel Torres', 'miguel.torres@example.com', 'pass111', '2023-07-05'),
('Lucía Ramírez', 'lucia.ramirez@example.com', 'pass222', '2023-08-10'),
('Jorge Díaz', 'jorge.diaz@example.com', 'pass333', '2023-09-15'),
('Sofía Gómez', 'sofia.gomez@example.com', 'pass444', '2023-10-20');

-- Insertar datos en la tabla Peliculas
INSERT INTO Peliculas (Titulo, Genero, FechaEstreno) VALUES
('La Aventura', 'Aventura', '2020-01-01'),
('El Misterio', 'Misterio', '2020-02-15'),
('La Comedia', 'Comedia', '2020-03-10'),
('El Drama', 'Drama', '2020-04-20'),
('La Acción', 'Acción', '2020-05-25'),
('El Romance', 'Romance', '2020-06-30'),
('La Fantasía', 'Fantasía', '2020-07-05'),
('El Horror', 'Horror', '2020-08-10'),
('La Ciencia Ficción', 'Ciencia Ficción', '2020-09-15'),
('El Documental', 'Documental', '2020-10-20'),
('El Musical', 'Musical', '2020-11-25');

-- Insertar datos en la tabla Suscripciones
INSERT INTO Suscripciones (UsuarioID, FechaInicio, FechaFin, Tipo) VALUES
(1, '2023-01-01', '2023-06-30', 'Mensual'),
(2, '2023-02-15', '2023-08-15', 'Anual'),
(3, '2023-03-10', NULL, NULL),
(4, '2023-04-20', '2023-10-20', 'Semestral'),
(5, '2023-05-25', NULL, NULL),
(6, '2023-06-30', '2023-12-31', 'Mensual'),
(7, '2023-07-05', '2023-09-30', 'Trimestral');

-- Insertar datos en la tabla HistorialVisualizacion
INSERT INTO HistorialVisualizacion (UsuarioID, PeliculaID, FechaVisualizacion) VALUES
(1, 1, '2023-01-01 10:00:00'),
(1, 2, '2023-01-02 12:00:00'),
(2, 3, '2023-02-16 14:00:00'),
(2, 4, '2023-02-17 16:00:00'),
(3, 5, '2023-03-11 18:00:00'),
(3, 6, '2023-03-12 20:00:00'),
(4, 7, '2023-04-21 22:00:00'),
(4, 8, '2023-04-22 11:00:00'),
(5, 9, '2023-05-26 13:00:00'),
(5, 10, '2023-05-27 15:00:00'),
(6, 11, '2023-07-01 17:00:00'),
(6, 1, '2023-07-02 19:00:00'),
(7, 2, '2023-08-06 21:00:00'),
(7, 3, '2023-08-07 23:00:00'),
(8, 4, '2023-09-11 09:00:00'),
(8, 5, '2023-09-12 11:00:00'),
(9, 6, '2023-10-16 13:00:00'),
(9, 7, '2023-10-17 15:00:00'),
(10, 8, '2023-11-21 17:00:00'),
(10, 9, '2023-11-22 19:00:00');

-- Crear la vista global de todas las tablas
CREATE VIEW VistaGlobal AS
SELECT 
    u.UsuarioID,
    u.Nombre AS NombreUsuario,
    u.Email,
    u.FechaRegistro,
    p.PeliculaID,
    p.Titulo AS TituloPelicula,
    p.Genero,
    p.FechaEstreno,
    s.SuscripcionID,
    s.FechaInicio AS FechaInicioSuscripcion,
    s.FechaFin AS FechaFinSuscripcion,
    s.Tipo AS TipoSuscripcion,
    h.HistorialID,
    h.FechaVisualizacion
FROM 
    Usuarios u
LEFT JOIN 
    Suscripciones s ON u.UsuarioID = s.UsuarioID
LEFT JOIN 
    HistorialVisualizacion h ON u.UsuarioID = h.UsuarioID
LEFT JOIN 
    Peliculas p ON h.PeliculaID = p.PeliculaID;

-- Consultar todos los datos de la vista VistaGlobal
SELECT * FROM VistaGlobal;


