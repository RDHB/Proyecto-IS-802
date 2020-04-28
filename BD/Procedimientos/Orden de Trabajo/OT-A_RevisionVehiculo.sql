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
		IF @parametro1 = '' OR @parametro1 IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' campo1 ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
		-- Solo se puede dar revicion a ordenes de trabajo que tengan el idEstadoOT = 2
        SELECT @vconteo = COUNT(*) FROM Tabla
		WHERE campo1 = @parametro1;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @parametro1 + ' ';
		END;

        SELECT @vconteo = COUNT(*) FROM Tabla
		WHERE campo1 = @parametro1;
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + ' Ya existe el identificador => ' + @parametro1 + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de procedimientos
		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;


		
		-- Accion del procedimiento 



        SET @pmensaje = 'Finalizado con exito';
	END;
    
	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
