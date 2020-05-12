select codigoEmpleado, Cargo_idCargo, u.nombreUsuario, u.contrasenia from Usuarios u 
inner join Empleado e on e.idEmpleado = u.Empleado_idEmpleado;

select * from Usuarios;
select dbo.FN_ENCRIPTAR('ResplandorFinal');
-- LLamar al procedimiento almacenado: GU_LOGIN
declare @codigoMensaje int;
declare @Mensaje varchar(1000);
declare @cEmpleado varchar(50);
declare @pnIdCargo  int;
exec GU_LOGIN
	'LuisFer15', 
	'Extremo15', 
	@codigoMensaje output,
	@Mensaje output,
	@cEmpleado output,
	@pnIdCargo output
;

select @codigoMensaje;
select @Mensaje;
select @cEmpleado;
select @pnIdCargo;






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
	@prmensaje			VARCHAR(1000)
;
SET @prNombreTabla = 'Promociones';
SET	@prNombreCampo = '';
SET	@prFiltroCampo = '';
SET @prjson = N'{
	"idPromociones": 4,
	"descripcion": "Prueba",
	"fechaInicio": "2020-01-04",
	"fechaFin": "2020-02-04"
}';
SET @prAccion = 'DELETE';
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

select * from Promociones;











-- LLamar al procedimiento almacenado: GU_GESTION_USUARIOS
select * from Telefono;

DECLARE
	@pridUsuario					INT,
	@prcodigoEmpleado			VARCHAR(45),
	@prnombreUsuario				VARCHAR(45),
	@prcontrasenia				VARCHAR(45),
	
	@prcorreoElectronico			VARCHAR(45),
	@prtelefono					VARCHAR(45),

	@prnombrePersona				VARCHAR(45),
	@pridEstadoUsuario			INT,
	@pridAreaTrabajo				INT,

	@prAccion					VARCHAR(45),
	
	-- Parametros de Salida
    -- Codigo de mensaje
	@prcodigoMensaje				INT ,
	@prmensaje 					VARCHAR(1000) 

;
SET @pridUsuario = 1
SET @prcodigoEmpleado = ''
SET	@prnombreUsuario = 'LuisFer15';
SET	@prContrasenia = '';

SET @prcorreoElectronico = 'luisfer.game15@gmail.com'
SET @prtelefono = '+504 9798-2221'

SET @prnombrePersona = ''
SET @pridEstadoUsuario = 0
SET @pridAreaTrabajo = 0

SET @prAccion = 'UPDATE';

SET @prcodigoMensaje = 0;
SET @prmensaje = '';

EXEC GU_GESTION_USUARIOS
	-- INTPUT
	@pridUsuario,
	@prcodigoEmpleado,
	@prnombreUsuario,
	@prContrasenia,

	@prcorreoElectronico,
	@prtelefono,

	@prnombrePersona,
	@pridEstadoUsuario,
	@pridAreaTrabajo,

    @prAccion,
	
	-- OUTPUT
	@prcodigoMensaje OUTPUT,
	@prmensaje OUTPUT;
;

-- OUTPUT
SELECT @prcodigoMensaje;
SELECT @prmensaje;

delete from Usuarios where idUsuario = 20
select * from Usuarios u 
inner join Empleado e on u.Empleado_idEmpleado = e.idEmpleado;




















-- LLamar al procedimiento almacenado: GU_CONFIG
-- select * from Telefono

DECLARE
	-- Parametros de Entrada
	-- ID
	@pnombreUsuario				VARCHAR(45),
	
	-- UPDATE
	@pnewContrasenia			VARCHAR(45),
	@pnewNombreUsuario			VARCHAR(45),
	@pnewCorreoElectronico		VARCHAR(45),
	@pnewDireccion				VARCHAR(45),
	@pextensionArchivo			VARCHAR(45),

	-- ADD
	@pnewTelefono				VARCHAR(45),

	-- ID DELETE
	@pidTelefono				INT,

    @paccion					VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje				INT,
	@pmensaje 					VARCHAR(1000),

    -- Otros parametros de salida
	@pnombreArchivo				VARCHAR(45)
