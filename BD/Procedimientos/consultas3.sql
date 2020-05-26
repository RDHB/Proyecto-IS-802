-- LLamar al procedimiento almacenado: OT-A_GENERAR_OT
select * from Vehiculos

DECLARE
	-- Parametros de Entrada
	@pvin						VARCHAR(45),
	@pnumeroIdentidad			VARCHAR(45),
    @paccion					VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje				INT,
	@pmensaje 					VARCHAR(1000),

    -- Otros parametros de salida
	@pnumeroOT					VARCHAR(45)
;

SET @pvin = '1PCH23DF56GHJ3DF34P';
SET @pnumeroIdentidad = '1690-0325-91448';

SET @pAccion = 'INSERT';

SET @pcodigoMensaje = 0;
SET @pmensaje = '';
SET @pnumeroOT = '';


EXEC OT_A_GENERAR_OT
	-- INTPUT
	@pvin,
	@pnumeroIdentidad,
	
	@pAccion,
	
	-- OUTPUT
	@pcodigoMensaje OUTPUT,
	@pmensaje OUTPUT,
	@pnumeroOT OUTPUT
;

-- OUTPUT
SELECT @pcodigoMensaje;
SELECT @pmensaje;
SELECT @pnumeroOT;
/*
select * from OrdenTrabajo
where numeroOT = 'OT0000011'

DELETE from OrdenTrabajo
where numeroOT = 'OT0000011'
*/





















-- LLamar al procedimiento almacenado: OT_A_REVISION_VEHICULO
select * from OrdenTrabajo

DECLARE
	-- Parametros de Entrada
	@pnumeroOT						VARCHAR(45),
	@pestado_del_vehiculo			VARCHAR(1000),
	@pobjetosPersonales				VARCHAR(1000),
    @paccion						VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje					INT,
	@pmensaje 						VARCHAR(1000)

    -- Otros parametros de salida

;

SET @pnumeroOT = 'OT0000011';
SET @pestado_del_vehiculo = '	Vehiculo hecho mierda';
SET @pobjetosPersonales = 'ninguno';

SET @paccion = 'UPDATE';

SET @pcodigoMensaje = 0;
SET @pmensaje = '';


EXEC OT_A_REVISION_VEHICULO
	-- INTPUT
	@pnumeroOT,
	@pestado_del_vehiculo,
	@pobjetosPersonales,
	
	@paccion,
	
	-- OUTPUT
	@pcodigoMensaje OUTPUT,
	@pmensaje OUTPUT
;

-- OUTPUT
SELECT @pcodigoMensaje;
SELECT @pmensaje;





















-- LLamar al procedimiento almacenado: OT_A_CONTRATAR_SERVICIOS
select * from Lista_Servicios
select * from OrdenTrabajo

DECLARE
	-- Parametros de Entrada
	@pnumeroOT						VARCHAR(45),
	@pidServicios					INT,
    @paccion						VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje					INT,
	@pmensaje 						VARCHAR(1000)

    -- Otros parametros de salida

;

SET @pnumeroOT = 'OT0000011';
SET @pidServicios = 0;

SET @paccion = 'SELECT';

SET @pcodigoMensaje = 0;
SET @pmensaje = '';


EXEC OT_A_CONTRATAR_SERVICIOS
	-- INTPUT
	@pnumeroOT,
	@pidServicios,
	
	@paccion,
	
	-- OUTPUT
	@pcodigoMensaje OUTPUT,
	@pmensaje OUTPUT
;

-- OUTPUT
SELECT @pcodigoMensaje;
SELECT @pmensaje;





















-- LLamar al procedimiento almacenado: OT_A_COTIZACION
select * from Lista_Cotizacion

DECLARE
	-- Parametros de Entrada
	@pnumeroOT						VARCHAR(45),
	@pidProductos					INT,
	@pcantidad						INT,
    @paccion						VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje					INT,
	@pmensaje 						VARCHAR(1000)

    -- Otros parametros de salida

;

SET @pnumeroOT = 'OT0000011';
SET @pidProductos = 0;
SET @pcantidad = 0;

SET @paccion = 'SAVE';

SET @pcodigoMensaje = 0;
SET @pmensaje = '';


EXEC OT_A_COTIZACION
	-- INTPUT
	@pnumeroOT,
	@pidProductos,
	@pcantidad,
	
	@paccion,
	
	-- OUTPUT
	@pcodigoMensaje OUTPUT,
	@pmensaje OUTPUT
;

-- OUTPUT
SELECT @pcodigoMensaje;
SELECT @pmensaje;





















-- LLamar al procedimiento almacenado: OT_A_APROVACION_COTIZACION
select * from Lista_Servicios
select * from Lista_Cotizacion
select * from OrdenTrabajo

