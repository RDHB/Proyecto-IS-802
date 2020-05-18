-- <=== OT-A_RevisionVehiculo ===>
/* Requisitos de las acciones:
 * UPDATE: @pnumeroOT, @pestado_del_vehiculo
 * Opcional: @pobjetosPersonales
 * 
*/
CREATE OR ALTER PROCEDURE OT_A_REVISION_VEHICULO (
    -- Parametros de Entrada
	@pnumeroOT						VARCHAR(45),
	@pestado_del_vehiculo			VARCHAR(1000),
	@pobjetosPersonales				VARCHAR(1000),
    @paccion						VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje					INT OUTPUT,
	@pmensaje 						VARCHAR(1000) OUTPUT

    -- Otros parametros de salida

) AS
BEGIN
    -- Declaracion de Variables
    DECLARE	@vconteo INT;



    /* Funcionalidad: Registrar la revision del vehiculo
     * Construir un Update con la sigueinte informacion:
     * Datos: @pnumeroOT, @pestado_del_vehiculo
     * Datos Opcionales: @pobjetosPersonales
     *
     * Actualizar, los sigueintes datos en la tabla OrdenTrabajo:
     * estado_del_vehiculo, objetosPersonales
    */
    IF @paccion = 'UPDATE' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pnumeroOT = '' OR @pnumeroOT IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' numeroOT ';
		END;

		IF @pestado_del_vehiculo = '' OR @pestado_del_vehiculo IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' estadoVehiculo ';
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
		-- Validar 
		SELECT @vconteo=COUNT(*) FROM OrdenTrabajo
		WHERE EstadoOT_idEstadoOT = 1 AND numeroOT = @pnumeroOT

		IF @vconteo = 0 BEGIN
			SET @pmensaje= @pmensaje + ' No se puede dar reivision del vehiculo en este momento, consulte el estado de la Orden de Trabajo';
		END;
		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procedimiento: ' + @pmensaje;
			RETURN;
		END;

		
		-- Accion del procedimiento 
		UPDATE OrdenTrabajo SET 
			estado_del_vehiculo = @pestado_del_vehiculo
			, objetosPersonales = @pobjetosPersonales
			, EstadoOT_idEstadoOT = 2
		WHERE numeroOT = @pnumeroOT;

        SET @pmensaje = 'Revision del vehiculo finalizado con exito';
	END;
    
	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
