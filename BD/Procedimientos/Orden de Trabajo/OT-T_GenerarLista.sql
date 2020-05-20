-- <=== OT_A_GenerarLista ===>
/* Requisitos de las acciones:
 * INSERT: @pnumeroOT, @pidProducto, @pcantidad
 * 
 * SELECT: @pnumeroOT
 * Salida: idOrdenTrabajo, numeroOT, idProducto, nombre, rebajados, precioVenta, subTotal
 *
 * DELETE: @pnumeroOT, @pidProducto
 * 
 * SAVE: @pnumeroOT
*/
CREATE OR ALTER PROCEDURE OT_A_GENERAR_LISTA (
    -- Parametros de Entrada
	@pnumeroOT					VARCHAR(45),
	@pidProducto				INT,
	@pcantidad					INT,
    @paccion					VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje				INT OUTPUT,
	@pmensaje 					VARCHAR(1000) OUTPUT

    -- Otros parametros de salida

) AS
BEGIN
    -- Declaracion de Variables
    DECLARE	@vconteo INT
		, @vrebajados INT = 0
	;



    /* Funcionalidad: Agregar productos ListMyR
     * Construir un insert con la sigueinte informacion:
     * Datos: @pnumeroOT, @pidProducto, @pcantidad
     *
     * Insertar los sigueintes datos en la tabla Lista_MyR:
     * OrdenTrabajo_idOrdenTrabajo, Producto_idProducto, cantidad, rebados = 0
    */
    IF @paccion = 'INSERT' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';
		SET @vrebajados=0;



		-- Validacion de campos nulos
		IF @pnumeroOT = '' OR @pnumeroOT IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' numeroOT ';
		END;

		IF @pidProducto = 0 BEGIN
			SET @pmensaje = @pmensaje + ' idProducto ';
		END;
		
		IF @pcantidad = 0 BEGIN
			SET @pmensaje = @pmensaje + ' cantidad ';
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

		SELECT @vconteo = COUNT(*) FROM Producto
		WHERE idProducto = @pidProducto;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + CAST(@pidProducto AS VARCHAR) + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de procedimientos
		-- En la orden de trabajo no pueden contratarse dos servicios del mismo tipo
		SELECT @vconteo=COUNT(*) FROM OrdenTrabajo OT
		INNER JOIN Lista_MyR LMR ON LMR.OrdenTrabajo_idOrdenTrabajo = OT.idOrdenTrabajo
		WHERE numeroOT = @pnumeroOT
		AND LMR.Producto_idProducto = @pidProducto
		IF @vconteo <> 0 BEGIN
			SET @pmensaje= @pmensaje + ' Ya esta este producto en la lista de materiales';
		END;

		-- No se puede dar reivision del vehiculo en este momento, consulte el estado de la Orden de Trabajo
		SELECT @vconteo=COUNT(*) FROM OrdenTrabajo
		WHERE EstadoOT_idEstadoOT = 6 AND numeroOT = @pnumeroOT
		IF @vconteo = 0 BEGIN
			SET @pmensaje= @pmensaje + ' No se puede agregar materiales en este momento, consulte el estado de la Orden de Trabajo';
		END;
		
		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;



		-- Accion del procedimiento 
		INSERT Lista_MyR(
			OrdenTrabajo_idOrdenTrabajo
			, Producto_idProducto
			, cantidad
			, rebajados
		)
		VALUES (
			(SELECT idOrdenTrabajo FROM OrdenTrabajo WHERE numeroOT = @pnumeroOT)
			, @pidProducto
			, @pcantidad
			, @vrebajados
		);

        SET @pmensaje = 'Producto agregado con exito';
	END;
    









	/* Funcionalidad: Consultar productos ListMyR
     * Construir un select con la sigueinte informacion:
     * Datos: @pnumeroOT
	 * Salida: idOrdenTrabajo, numeroOT, idProducto, nombre, rebajados, precioVenta, subTotal
     *
     * Seleccionar los sigueintes datos en la tabla ListMyR y Productos:
     * OrdenTrabajo_idOrdenTrabajo, numeroOT, idProducto, nombre, rebajados, precioVenta, subTotal
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
		-- No hay validaciones del procedimiento
		


		-- Accion del procedimiento 
		SELECT 
			LMR.Producto_idProducto AS 'idProducto'
			, P.nombre
			, LMR.cantidad
			, P.precioVenta
			, (LMR.cantidad * P.precioVenta) AS 'subTotal'
			, LMR.rebajados
		FROM Lista_MyR LMR
		INNER JOIN OrdenTrabajo OT ON OT.idOrdenTrabajo = LMR.OrdenTrabajo_idOrdenTrabajo
		INNER JOIN Producto P ON P.idProducto = LMR.Producto_idProducto
		WHERE OT.numeroOT = @pnumeroOT

        SET @pmensaje = 'Consulta finalizada con exito';
	END;










	/* Funcionalidad: Cancelar Productos
     * Construir un delete con la sigueinte informacion:
     * Datos: @pnumeroOT, @pidProducto
     *
     * Borrar los sigueintes datos en la tabla Lista_Servicios segun los siguientes campos:
     * OrdenTrabajo_idOrdenTrabajo = idOrdenTrabajo, Productos_idProductos = @idProductos
    */
    IF @paccion = 'DELETE' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pnumeroOT = '' OR @pnumeroOT IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' numeroOT ';
		END;

		IF @pidProducto = 0 BEGIN
			SET @pmensaje = @pmensaje + ' idProducto ';
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

		SELECT @vconteo = COUNT(*) FROM Producto
		WHERE idProducto = @pidProducto;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + CAST(@pidProducto AS VARCHAR) + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de procedimientos
		-- Solo se pueden borrar productos a ordenes de trabajo que no esten finalizadas. Es decir idEstadoOT = 6
		SELECT @vconteo=COUNT(*) FROM OrdenTrabajo
		WHERE EstadoOT_idEstadoOT = 6 AND numeroOT=@pnumeroOT
		IF @vconteo = 0 BEGIN
			SET @pmensaje= @pmensaje + ' No se puede eliminar productos en este momento, consulte el estado de la Orden de Trabajo';
		END;

		SELECT @vconteo=COUNT(*) FROM OrdenTrabajo OT
		INNER JOIN Lista_MyR LMR ON LMR.OrdenTrabajo_idOrdenTrabajo = OT.idOrdenTrabajo
		WHERE numeroOT = @pnumeroOT
		AND LMR.Producto_idProducto = @pidProducto
		IF @vconteo = 0 BEGIN
			SET @pmensaje= @pmensaje + ' Este producto no ha sido agregado';
		END;

		SELECT @vconteo=COUNT(*) FROM OrdenTrabajo OT
		INNER JOIN Lista_MyR LMR ON LMR.OrdenTrabajo_idOrdenTrabajo = OT.idOrdenTrabajo
		WHERE numeroOT = @pnumeroOT
		AND LMR.Producto_idProducto = @pidProducto
		AND LMR.rebajados = 1
		IF @vconteo <> 0 BEGIN
			SET @pmensaje= @pmensaje + ' El producto ya fue rebajado';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;

		-- Accion del procedimiento 
		DELETE FROM Lista_MyR
		WHERE OrdenTrabajo_idOrdenTrabajo = (
			SELECT idOrdenTrabajo FROM OrdenTrabajo 
			WHERE numeroOT = @pnumeroOT
		)
		AND Producto_idProducto = @pidProducto;

        SET @pmensaje = 'Producto removido con exito';
	END;










	/* Funcionalidad: Guardar cambios
     * Construir un update con la sigueinte informacion:
     * Datos: @pnumeroOT
     *
     * Actualizar los sigueintes datos en la tabla OrdenTrabajo:
     * EstadoOT_idEstadoOT = 7
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
		WHERE EstadoOT_idEstadoOT = 6 AND numeroOT=@pnumeroOT
		IF @vconteo = 0 BEGIN
			SET @pmensaje= @pmensaje + ' No se puede guardar cambios en este momento, consulte el estado de la Orden de Trabajo';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;
		


		-- Accion del procedimiento
		UPDATE OrdenTrabajo SET 
			EstadoOT_idEstadoOT = 7
		WHERE numeroOT = @pnumeroOT

		
        SET @pmensaje = 'Datos guardados con exito';
	END;

	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
