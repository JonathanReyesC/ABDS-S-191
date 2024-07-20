--TSQL

--Declaracion de variables
DECLARE @idCliente int

--Inicializar o asignar un valor a variable
SET @idCliente = 8

--IF

IF @idCliente = 8
	--SELECT * FROM Clientes WHERE id_cliente = @idCliente

DECLARE @edad int
SET @idCliente = 8

IF @idCliente = 8
 BEGIN
	SET @edad = 25
	SELECT * FROM Clientes WHERE id_cliente = @idCliente
	PRINT @edad

	IF EXISTS(SELECT * FROM Clientes WHERE id_cliente = 10)
	print 'Si existe el registro'
 END	
ELSE
 BEGIN
	print 'AVISO: id no autorizado para la consulta'
	print 'Consulte a su administrador en turno'
 END


 
 --WHILE
 DECLARE @contador int = 0

 WHILE @contador <= 10
  BEGIN
	PRINT @contador
	SET @contador = @contador + 1

	IF @contador = 3
		BREAK
	print('Hola')
 END
 print ('aqui continua el flujo')
 
 BEGIN TRY
	 set @contador = 'Diego'
 END TRY
 BEGIN CATCH
	print ('La variable contador solo acepta enteros')
 END CATCH

	print ('soy otra consulta')
	print('yo tambien')



--CASE

DECLARE @valor int
DECLARE @resultado char(10)=''
SET @valor = 30

SET @resultado = (CASE WHEN @valor = 10 THEN 'ROJO'
					WHEN @valor = 20 THEN 'MORADO'
					 WHEN @valor = 30 THEN 'AMARILLO'
					ELSE 'AZUL'
					END)
PRINT @resultado

select * ,(CASE WHEN disponibilidad = 'Disponible' THEN 'VERDE'
				WHEN disponibilidad = 'Agotado' THEN 'ROJO' 
				ELSE 'NEGRO' END) AS INDICADOR 
				FROM Inventario