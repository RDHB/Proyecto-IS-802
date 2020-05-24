-- <=== OT_A_FinalizarOT ===>
/* Requisitos de las acciones:
 * SELECT-O: @pnumeroOT
 * Salida: idOrdenTrabajo, numeroOT, fechaInicio, fechaFin, estado_del_vehiculo, objetosPersonales
 *			reparacionesEfectuadas
 * 
 * SELECT-S: @pnumeroOT
 * Salida: idServicio, nombre, servicioEfectuado, precioCosto, duracion
 * 
 * SELECT-P: @pnumeroOT
 * Salida: idProducto, nombre, cantidad, precioVenta, subTotal, rebajado
 * 
 * SAVE: @pnumeroOT
 * 
 * CANCEL: @pnumeroOT
*/
CREATE OR ALTER PROCEDURE OT_A_FINALIZAR_OT(
    -- Parametros de Entrada
	@pnumeroOT					VARCHAR(45),
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



    /* Funcionalidad: Consultar Sericios
     * Construir un select con la sigueinte informacion:
     * Datos: @pnumeroOT
	 * Salida: idServicio, nombre, servicioEfectuado, precioCosto, duracion
     *
     * Seleccionar los sigueintes datos en la tabla Lista_Servicios y Servicios:
     * Servicios_idServicios, nombre, servicioEfectuado, precioCosto, duracion
    */
    IF @paccion = 'SELECT-S' BEGIN
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
		-- No hay validaciones del procedimiento
		


		-- Accion del procedimiento 
		SELECT 
			S.idServicios
			, S.nombre
			, T.servicioEfectuado AS 'servicioEfectuado'
			, S.precioCosto
			, S.duracion
		FROM (
			SELECT 
				LS.OrdenTrabajo_idOrdenTrabajo
				, LS.Servicios_idServicios 
				, LS.servicioEfectuado
			FROM Lista_Servicios LS
			WHERE OrdenTrabajo_idOrdenTrabajo = (
				SELECT idOrdenTrabajo FROM OrdenTrabajo
				WHERE numeroOT = @pnumeroOT
			)
		) AS T
		INNER JOIN Servicios S ON T.Servicios_idServicios = S.idServicios
		
        SET @pmensaje = 'Consulta finalizada con exito';
	END;
    









	/* Funcionalidad: Seleccionar Lista de Materiales
     * Construir un select con la sigueinte informacion:
     * Datos: @pnumeroOT
	 * Salida: idProducto, nombre, cantidad, precioVenta, subTotal, rebajados
     *
     * Seleccionar los sigueintes datos en la tabla Lista_MyR:
     * idProducto, NombreProducto, Cantidad, Precio, Subtotal, rebajados
    */
    IF @paccion = 'SELECT-P' BEGIN
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
		SELECT 
			P.idProducto
			, P.nombre
			, LMR.cantidad
			, P.precioVenta
			, (LMR.cantidad * P.precioVenta) AS 'SubTotal'
			, P.cantidad AS 'existencia'
			, LMR.rebajados
		FROM Lista_MyR LMR
		INNER JOIN Producto P ON P.idProducto = LMR.Producto_idProducto
		WHERE LMR.OrdenTrabajo_idOrdenTrabajo = (
			SELECT idOrdenTrabajo FROM OrdenTrabajo
			WHERE numeroOT = @pnumeroOT
		);

        SET @pmensaje = 'Consulta finalizada con exito';
	END;










	/* Funcionalidad: Guardar cambios
     * Construir un update con la sigueinte informacion:
     * Datos: @pnumeroOT
     *
     * Actualizar los sigueintes datos en la tabla OrdenTrabajo:
     * EstadoOT_idEstadoOT = 12
    */
    IF @paccion = 'SAVE' BEGIN
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
		SELECT @vconteo=COUNT(*) FROM OrdenTrabajo
		WHERE EstadoOT_idEstadoOT = 11 AND numeroOT=@pnumeroOT
		IF @vconteo = 0 BEGIN
			SET @pmensaje= @pmensaje + ' No se puede guardar cambios en este momento, consulte el estado de la Orden de Trabajo';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;
		


		-- Accion del procedimiento
		-- EstadoOT modificado
		UPDATE OrdenTrabajo SET 
			EstadoOT_idEstadoOT = 12
		WHERE numeroOT = @pnumeroOT;

		
		
        SET @pmensaje = 'Datos guardados con exito';
	END;










	/* Funcionalidad: Cancelar Cotizacion
     * Construir un update con la sigueinte informacion:
     * Datos: @pnumeroOT
     *
     * Actualizar los sigueintes datos en la tabla OrdenTrabajo:
     * EstadoOT_idEstadoOT = 2
    */
    IF @paccion = 'CANCEL' BEGIN
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
		SELECT @vconteo=COUNT(*) FROM OrdenTrabajo
		WHERE EstadoOT_idEstadoOT = 11 AND numeroOT=@pnumeroOT
		IF @vconteo = 0 BEGIN
			SET @pmensaje= @pmensaje + ' No se puede cancelar la transaccion en este momento, consulte el estado de la Orden de Trabajo';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;
		


		-- Accion del procedimiento
		UPDATE OrdenTrabajo SET 
			EstadoOT_idEstadoOT = 2
		WHERE numeroOT = @pnumeroOT;


		
        SET @pmensaje = 'Transaccion cancelada con exito';
	END;
    
	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