DECLARE
	-- Parametros de Entrada
	@pnumeroOT						VARCHAR(45),
    @paccion						VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje					INT,
	@pmensaje 						VARCHAR(1000)

    -- Otros parametros de salida

;

SET @pnumeroOT = 'OT0000011';
SET @paccion = 'SAVE';

SET @pcodigoMensaje = 0;
SET @pmensaje = '';


EXEC OT_A_APROVACION_COTIZACION
	-- INTPUT
	@pnumeroOT,
	@paccion,
	
	-- OUTPUT
	@pcodigoMensaje OUTPUT,
	@pmensaje OUTPUT
;

-- OUTPUT
SELECT @pcodigoMensaje;
SELECT @pmensaje;























-- LLamar al procedimiento almacenado: OT_J_APROVACION_COTIZACION
select * from Lista_Servicios
select * from Lista_Cotizacion
select numeroOT, EstadoOT_idEstadoOT from OrdenTrabajo

DECLARE
	-- Parametros de Entrada
	@pnumeroOT						VARCHAR(45),
    @paccion						VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje					INT,
	@pmensaje 						VARCHAR(1000)

    -- Otros parametros de salida

;

SET @pnumeroOT = 'OT0000011';
SET @paccion = 'SAVE';

SET @pcodigoMensaje = 0;
SET @pmensaje = '';


EXEC OT_J_APROVACION_COTIZACION
	-- INTPUT
	@pnumeroOT,
	@paccion,
	
	-- OUTPUT
	@pcodigoMensaje OUTPUT,
	@pmensaje OUTPUT
;

-- OUTPUT
SELECT @pcodigoMensaje;
SELECT @pmensaje;























-- LLamar al procedimiento almacenado: OT_A_GENERAR_LISTA
select * from Lista_MyR;
select numeroOT, EstadoOT_idEstadoOT from OrdenTrabajo;



DECLARE
	-- Parametros de Entrada
	@pnumeroOT						VARCHAR(45),
	@pidProducto				INT,
	@pcantidad					INT,
    @paccion						VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje					INT,
	@pmensaje 						VARCHAR(1000)

    -- Otros parametros de salida

;

SET @pnumeroOT = 'OT0000011';
SET @pidProducto = 0;
SET @pcantidad = 0;
SET @paccion = 'SAVE';

SET @pcodigoMensaje = 0;
SET @pmensaje = '';


EXEC OT_A_GENERAR_LISTA
	-- INTPUT
	@pnumeroOT,
	@pidProducto,
	@pcantidad,
	@paccion,
	
	-- OUTPUT
	@pcodigoMensaje OUTPUT,
	@pmensaje OUTPUT
;

-- OUTPUT
SELECT @pcodigoMensaje;
SELECT @pmensaje;


SELECT 
	OT.numeroOT
	, OT.EstadoOT_idEstadoOT AS 'estadoOT'
	, LMR.Producto_idProducto AS 'idProducto'
	, P.nombre
	, LMR.cantidad
	, P.precioVenta
	, (LMR.cantidad * P.precioVenta) AS 'subTotal'
FROM Lista_MyR LMR
INNER JOIN OrdenTrabajo OT ON OT.idOrdenTrabajo = LMR.OrdenTrabajo_idOrdenTrabajo
INNER JOIN Producto P ON P.idProducto = LMR.Producto_idProducto
WHERE OT.numeroOT = 'OT0000011'























-- LLamar al procedimiento almacenado: OT_J_APROVACION_LISTA
select * from Lista_MyR
select numeroOT, EstadoOT_idEstadoOT from OrdenTrabajo


DECLARE
	-- Parametros de Entrada
	@pnumeroOT						VARCHAR(45),
    @paccion						VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje					INT,
	@pmensaje 						VARCHAR(1000)

    -- Otros parametros de salida

;

SET @pnumeroOT = 'OT0000011';
SET @paccion = 'SAVE';

SET @pcodigoMensaje = 0;
SET @pmensaje = '';


EXEC OT_J_APROVACION_LISTA
	-- INTPUT
	@pnumeroOT,
	@paccion,
	
	-- OUTPUT
	@pcodigoMensaje OUTPUT,
	@pmensaje OUTPUT
;

-- OUTPUT
SELECT @pcodigoMensaje;
SELECT @pmensaje;























-- LLamar al procedimiento almacenado: OT_E_REBAJAR_INVENTARIO
select * from Lista_MyR
select numeroOT, EstadoOT_idEstadoOT from OrdenTrabajo


