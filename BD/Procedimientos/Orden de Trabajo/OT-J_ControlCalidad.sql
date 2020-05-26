-- <=== OT_J_ControlCalidad ===>
/* Requisitos de las acciones:
 * SELECT: @pnumeroOT
 * Salida: numeroOT, reparacionesEfectuadas, reparacionesNoEfectuadas
 * 
 * SAVE: @pnumeroOT, @precomendaciones
 * Opcionales: @preparacionesNoEfectuadas
*/
CREATE OR ALTER PROCEDURE OT_J_CONTROL_CALIDAD (
    -- Parametros de Entrada
	@pnumeroOT					VARCHAR(45),
	@precomendaciones			VARCHAR(45),
    @paccion					VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje				INT OUTPUT,
	@pmensaje 					VARCHAR(1000) OUTPUT

    -- Otros parametros de salida

) AS
BEGIN
    -- Declaracion de Variables
    DECLARE	@vconteo INT;


	/* Funcionalidad: Guardar cambios
     * Construir un select con la sigueinte informacion:
     * Datos: @pnumeroOT, @precomendaciones
     *
     * Actualizar los sigueintes datos en la tabla OrdenTrabajo:
     * EstadoOT_idEstadoOT = 11, recomendaciones
    */
    IF @paccion = 'SAVE' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pnumeroOT = '' OR @pnumeroOT IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' numeroOT ';
		END;

		IF @precomendaciones = '' OR @precomendaciones IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' recomendaciones ';
		END;
		
		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
        SELECT @vconteo = COUNT(*) FROM OrdenTrabajo
		WHERE numeroOT = @pnumeroOT;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pnumeroOT + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de procedimientos
		SELECT @vconteo=COUNT(*) FROM OrdenTrabajo
		WHERE EstadoOT_idEstadoOT = 10 AND numeroOT=@pnumeroOT
		IF @vconteo = 0 BEGIN
			SET @pmensaje= @pmensaje + ' No se puede guardar cambios en este momento, consulte el estado de la Orden de Trabajo';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;
		


		-- Accion del procedimiento
		-- Actualiza la orden de trabajo 
		UPDATE OrdenTrabajo SET
			EstadoOT_idEstadoOT = 11
			, recomendaciones = @precomendaciones
		WHERE numeroOT = @pnumeroOT;


		
        SET @pmensaje = 'Datos guardados con exito';
	END;










    /* Funcionalidad: Consultar Orden de Trabajo
     * Construir un select con la sigueinte informacion:
     * Datos: @pnumeroOT
	 * Salida: numeroOT, reparacionesEfectuadas, reparacionesNoEfectuadas
     *
     * Seleccionar los sigueintes datos en la tabla OrdenTrabajo:
     * : numeroOT, reparacionesEfectuadas, reparacionesNoEfectuadas
    */
    IF @paccion = 'SELECT' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pnumeroOT = '' OR @pnumeroOT IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' numeroOT ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
        SELECT @vconteo = COUNT(*) FROM OrdenTrabajo
		WHERE numeroOT = @pnumeroOT;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pnumeroOT + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de procedimientos
		


		-- Accion del procedimiento
		-- Actualiza la orden de trabajo 
		SELECT 
			numeroOT
			, reparacionesEfectuadas
			, reparacionesNoEfectuadas
			, recomendaciones
			, EstadoOT_idEstadoOT
		FROM OrdenTrabajo
		WHERE numeroOT = @pnumeroOT


		
        SET @pmensaje = 'Consulta finalizada con exito';
	END;
    
	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