;

SET @pnombreUsuario = 'LuisFer15';

SET @pnewContrasenia = '';
SET	@pnewNombreUsuario = '';
SET	@pnewCorreoElectronico = '';
SET	@pnewDireccion = '';
SET	@pextensionArchivo = '';

SET @pnewTelefono = '+504 32550664';

SET @pidTelefono = 0;


SET @pAccion = 'ADD-TELEFONO';

SET @pcodigoMensaje = 0;
SET @pmensaje = '';
SET	@pnombreArchivo = '';

EXEC GU_CONFIG
	-- INTPUT
	@pnombreUsuario,

	@pnewContrasenia,
	@pnewNombreUsuario,
	@pnewCorreoElectronico,
	@pnewDireccion,
	@pextensionArchivo,

	@pnewTelefono,

	@pidTelefono,

    @pAccion,
	
	-- OUTPUT
	@pcodigoMensaje OUTPUT,
	@pmensaje OUTPUT,
	@pnombreArchivo OUTPUT
;

-- OUTPUT
SELECT @pcodigoMensaje;
SELECT @pmensaje;
SELECT @pnombreArchivo;

/*
select * from telefono T
INNER JOIN Persona P ON P.idPersona = T.Persona_idPersona
WHERE P.idPersona = 11
*/

















-- LLamar al procedimiento almacenado: GU_REINICIO_CONTRASENIA
-- select * from Usuarios
DECLARE
	-- Parametros de Entrada
	-- ID
	@pnombreUsuario				VARCHAR(45),

    @paccion					VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje				INT,
	@pmensaje 					VARCHAR(1000),

    -- Otros parametros de salida
	@presetContrasenia			VARCHAR(45)
;

SET @pnombreUsuario = 'LuisFer15';


SET @pAccion = 'RESET';

SET @pcodigoMensaje = 0;
SET @pmensaje = '';
SET @presetContrasenia = '';

EXEC GU_REINICIO_CONTRASENIA
	-- INTPUT
	@pnombreUsuario,

    @pAccion,
	
	-- OUTPUT
	@pcodigoMensaje OUTPUT,
	@pmensaje OUTPUT,
	@presetContrasenia OUTPUT
;

-- OUTPUT
SELECT @pcodigoMensaje;
SELECT @pmensaje;
SELECT @presetContrasenia;


















-- LLamar al procedimiento almacenado: VE_GESTION_CLIENTES
select * from Persona p
inner join Cliente c on c.Persona_idPersona = p.idPersona;

DECLARE
	@prprimerNombre 					VARCHAR(45) = 'Luis',
	@prsegundoNombre					VARCHAR(45) = 'Fernando',
	@prprimerapellido					VARCHAR(45) = 'Solano',
	@prsegundoapellido					VARCHAR(45) = 'Martinez',
	@prcorreoElectronico				VARCHAR(45) = 'luisfer.sm15@gmail.com',
	@prdireccion						VARCHAR(45) = '21 de Febrero',
	@prnumeroIdentidad					VARCHAR(45) = '1804-1998-00221',
	@pridGenero							INT = 5,
	@prnumeroTelefono					VARCHAR(45) = '9798-2221',
    @praccion							VARCHAR(45) = 'INSERT',

	@prcodigoMensaje				INT = 0,
	@prmensaje						VARCHAR(1000) = ''
;


EXEC VE_GESTION_CLIENTES
	-- INTPUT
	@prprimerNombre,
	@prsegundoNombre,
	@prprimerapellido,
	@prsegundoapellido,
	@prcorreoElectronico,
	@prdireccion,
	@prnumeroIdentidad,
	@pridGenero,
	@prnumeroTelefono,
    @praccion,
	
	-- OUTPUT
	@prcodigoMensaje OUTPUT,
	@prmensaje OUTPUT;
;

-- OUTPUT
SELECT @prcodigoMensaje;
SELECT @prmensaje;


SELECT * FROM Cliente C INNER JOIN Persona P ON P.idPersona = C.Persona_idPersona
