DECLARE
	-- Parametros de Entrada
	@pnumeroOT						VARCHAR(45),
    @paccion						VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje					INT,
	@pmensaje 						VARCHAR(1000)

    -- Otros parametros de salida

;

SET @pnumeroOT = 'OT0000011';
SET @paccion = 'SAVE';

SET @pcodigoMensaje = 0;
SET @pmensaje = '';


EXEC OT_E_REBAJAR_INVENTARIO
	-- INTPUT
	@pnumeroOT,
	@paccion,
	
	-- OUTPUT
	@pcodigoMensaje OUTPUT,
	@pmensaje OUTPUT
;

-- OUTPUT
SELECT @pcodigoMensaje;
SELECT @pmensaje;























-- LLamar al procedimiento almacenado: OT_T_FINALIZAR_MANTENIMIENTO
select * from Lista_MyR
select * from OrdenTrabajo


DECLARE
	-- Parametros de Entrada
	@pnumeroOT						VARCHAR(45),
	@preparacionesEfectuadas		VARCHAR(45),
	@preparacionesNoEfectuadas		VARCHAR(45),
    @paccion						VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje					INT,
	@pmensaje 						VARCHAR(1000)

    -- Otros parametros de salida

;

SET @pnumeroOT = 'OT0000011';
SET @preparacionesEfectuadas = 'Se realizaron todas las reparaciones';
SET @preparacionesNoEfectuadas = '';
SET @paccion = 'SAVE';

SET @pcodigoMensaje = 0;
SET @pmensaje = '';


EXEC OT_T_FINALIZAR_MANTENIMIENTO
	-- INTPUT
	@pnumeroOT,
	@preparacionesEfectuadas,
	@preparacionesNoEfectuadas,
	@paccion,
	
	-- OUTPUT
	@pcodigoMensaje OUTPUT,
	@pmensaje OUTPUT
;

-- OUTPUT
SELECT @pcodigoMensaje;
SELECT @pmensaje;























-- LLamar al procedimiento almacenado: OT_J_CONTROL_CALIDAD
select * from OrdenTrabajo


DECLARE
	-- Parametros de Entrada
	@pnumeroOT						VARCHAR(45),
	@precomendaciones				VARCHAR(45),
    @paccion						VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje					INT,
	@pmensaje 						VARCHAR(1000)

    -- Otros parametros de salida

;

SET @pnumeroOT = 'OT0000011';
SET @precomendaciones = 'Seria bueno hacer el chekeo de los 100 KM';
SET @paccion = 'SAVE';

SET @pcodigoMensaje = 0;
SET @pmensaje = '';


EXEC OT_J_CONTROL_CALIDAD
	-- INTPUT
	@pnumeroOT,
	@precomendaciones,
	@paccion,
	
	-- OUTPUT
	@pcodigoMensaje OUTPUT,
	@pmensaje OUTPUT
;

-- OUTPUT
SELECT @pcodigoMensaje;
SELECT @pmensaje;























-- LLamar al procedimiento almacenado: OT_A_FINALIZAR_OT
select * from OrdenTrabajo
UPDATE OrdenTrabajo SET 
	EstadoOT_idEstadoOT = 11
WHERE numeroOT = 'OT0000011';

DECLARE
	-- Parametros de Entrada
	@pnumeroOT						VARCHAR(45),
    @paccion						VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje					INT,
	@pmensaje 						VARCHAR(1000)

    -- Otros parametros de salida

;

SET @pnumeroOT = 'OT0000011';
SET @paccion = 'SAVE';

SET @pcodigoMensaje = 0;
SET @pmensaje = '';


EXEC OT_A_FINALIZAR_OT
	-- INTPUT
	@pnumeroOT,
	@paccion,
	
	-- OUTPUT
	@pcodigoMensaje OUTPUT,
	@pmensaje OUTPUT
;

-- OUTPUT
SELECT @pcodigoMensaje;
SELECT @pmensaje;

























-- LLamar al procedimiento almacenado: FA_FACTURA
select * from OrdenTrabajo


DECLARE
	-- Parametros de Entrada
	@pnumeroOT						VARCHAR(45),
    @paccion						VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje					INT,
	@pmensaje 						VARCHAR(1000)

    -- Otros parametros de salida

;

SET @pnumeroOT = 'OT0000011';
SET @paccion = 'SAVE';

SET @pcodigoMensaje = 0;
SET @pmensaje = '';


EXEC FA_FACTURA
	-- INTPUT
	@pnumeroOT,
	@paccion,
	
	-- OUTPUT
	@pcodigoMensaje OUTPUT,
	@pmensaje OUTPUT
;

-- OUTPUT
SELECT @pcodigoMensaje;
SELECT @pmensaje;



