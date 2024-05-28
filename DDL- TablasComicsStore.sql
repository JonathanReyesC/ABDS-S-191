-- Creación de la tabla Clientes
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY IDENTITY(1,1),
    nombre NVARCHAR(100),
    apellido NVARCHAR(100),
    correo_electronico NVARCHAR(255),
    telefono NVARCHAR(20)
);

-- Creación de la tabla Comics
CREATE TABLE Comics (
    id_comic INT PRIMARY KEY IDENTITY(1,1),
    titulo NVARCHAR(100),
    autor NVARCHAR(100),
    precio DECIMAL(10, 2),
    fecha_publicacion DATE
);

-- Creación de la tabla Inventario
CREATE TABLE Inventario (
    id_inventario INT PRIMARY KEY IDENTITY(1,1),
    id_comic INT,
    cantidad_disponible INT,
    precio_venta DECIMAL(10, 2),
    FOREIGN KEY (id_comic) REFERENCES Comics(id_comic)
);

-- Creación de la tabla Compras
CREATE TABLE Compras (
    id_compra INT PRIMARY KEY IDENTITY(1,1),
    id_cliente INT,
    fecha_compra DATE,
    total DECIMAL(10, 2),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Creación de la tabla Comic_Compras
CREATE TABLE Comic_Compras (
    id_cc INT PRIMARY KEY IDENTITY(1,1),
    id_compra INT,
    id_comic INT,
    cantidad INT,
    FOREIGN KEY (id_compra) REFERENCES Compras(id_compra),
    FOREIGN KEY (id_comic) REFERENCES Comics(id_comic)


 
);