-- LLamar al procedimiento almacenado: VE_GESTION_VEHICULOS
SELECT * FROM Vehiculos

DECLARE
	@pvin	 							VARCHAR(45) = '1PCH23DF56GHJ3DF34A',
	@pcolor								VARCHAR(45) = 'Plateado',
	@pplaca								VARCHAR(45) = 'PCH-2345',
	@pnumeroMotor						VARCHAR(45) = 'R134J4768341',
	@pcaja_de_cambios					VARCHAR(45) = 'Automatico',
	@pidModelo							INT = 1,
    @paccion							VARCHAR(45) = 'INSERT',

	@prcodigoMensaje				INT = 0,
	@prmensaje						VARCHAR(1000) = ''
;


EXEC VE_GESTION_VEHICULOS
	-- INTPUT
	@pvin,
	@pcolor,
	@pplaca,
	@pnumeroMotor,
	@pcaja_de_cambios,
	@pidModelo,
    @paccion,
	
	-- OUTPUT
	@prcodigoMensaje OUTPUT,
	@prmensaje OUTPUT;
;

-- OUTPUT
SELECT @prcodigoMensaje;
SELECT @prmensaje;


SELECT * FROM Vehiculos
















-- LLamar al procedimiento almacenado: VE_ASOCIAR_CYV
SELECT * FROM VinculoCyV
SELECT * FROM Vehiculos
select * from Persona p
inner join Cliente c on c.Persona_idPersona = p.idPersona;

DECLARE
	@pvin						VARCHAR(45) = '1PCH23DF56GHJ3DF341', -- 1PCH23DF56GHJ3DF341
	@pnumeroIdentidad			VARCHAR(45) = '1804-1998-00220', -- 1804-1998-00220
    @paccion					VARCHAR(45) = 'UNLINK',

	@prcodigoMensaje				INT = 0,
	@prmensaje						VARCHAR(1000) = ''
;


EXEC VE_ASOCIAR_CYV
	-- INTPUT
	@pvin,
	@pnumeroIdentidad,
    @paccion,
	
	-- OUTPUT
	@prcodigoMensaje OUTPUT,
	@prmensaje OUTPUT;
;

-- OUTPUT
SELECT @prcodigoMensaje;
SELECT @prmensaje;


SELECT 
	V.vin
	, ( -- descripcion Marca
		SELECT descripcion FROM Marca Ma
		WHERE Ma.idMarca = ( -- idMarca
			SELECT Mo.Marca_idMarca FROM Modelo Mo
			WHERE Mo.idModelo = V.Modelo_idModelo
		)
	)
	, ( -- descripcion Modelo
		SELECT descripcion FROM Modelo Mo2
		WHERE Mo2.idModelo = V.Modelo_idModelo
	)
	, ( -- numeroIdentidad
		SELECT P.numeroIdentidad FROM Persona P
		INNER JOIN Cliente C2 ON C2.Persona_idPersona = P.idPersona
		WHERE C2.idCliente = VCV.Cliente_idCliente
	)
	,( -- NombreCompleto
		SELECT CONCAT(
			P2.primerNombre
			, P2.segundoNombre
			, P2.primerApellido
			, P2.segundoApellido
		) AS NombreCompleto
		FROM Persona P2
		INNER JOIN Cliente C2 ON C2.Persona_idPersona = P2.idPersona
		WHERE C2.idCliente = VCV.Cliente_idCliente
	)
FROM VinculoCyV VCV
INNER JOIN Cliente C ON C.idCliente = VCV.Cliente_idCliente
INNER JOIN Vehiculos V ON V.idVehiculos = VCV.Vehiculos_idVehiculos


SELECT COUNT(*) FROM VinculoCyV
		WHERE Vehiculos_idVehiculos = (
			SELECT idVehiculos 
			FROM Vehiculos
			WHERE vin = '1PCH23DF56GHJ3DF341'
		)
		AND Cliente_idCliente = (
			SELECT C.idCliente FROM Cliente C
			INNER JOIN Persona P ON P.idPersona = C.Persona_idPersona
			WHERE P.numeroIdentidad = '1804-1998-00220'
		)
;
