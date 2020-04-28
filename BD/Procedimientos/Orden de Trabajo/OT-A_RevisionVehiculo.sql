-- <=== OT-A_RevisionVehiculo ===>
/* Requisitos de las acciones:
 * UPDATE: @idOrdenTrabajo, @pfechaInicio, @pestado_del_vehiculo
 * Opcional: @pobjetosPersonales
 * 
*/
CREATE PROCEDURE OT_A_REVISION_VEHICULO (
    -- Parametros de Entrada
	@pidOrdenTrabajo				INT,
	@pfechaInicio					DATE,
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
     * Datos: @pidOrdenTrabajo, @pfechaInicio, @pestado_del_vehiculo
     * Datos Opcionales: @pobjetosPersonales
     *
     * Actualizar, los sigueintes datos en la tabla OrdenTrabajo:
     * fechaInicio, estado_del_vehiculo, objetosPersonales
    */
    IF @paccion = 'UPDATE' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pidOrdenTrabajo = '' OR @pidOrdenTrabajo IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' id Orden de Trabajo ';
		END;
		IF @pfechaInicio = '' OR @pfechaInicio IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' Fecha Inicio ';
		END;
		IF @pestado_del_vehiculo = '' OR @pestado_del_vehiculo IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' Estado del vehiculo ';
		END;
		IF @pobjetosPersonales = '' OR @pobjetosPersonales IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' Objetos Personales  ';
		END;
		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
        SELECT @vconteo = COUNT(*) FROM OrdenTrabajo
		WHERE idOrdenTrabajo = @pidOrdenTrabajo;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pidOrdenTrabajo + ' ';
		END;
        SELECT @vconteo = COUNT(*) FROM OrdenTrabajo
		WHERE idOrdenTrabajo = @pidOrdenTrabajo;
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + ' Ya existe el identificador => ' + @pidOrdenTrabajo + ' ';
		END;

		SELECT @vconteo = COUNT(*) FROM OrdenTrabajo
		WHERE fechaInicio = @pfechaInicio;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pfechaInicio + ' ';
		END;
        SELECT @vconteo = COUNT(*) FROM OrdenTrabajo
		WHERE fechaInicio = @pfechaInicio;
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + ' Ya existe el identificador => ' + @pfechaInicio + ' ';
		END;

		SELECT @vconteo = COUNT(*) FROM OrdenTrabajo
		WHERE estado_del_vehiculo = @pestado_del_vehiculo;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pestado_del_vehiculo + ' ';
		END;
        SELECT @vconteo = COUNT(*) FROM OrdenTrabajo
		WHERE estado_del_vehiculo = @pestado_del_vehiculo;
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + ' Ya existe el identificador => ' + @pestado_del_vehiculo + ' ';
		END;

		SELECT @vconteo = COUNT(*) FROM OrdenTrabajo
		WHERE objetosPersonales = @pobjetosPersonales;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pobjetosPersonales + ' ';
		END;

        SELECT @vconteo = COUNT(*) FROM OrdenTrabajo
		WHERE objetosPersonales = @pobjetosPersonales;
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + ' Ya existe el identificador => ' + @pobjetosPersonales + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;

		-- Validacion de procedimientos
		SELECT @vconteo=COUNT(*) FROM OrdenTrabajo ot
		INNER JOIN EstadoOT e ON ot.EstadoOT_idEstadoOT=e.idEstadoOT
		WHERE idEstadoOT=2 AND idOrdenTrabajo=@pidOrdenTrabajo AND fechaInicio=@pfechaInicio 
		AND estado_del_vehiculo=@pestado_del_vehiculo;
		IF @vconteo=0 BEGIN
			SET @pmensaje= @pmensaje + 'Error =>';
		END;
		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procedimiento: ' + @pmensaje;
			RETURN;
		END;

		
		-- Accion del procedimiento 
		UPDATE OrdenTrabajo SET idOrdenTrabajo=@pidOrdenTrabajo, fechaInicio= @pfechaInicio,
			estado_del_vehiculo= @pestado_del_vehiculo, objetosPersonales=@pobjetosPersonales
		WHERE idOrdenTrabajo=@pidOrdenTrabajo;
        SET @pmensaje = 'Finalizado con exito';

	END;
    
	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
