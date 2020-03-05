-- <=== Pantalla ===>
/* Requisitos de las acciones:
 * <ACCION 1>: <@parametro1>, <@parametro2> ...
 * Opcional: <@parametro3>, <@parametro4> ...
 * 
 * <ACCION 2>: ...
*/
CREATE PROCEDURE SIGLAS_NOMBRE_PA(
    -- Parametros de Entrada
    @paccion					VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje				INT OUTPUT,
	@pmensaje 					VARCHAR(1000) OUTPUT

    -- Otros parametros de salida

)AS
BEGIN
    -- Declaracion de Variables
    DECLARE	@vconteo INT;



    /* Funcionalidad: <nombre_funcionalidad>
    * Construir un (select, insert, update o delete) con la sigueinte informacion:
    * parametro1, parametro2, parametro3...
    *
    * (Consultar, insertar, actualizar o eliminar) los sigueintes datos en la tabla <nombre_tabla>:
    * campo1, campo2, campo3
    */
    IF @paccion = 'ACTION' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos



		-- Validacion de identificadores



		-- Validacion de procedimientos



		-- Accion del procedimiento 



        SET @pmensaje = 'Finalizado con exito';
	END;
    
	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END


