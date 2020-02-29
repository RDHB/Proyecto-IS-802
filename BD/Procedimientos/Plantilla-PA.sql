--<=== Pantalla ===>
GO;
CREATE PROCEDURE SIGLAS_NOMBRE_PA(
    -- Parametros de Entrada

    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje				INT OUTPUT,
	@pmensaje 					VARCHAR(1000) OUTPUT

    -- Otros parametros de salida

)AS
BEGIN
    /* Funcionalidad: <nombre_funcionalidad>
    * Construir un (select, insert, update o delete) con la sigueinte informacion:
    * parametro1, parametro2, parametro3...
    *
    * (Consultar, insertar, actualizar o eliminar) los sigueintes datos en la tabla <nombre_tabla>:
    * campo1, campo2, campo3
    */
    -- Declaracion de Variables
    DECLARE	@vconteo INT;

    -- Setear Valores
	SET @pcodigoMensaje=0;
	SET @pmensaje='';

    -- Validacion de campos nulos


    -- Validacion de identificadores


    -- Validacion de procedimientos


    -- Accion del procedimiento 


END


