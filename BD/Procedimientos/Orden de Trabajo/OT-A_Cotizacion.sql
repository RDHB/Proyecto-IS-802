-- <=== OT-A_Cotizacion ===>
/* Requisitos de las acciones:
 * INSERT: @pnumeroOT, @pidProducto, @pcantidad
 * 
 * SELECT-OT: @pnumeroOT
 * Salida: Select idProducto, NombreProducto, Cantidad, Precio, Subtotal
 * 
 * SELECT-P: 
 * Salida: idProducto, nombre, precioVenta
 * 
 * SAVE: @pnumeroOT
*/
CREATE PROCEDURE OT_A_COTIZACION (
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
    DECLARE	@vconteo INT;



    /* Funcionalidad: Cotizacion de productos
     * Construir un insert con la sigueinte informacion:
     * Datos: @pnumeroOT, @pidProducto, @pcantidad
     *
     * Insertar los sigueintes datos en la tabla Lista_Cotizacion:
     * OrdenTrabajo_idOrdenTrabajo, Producto_idProducto
    */
    IF @paccion = 'INSERT' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pnumeroOT = '' OR @pnumeroOT IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' numeroOT ';
		END;

		IF @pidProducto = '' OR @pidProducto IS NULL BEGIN
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
		SELECT @vconteo = COUNT(*) FROM OrdenTrabajo
		WHERE EstadoOT_idEstadoOT = 3 AND numeroOT = @pnumeroOT
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No se pueden cotizar los productos en este momento, verifique el estado de la orden de trabajo ';
		END;

		-- En la orden de trabajo no pueden cotizar dos productos del mismo tipo
		SELECT @vconteo=COUNT(*) FROM OrdenTrabajo OT
		INNER JOIN Lista_Cotizacion LC ON OT.idOrdenTrabajo = LC.OrdenTrabajo_idOrdenTrabajo
		WHERE numeroOT = @pnumeroOT
		AND LC.Producto_idProducto = @pidProducto
		IF @vconteo <> 0 BEGIN
			SET @pmensaje= @pmensaje + ' Ya esta cotizado este producto en la orden de Trabajo';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;


		
		-- Accion del procedimiento 
		INSERT INTO Lista_Cotizacion (
			OrdenTrabajo_idOrdenTrabajo
			, Producto_idProducto
			, cantidad
			, aprovados
		) VALUES (
			(SELECT idOrdenTrabajo FROM OrdenTrabajo WHERE numeroOT = @pnumeroOT)
			, @pidProducto
			, @pcantidad
			, 0
		)

        SET @pmensaje = 'Producto cotizado con exito';
	END;
    









	/* Funcionalidad: Seleccionar Lista de Cotizacion
     * Construir un select con la sigueinte informacion:
     * Datos: @pnumeroOT
     *
     * Seleccionar los sigueintes datos en la tabla Lista_Cotizacion:
     * idProducto, NombreProducto, Cantidad, Precio, Subtotal
    */
    IF @paccion = 'SELECT-OT' BEGIN
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
			, LC.cantidad
			, P.precioVenta
			, (LC.cantidad * P.precioVenta) AS 'SubTotal'
		FROM Lista_Cotizacion LC
		INNER JOIN Producto P ON P.idProducto = LC.Producto_idProducto
		WHERE LC.OrdenTrabajo_idOrdenTrabajo = (
			SELECT idOrdenTrabajo FROM OrdenTrabajo
			WHERE numeroOT = @pnumeroOT
		);

        SET @pmensaje = 'Consulta finalizada con exito';
	END;










	/* Funcionalidad: Seleccionar Lista de Cotizacion
     * Construir un select con la sigueinte informacion:
     *
     * Seleccionar los sigueintes datos en la tabla Producto:
     * idProducto, nombre, precioVenta
    */
    IF @paccion = 'SELECT-P' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		
		-- Validacion de identificadores
        
		-- Validacion de procedimientos
		


		-- Accion del procedimiento 
		SELECT 
			idProducto
			, nombre
			, precioVenta
		FROM Producto
		WHERE fechaVencimiento > GETDATE()

        SET @pmensaje = 'Consulta finalizada con exito';
	END;
    









	/* Funcionalidad: Seleccionar Lista de Cotizacion
     * Construir un select con la sigueinte informacion:
     * Datos: @pnumeroOT
     *
     * Seleccionar los sigueintes datos en la tabla Lista_Cotizacion:
     * idProducto, NombreProducto, Cantidad, Precio, Subtotal
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
		WHERE EstadoOT_idEstadoOT = 3 AND numeroOT=@pnumeroOT
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
			EstadoOT_idEstadoOT = 4
		WHERE numeroOT = @pnumeroOT;

        SET @pmensaje = 'Datos guardados con exito';
	END;

	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
