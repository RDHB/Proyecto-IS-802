-- LLamar al procedimiento almacenado: RH_ENTREVISTA_TRABAJO
SELECT * FROM Persona
SELECT * FROM Telefono
SELECT * FROM Aspirante
select * from Curriculum

DELETE FROM Curriculum WHERE idCurriculum = 11;
DELETE FROM Aspirante WHERE Persona_idPersona = 61;
DELETE FROM Telefono WHERE Persona_idPersona = 61;
DELETE FROM Persona WHERE idPersona = 61;


DECLARE
	@pnumeroIdentidad			VARCHAR(45) = '16020124 3501',
	@pprimerNombre				VARCHAR(45) = 'Luis',
	@psegundoNombre				VARCHAR(45) = 'Fletcher',
	@pprimerApellido			VARCHAR(45) = 'Matinez',
	@psegundoApellido			VARCHAR(45) = 'Howard',
	@prcorreoElectronico		VARCHAR(45) = 'luisfer@gmail.com',
	@prdireccion				VARCHAR(45) = 'Barreo Caba�as',
	@prnumeroTelefono			VARCHAR(45) = '9798-2221',
	@pridGenero					INT = 1,
	@prdescripcion				VARCHAR(45) = 'Area Ventas',
	@pFecha						DATE = '2018-04-18',
    @paccion					VARCHAR(45) = 'INSERT',

	@prcodigoMensaje INT = 0,
	@prmensaje VARCHAR(45) = '',
	@prNombreArchivo VARCHAR(45) = ''
;


EXEC RH_ENTREVISTA_TRABAJO
	-- INTPUT
	@pnumeroIdentidad,
	@pprimerNombre,
	@psegundoNombre,
	@pprimerApellido,
	@psegundoApellido,
	@prcorreoElectronico,
	@prdireccion,
	@prnumeroTelefono,
	@pridGenero,
	@prdescripcion,
	@pFecha,
    @paccion,
	
	-- OUTPUT
	@prcodigoMensaje OUTPUT,
	@prmensaje OUTPUT,
	@prNombreArchivo OUTPUT
;

-- OUTPUT
SELECT @prcodigoMensaje;
SELECT @prmensaje;
SELECT @prNombreArchivo;









-- LLamar al procedimiento almacenado: RH_ENTREVISTA_TRABAJO
SELECT * FROM Persona
SELECT * FROM Empleado
select * from ContratoPersonal
SELECT * FROM Historico_Contratos

delete from Empleado where idEmpleado = 21;
delete from ContratoPersonal where idContratoPersonal = 11;
delete from Historico_Contratos where idHistorico_Contratos  = 11;
DECLARE
	@prnumeroIdentidad			VARCHAR(45) = '16020124 3508',
	@prsueldo					DECIMAL = 1123,
	@prhoraInicio				TIME = '08:00:00.0000000',
	@prhoraFin					TIME = '16:00:00.0000000',
	@pridTipoContrato			INT = 1,
	@pridAreaTrabajo			INT = 1,
	@pridCargo					INT = 1,
    @paccion					VARCHAR(45) = 'INSERT',

	@prcodigoMensaje INT = 0,
	@prmensaje VARCHAR(1000) = '',
	@pcodigoEmpleado VARCHAR(45) = ''
;


EXEC RH_CONTRATOS
	-- INTPUT
	@prnumeroIdentidad,
	@prsueldo,
	@prhoraInicio,
	@prhoraFin,
	@pridTipoContrato,
	@pridAreaTrabajo,
	@pridCargo,
	@paccion,
	
	-- OUTPUT
	@prcodigoMensaje OUTPUT,
	@prmensaje OUTPUT,
	@pcodigoEmpleado OUTPUT
;

-- OUTPUT
SELECT @prcodigoMensaje;
SELECT @prmensaje;
SELECT @pcodigoEmpleado;













-- LLamar al procedimiento almacenado: RH_HUELLA
SELECT * FROM Empleado
select e.codigoEmpleado, h.descripcion, h.fecha, h.horaEntrada, h.horaSalida from Huella h 
inner join Empleado e on e.idEmpleado = h.idHuella

-- delete from Huella where idHuella = 12;

DECLARE
	@prcodigoEmpleado				VARCHAR(45)	= 'EMP0001'	,
	@prdescripcion					VARCHAR(45)	= 'ADIOS'	,
	@prhoraEntrada					TIME		= '08:00:00.0000000'	,
	@prhoraSalida					TIME		= '16:25:34.0000000'	,
	@prfecha						DATE		= '2020-01-14'	,
    @praccion						VARCHAR(45)	= 'SELECT-HUELLA'	,
    
	@prcodigoMensaje INT = 0,
	@prmensaje VARCHAR(1000) = '',
	@prCargo VARCHAR(45) = '',
	@prAreaTrabajo VARCHAR(45) = ''
