/* Funcionalidad: Devolver informacion de una tabla
 * Construir un Select con la sigueinte informacion:
 * - Tabla de la que se desea consultar
 * - Campo del que se desea filtrar ( <nombre del campo> si es ninguno no se filtra )
 * - Caracteres a buscar ( Usar %Like% )
 * 
 * Se requieren los siguientes parametros: nombreTabla, nombreCampo
 * Devuelve en un JSON todos los datos de la tabla
*/
CREATE PROCEDURE EXTRAER_TABLAS(
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
