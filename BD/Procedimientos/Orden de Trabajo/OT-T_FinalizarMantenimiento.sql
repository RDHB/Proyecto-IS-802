-- <=== OT_T_FinalizarMantenimiento ===>
/* Requisitos de las acciones:
 * SELECT: @pnumeroOT
 * Salida: idProducto, nombre, cantidad, precioVenta, subTotal
 * 
 * SAVE: @pnumeroOT, @preparacionesEfectuadas
 * Opcionales: @preparacionesNoEfectuadas
*/
CREATE OR ALTER PROCEDURE OT_T_FINALIZAR_MANTENIMIENTO(
    -- Parametros de Entrada
	@pnumeroOT					VARCHAR(45),
	@preparacionesEfectuadas	VARCHAR(45),
	@preparacionesNoEfectuadas	VARCHAR(45),
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



    /* Funcionalidad: Seleccionar Lista de Materiales
     * Construir un select con la sigueinte informacion:
     * Datos: @pnumeroOT
	 * Salida: idProducto, nombre, cantidad, precioVenta, subTotal
     *
     * Seleccionar los sigueintes datos en la tabla Lista_MyR:
     * idProducto, NombreProducto, Cantidad, Precio, Subtotal
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
		SELECT 
			P.idProducto
			, P.nombre
			, LMR.cantidad
			, P.precioVenta
			, (LMR.cantidad * P.precioVenta) AS 'SubTotal'
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
     * Datos: @pnumeroOT, @preparacionesEfectuadas, @preparacionesNoEfectuadas
     *
     * Actualizar los sigueintes datos en la tabla OrdenTrabajo:
     * EstadoOT_idEstadoOT = 10, reparacionesEfectuadas, reparacionesNoEfectuadas
    */
    IF @paccion = 'SAVE' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pnumeroOT = '' OR @pnumeroOT IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' numeroOT ';
		END;

		IF @preparacionesEfectuadas = '' OR @preparacionesEfectuadas IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' reparacionesEfectuadas ';
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
		WHERE EstadoOT_idEstadoOT = 9 AND numeroOT=@pnumeroOT
		IF @vconteo = 0 BEGIN
			SET @pmensaje= @pmensaje + ' No se puede guardar cambios en este momento, consulte el estado de la Orden de Trabajo';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;
		


		-- Accion del procedimiento
		-- Servicios efectuados
		UPDATE Lista_Servicios SET
			servicioEfectuado = 1
		FROM (
			SELECT 
				OT.idOrdenTrabajo
				, S.idServicios
				, servicioEfectuado
			FROM Lista_Servicios LS
			INNER JOIN OrdenTrabajo OT ON OT.idOrdenTrabajo = LS.OrdenTrabajo_idOrdenTrabajo
			INNER JOIN Servicios S ON S.idServicios = LS.Servicios_idServicios
			WHERE OT.numeroOT =@pnumeroOT
		) AS T
		WHERE Servicios_idServicios = T.idServicios
		AND OrdenTrabajo_idOrdenTrabajo = T.idOrdenTrabajo

		-- Actualiza la orden de trabajo 
		UPDATE OrdenTrabajo SET
			EstadoOT_idEstadoOT = 10
			, reparacionesEfectuadas = @preparacionesEfectuadas
			, reparacionesNoEfectuadas = @preparacionesNoEfectuadas
		WHERE numeroOT = @pnumeroOT;


		
        SET @pmensaje = 'Datos guardados con exito';
	END;
    
	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