;


EXEC RH_HUELLA
	-- INTPUT
	@prcodigoEmpleado,
	@prdescripcion OUTPUT,
	@prhoraEntrada OUTPUT,
	@prhoraSalida OUTPUT,
	@prfecha,
	@praccion,
	-- OUTPUT
	@prcodigoMensaje OUTPUT,
	@prmensaje OUTPUT,
	@prCargo OUTPUT,
	@prAreaTrabajo OUTPUT
;

-- OUTPUT
SELECT @prcodigoMensaje;
SELECT @prmensaje;
SELECT @prCargo;
SELECT @prAreaTrabajo;
SELECT @prdescripcion;
SELECT @prhoraEntrada;
SELECT @prhoraSalida;

select e.codigoEmpleado, h.descripcion, h.fecha, h.horaEntrada, h.horaSalida from Huella h 
inner join Empleado e on e.idEmpleado = h.Empleado_idEmpleado

IF getdate() BETWEEN DATEADD(DAY, 1, GETDATE()) AND DATEADD(MONTH, 1,GETDATE()) BEGIN
	select 'Hola'
END;















-- LLamar al procedimiento almacenado: RH_HORAS_EXTRAS
SELECT * FROM Horas_extras
SELECT * FROM Historico_HE
select art.descripcion, he.idHoras_extras, he.fecha, he.horaInicio, he.horaFin from Horas_extras he
inner join Historico_HE hhe on hhe.Horas_extras_idHoras_extras = he.idHoras_extras
inner join AreaTrabajo art on art.idAreaTrabajo = hhe.AreaTrabajo_idAreaTrabajo
order by art.idAreaTrabajo

/*
delete from Historico_HE
WHERE idHistorico_HE = 11

delete from Horas_extras
WHERE idHoras_extras = 11
*/

DECLARE
	@pridAreaTrabajo				INT			= 3,
	@prhoraInicio					TIME		= '16:00:00.0000000'	,
	@prhoraFIn						TIME		= '20:00:00.0000000'	,
	@prfecha						DATE		= '2020-04-24'	,
    @praccion						VARCHAR(45)	= 'INSERT'	,
    
	@prcodigoMensaje				INT = 0,
	@prmensaje						VARCHAR(1000) = ''
;


EXEC RH_HORAS_EXTRAS
	-- INTPUT
	@pridAreaTrabajo,
	@prhoraInicio OUTPUT,
	@prhoraFin OUTPUT,
	@prfecha,
	@praccion,
	-- OUTPUT
	@prcodigoMensaje OUTPUT,
	@prmensaje OUTPUT
;

-- OUTPUT
SELECT @prcodigoMensaje;
SELECT @prmensaje;
SELECT @prhoraInicio;
SELECT @prhoraFin;

select art.descripcion, he.idHoras_extras, he.fecha, he.horaInicio, he.horaFin from Horas_extras he
inner join Historico_HE hhe on hhe.Horas_extras_idHoras_extras = he.idHoras_extras
inner join AreaTrabajo art on art.idAreaTrabajo = hhe.AreaTrabajo_idAreaTrabajo
order by art.idAreaTrabajo















-- LLamar al procedimiento almacenado: RH_ROL_PAGO
SELECT * FROM RolPago

SELECT codigoEmpleado
	, (SELECT descripcion FROM AreaTrabajo WHERE idAreaTrabajo = E.AreaTrabajo_idAreaTrabajo) AS 'Area de Trabajo'
	, cargo
	, fecha
	, sueldoBase
	, cantidadHE
	, pagoHE
	, comisiones
	, deducciones
	, totalPago
FROM RolPago RP
INNER JOIN Empleado E ON E.idEmpleado = RP.Empleado_idEmpleado

DECLARE
	@prcodigoEmpleado				VARCHAR(45)	= 'EMP0001'	,
	@prpagoHE						DECIMAL(18,4) = 0,
	@prcomisiones					DECIMAL(18,4) = 0,
	@prdeducciones					DECIMAL(18,4) = 0,
    @praccion						VARCHAR(45) = 'SELECT',
    
	@prcodigoMensaje INT = 0,
	@prmensaje VARCHAR(1000) = ''
;


EXEC RH_ROL_PAGO
	-- INTPUT
	@prcodigoEmpleado,
	@prpagoHE,
	@prcomisiones,
	@prdeducciones,
	@praccion,

	-- OUTPUT
	@prcodigoMensaje OUTPUT,
	@prmensaje OUTPUT
;


