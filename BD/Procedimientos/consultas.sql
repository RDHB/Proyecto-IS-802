select codigoEmpleado, Cargo_idCargo, u.nombreUsuario, u.contrasenia from Usuarios u 
inner join Empleado e on e.idEmpleado = u.Empleado_idEmpleado

select * from Usuarios

-- Consulta SP_LOGIN
declare @codigoMensaje int;
declare @Mensaje varchar(1000);


exec EXTRAER_TABLAS
	'Empleado', 
	'descripcion', 
	'la',
	@codigoMensaje output,
	@Mensaje output
;

select @codigoMensaje;
select @Mensaje;





declare @cEmpleado varchar(50);
declare @pnIdCargo  int;
exec SP_LOGIN
	'Plato', 
	'BHE81RRR3RE', 
	@codigoMensaje output,
	@Mensaje output,
	@cEmpleado output,
	@pnIdCargo output
;

select @codigoMensaje;
select @Mensaje;
select @cEmpleado;
select @pnIdCargo;




















select * from INFORMATION_SCHEMA.TABLES

select * from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'Genero' AND COLUMN_NAME = 'descripcion'
and DATA_TYPE = 'varchar'

select CHARACTER_MAXIMUM_LENGTH from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'Genero' AND COLUMN_NAME = 'descripcion'
and DATA_TYPE = 'vARCHAR'


-- Consultas Genericas
DECLARE @ConsultaSQL NVARCHAR(500);
DECLARE @Tabla NVARCHAR(25);

SET @Tabla = 'Empleado';
SET @ConsultaSQL = 'SELECT * FROM ' + @Tabla + ' WHERE descripcion like ' + char(39) + '%la%' + char(39);

select @ConsultaSQL ;
EXEC(@ConsultaSQL);



select p.idPersona
, CONCAT(p.primerNombre, ' ', p.primerApellido ) AS Nombre
, e.idEmpleado
, e.descripcion
, e.codigoEmpleado
, e.jefeInmediato
, (
	SELECT CONCAT (primerNombre, ' ', segundoNombre, ' ', primerApellido, ' ', segundoApellido) AS NombreCompleto  FROM Persona p2
	inner join Empleado e2 on p2.idPersona = e2.Persona_idPersona
	WHERE e2.idEmpleado = e.jefeInmediato
) as NombreJefeInmediato
, e.AreaTrabajo_idAreaTrabajo
, (
	SELECT descripcion FROM AreaTrabajo at3
	WHERE at3.idAreaTrabajo = e.AreaTrabajo_idAreaTrabajo
) as AreaTrabajo
, e.Cargo_idCargo
, (
	SELECT descripcion FROM Cargo c4
	WHERE c4.idCargo = e.Cargo_idCargo
) as Cargo 
, u.idUsuario
, u.nombreUsuario
, u.contrasenia
, u.Estado_Usuario_idEstado_Usuario 
, (
	SELECT descripcion FROM Estado_Usuario eu5
	WHERE eu5.idEstado_Usuario = u.Estado_Usuario_idEstado_Usuario
) as EstadoUsuario
from Persona p
inner join Empleado e on p.idPersona = e.Persona_idPersona
inner join Usuarios u on u.Empleado_idEmpleado = e.idEmpleado
where u.nombreUsuario = 'Murphy'





-- Como hacer una subconsulta en el select
--Consulta Nombre Empleado
SELECT CONCAT (primerNombre, ' ', segundoNombre, ' ', primerApellido, ' ', segundoApellido) AS NombreCompleto FROM Persona p
inner join Empleado e on e.Persona_idPersona = p.idPersona 
where e.idEmpleado = 1

--Consulta Nombre Cliente
SELECT CONCAT (primerNombre, ' ', segundoNombre, ' ', primerApellido, ' ', segundoApellido) FROM Persona p
inner join Cliente c on c.Persona_idPersona = p.idPersona 
where c.idCliente = 1

--Consulta de Reservaciones
SELECT r.idReservacion
	, r.descripcion
	, r.Empleado_idEmpleado
	, r.Cliente_idCliente 
FROM Reservacion r
inner join Empleado e on e.idEmpleado = r.Empleado_idEmpleado

--SubConsulta en el select
SELECT r.idReservacion
	, r.descripcion
	, ( SELECT CONCAT (primerNombre, ' ', segundoNombre, ' ', primerApellido, ' ', segundoApellido) FROM Persona p
		inner join Empleado e on e.Persona_idPersona = p.idPersona 
		where e.idEmpleado = r.Empleado_idEmpleado
	)
	, (SELECT CONCAT (primerNombre, ' ', segundoNombre, ' ', primerApellido, ' ', segundoApellido) FROM Persona p
		inner join Cliente c on c.Persona_idPersona = p.idPersona 
		where c.idCliente = r.Cliente_idCliente 
	)
FROM Reservacion r
inner join Empleado e on e.idEmpleado = r.Empleado_idEmpleado
-- FIN








-- JSON
DECLARE @json NVarChar(max) = N'{
   "Campo1": valor1,
   "Campo2": "valor2",
}';

SELECT * FROM openjson(@json)
select @@VERSION

ALTER DATABASE database_name SET COMPATIBILITY_LEVEL = 130












declare @ConsultaSQL NVARCHAR(max);
SET @ConsultaSQL = 
	'INSERT INTO Genero (
		idGenero
		, descripcion
	)
	(	SELECT 
			idGenero
			, descripcion
		FROM OPENJSON(@json)
		WITH (
			idGenero int
			, descripcion varchar(max)
		)
	)'
select @ConsultaSQL;

select COUNT(*) from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'Genero'

select top 3 COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'Genero'


















-- Variables para el JSON
DECLARE @json NVarChar(max) = N'{
   "Campo1": valor1,
   "Campo2": "valor2",
}';

-- Variables String para la consulta
declare @vcolumnas varchar(max)
	,@vvariables varchar(max);
declare @ConsultaSQL NVARCHAR(max) = '';

-- Variables CURSOR
declare @colum_name VARCHAR(MAX)
	, @data_type VARCHAR(MAX);
declare @character_len INT;
DECLARE cursor_columns CURSOR
FOR SELECT 
	COLUMN_NAME
	, DATA_TYPE
	, CHARACTER_MAXIMUM_LENGTH
FROM 
	INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'Genero';

-- Abrir cursor
OPEN cursor_columns;



FETCH NEXT FROM cursor_columns INTO @colum_name, @data_type, @character_len;
-- Bucle
WHILE @@FETCH_STATUS = 0
BEGIN
	/* do some work */
    select CONCAT( @colum_name, ', ',@data_type, ', ', CAST(@character_len AS VARCHAR));
    FETCH NEXT FROM cursor_columns INTO
		@colum_name
		, @data_type
		, @character_len;

END;

CLOSE cursor_columns;
DEALLOCATE cursor_columns;