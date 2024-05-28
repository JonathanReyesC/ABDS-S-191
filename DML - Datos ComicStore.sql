INSERT INTO Clientes (nombre, apellido, correo_electronico, telefono) VALUES
('Juan', 'P�rez', 'juan.perez@email.com', '+1 555-987-345'),
('Laura', 'Garc�a', 'laura.garcia@email.com', '+1 555-0102-543'),
('Carlos', 'L�pez', 'carlos.lopez@email.com', '+1 555-0103-987'),
('Ana', 'Mart�nez', 'ana.martinez@email.com', '+1 555-0104-765'),
('Luis', 'Gonz�lez', 'luis.gonzalez@email.com', '+1 555-0105-876'),
('Marta', 'Rodr�guez', 'marta.rodriguez@email.com', '+1 555-0106-954'),
('Jos�', 'Hern�ndez', 'jose.hernandez@email.com', '+1 555-0107-999'),
('Mar�a', 'S�nchez', 'maria.sanchez@email.com', '+1 555-0108-765'),
('Pedro', 'Ram�rez', 'pedro.ramirez@email.com', '+1 555-0109-444'),
('Luc�a', 'Torres', 'lucia.torres@email.com', '+1 555-0110-543'),
('David', 'Flores', 'david.flores@email.com', '+1 555-0111-676'),
('Sof�a', 'Rivera', 'sofia.rivera@email.com', '+1 555-0112-789');

INSERT INTO Comics (titulo, autor, precio, fecha_publicacion) VALUES
('El vigilante', 'Carlos Ruiz', 150, '2020-05-01'),
('Aventuras espaciales', 'Ana M�ndez', 120, '2021-06-15'),
('H�roe urbano', 'Luis Fern�ndez', 200, '2019-08-10'),
('Misterios del futuro', 'Marta L�pez', 180, '2022-01-25'),
('La sombra nocturna', 'Pedro Ram�rez', 220, '2021-11-05'),
('Guardianes de la galaxia', 'Laura Garc�a', 250, '2020-03-20'),
('El �ltimo samur�i', 'Jos� Hern�ndez', 170, '2021-04-18'),
('Los invencibles', 'Mar�a S�nchez', 190, '2020-07-30'),
('Cazadores de monstruos', 'David Flores', 160, '2022-02-14'),
('La leyenda del drag�n', 'Luc�a Torres', 210, '2019-12-05'),
('El enigma del fara�n', 'Sof�a Rivera', 140, '2021-10-22'),
('Los guardianes del tiempo', 'Carlos L�pez', 230, '2020-06-13'),
('Aventuras medievales', 'Ana Mart�nez', 195, '2019-09-17'),
('El reino perdido', 'Luis Gonz�lez', 205, '2022-03-08'),
('Los secretos del universo', 'Fernando D�az', 180, '2023-04-14');

INSERT INTO Inventario (id_comic, cantidad_disponible, precio_venta) VALUES
(1, 5, 150),
(2, 0, 120), -- en Cero 
(3, 10, 200),
(4, 7, 180),
(5, 3, 220),
(6, 12, 250),
(7, 8, 170),
(8, 15, 190),
(9, 0, 134), -- en Cero 
(9, 6, 160),
(10, 4, 210),
(11, 9, 140),
(12, 11, 230),
(13, 5, 195),
(14, 13, 205);

-- Registrar 7 compras de diferentes usuarios
INSERT INTO Compras (id_cliente, fecha_compra, total) VALUES
(1, '2024-05-27', 150),
(2, '2024-05-28', 400),
(3, '2024-05-29', 220),
(4, '2024-05-30', 750),
(5, '2024-05-31', 380),
(6, '2024-06-01', 210),
(7, '2024-06-02', 460);

-- Detalles de las compras
INSERT INTO Comic_Compras (id_compra, id_comic, cantidad) VALUES
(1, 1, 1),
(2, 3, 2),
(3, 5, 1),
(4, 6, 3),
(5, 8, 2),
(6, 10, 1),
(7, 12, 2);

-- Registrar 3 compras de usuarios recurrentes
INSERT INTO Compras (id_cliente, fecha_compra, total) VALUES
(1, '2024-05-29', 120),
(2, '2024-06-01', 360),
(3, '2024-06-03', 170);

-- Detalles de las compras recurrentes
INSERT INTO Comic_Compras (id_compra, id_comic, cantidad) VALUES
(8, 2, 1),
(9, 4, 2),
(10, 7, 1);
