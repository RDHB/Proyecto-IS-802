select codigoEmpleado, Cargo_idCargo, u.nombreUsuario, u.contrasenia from Usuarios u 
inner join Empleado e on e.idEmpleado = u.Empleado_idEmpleado;

select * from Usuarios;

-- Consulta SP_LOGIN
declare @codigoMensaje int;
declare @Mensaje varchar(1000);
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



















-- Consultas a la informacion de la base de datos
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























-- Trabajar con un JSON
-- Variables de Parametros
declare
@pNombreTabla						VARCHAR(250) = 'Genero',
@pNombreCampo						VARCHAR(250),
@pFiltroCampo						VARCHAR(250),
@pAccion                            VARCHAR(45),
@pjson								NVarChar(max)
;

-- Variables para el JSON
SET @pjson = N'{
   "idGenero": 3,
   "descripcion": "Otro"
}';

-- Variables String para la consulta
declare @vcolumnas varchar(max) = ''
	,@vvariables varchar(max) = '';
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
where TABLE_NAME = @pNombreTabla;

-- Abrir cursor
OPEN cursor_columns;

-- Se prepara el cursor
FETCH NEXT FROM cursor_columns INTO @colum_name, @data_type, @character_len;

-- Bucle
WHILE @@FETCH_STATUS = 0
BEGIN
	-- Guardando los nombres de los campos de la tabla
	SET @vcolumnas = @vcolumnas + @colum_name;
	IF @data_type = 'varchar' BEGIN
		SET @vvariables = @vvariables + @colum_name + ' ' + @data_type + '(' + CAST(@character_len AS VARCHAR) + ')';
	END ELSE BEGIN
		SET @vvariables = @vvariables + @colum_name + ' ' + @data_type;
	END;

    -- Obteniendo columna por columna de la tabla por registro
    FETCH NEXT FROM cursor_columns INTO
		@colum_name
		, @data_type
		, @character_len
	;

	-- Identifica si habra otra vuelta del ciclo para agregar otra columna
	IF @@FETCH_STATUS = 0 BEGIN
		SET @vcolumnas = @vcolumnas + ', '
		SET @vvariables = @vvariables + ', '
	END;
END;

-- Se construye la consulta INSERT a partir de los nombres de las columnas
SET @ConsultaSQL = 'INSERT INTO ' + @pNombreTabla + ' ( '
	+ @vcolumnas
	+ ' ) (SELECT '
	+ @vcolumnas
	+ ' FROM OPENJSON(' + CHAR(39) + @pjson + CHAR(39) + ') WITH ( '
	+ @vvariables
	+ ' ))'
;

-- Se ejecuta la consulta
SELECT @ConsultaSQL;
--EXEC @ConsultaSQL;

-- Se cierra el cursor
CLOSE cursor_columns;
DEALLOCATE cursor_columns;

select * from OPENJSON('{     "idGenero": 3,     "descripcion": "otro"  }')
delete from Genero where idGenero = 3;
INSERT INTO Genero ( idGenero, descripcion ) (SELECT idGenero, descripcion FROM OPENJSON('{     "idGenero": 3,     "descripcion": "Otro"  }') WITH ( idGenero int, descripcion varchar(45) ))

select idGenero as Genero from Genero;



















-- Conocer los nombres de los campos de un JSON
declare @pruebajson varchar(max)
	, @columnas varchar(45)
	, @colum_name_json varchar(45)
;
declare @tmpTabla TABLE (columna varchar(45));
SET @pruebajson = N'{
	"idGenero": 3,
	"descripcion": "Otro"
}';

insert into @tmpTabla 
select x.[key] from OPENJSON(@pruebajson, '$') AS x;
select * from @tmpTabla

DECLARE cursor_columns_json CURSOR
FOR SELECT columna FROM @tmpTabla

OPEN cursor_columns_json;

FETCH NEXT FROM cursor_columns_json INTO @colum_name_json;

WHILE @@FETCH_STATUS = 0
BEGIN
	if @colum_name_json = 'idGenero' begin
		select 'funciona'
	end

	FETCH NEXT FROM cursor_columns_json INTO @colum_name_json;
END;

CLOSE cursor_columns_json;
DEALLOCATE cursor_columns_json;





















-- LLamar al procedimiento almacenado: GENERIC_GESTION_TABLAS
select * from Genero;
delete from Genero where idGenero = 3;

DECLARE
	@prNombreTabla		VARCHAR(250),
	@prNombreCampo		VARCHAR(250),
	@prFiltroCampo		VARCHAR(250),
	@prjson				NVarChar(MAX),
	@prAccion			VARCHAR(45),
	@prcodigoMensaje	INT,
	@prmensaje			VARCHAR(1000);

SET @prNombreTabla = 'Genero';
SET	@prNombreCampo = '';
SET	@prFiltroCampo = '';
SET @prjson = N'{
	"idGenero": 3,
	"descripcion": "Otro"
}';
SET @prAccion = 'INSERTAR';
SET @prcodigoMensaje = 0;
SET @prmensaje = '';

EXEC GENERIC_GESTION_TABLAS
	-- INTPUT
	@prNombreTabla,
	@prNombreCampo,
	@prFiltroCampo,
    @prjson,
    @prAccion,
	
	-- OUTPUT
	@prcodigoMensaje OUTPUT,
	@prmensaje OUTPUT;
;

-- OUTPUT
SELECT @prcodigoMensaje;
SELECT @prmensaje;
