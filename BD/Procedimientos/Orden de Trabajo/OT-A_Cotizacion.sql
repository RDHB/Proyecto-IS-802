-- <=== OT-A_Cotizacion ===>
/* Requisitos de las acciones:
 * INSERT: @pidOrdenTrabajo, @pidProducto
 * 
 * SELECT-OT: @pidOrdenTrabajo
 * Salida: Select idProducto, NombreProducto, Cantidad, Precio, Subtotal
 * 
 * SELECT-P: 
 * Salida: idProducto, nombre, precioVenta
*/
CREATE PROCEDURE OT_A_COTIZACION (
    -- Parametros de Entrada
	@pidOrdenTrabajo			INT,
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
     * Datos: @pidOrdenTrabajo, @pidProducto
     *
     * Insertar los sigueintes datos en la tabla Lista_Cotizacion:
     * OrdenTrabajo_idOrdenTrabajo, Producto_idProducto
    */
    IF @paccion = 'INSERT' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pidOrdenTrabajo = '' OR @pidOrdenTrabajo IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' idOrdenTrabajo ';
		END;

		IF @pidProducto = '' OR @pidProducto IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' idProducto ';
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
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + CAST(@pidOrdenTrabajo AS VARCHAR) + ' ';
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
		WHERE EstadoOT_idEstadoOT = 4 AND idOrdenTrabajo = @pidOrdenTrabajo
		
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No se pueden cotizar los productos en este momento, verifique el estado de la orden de trabajo => ' + CAST(@pidProducto AS VARCHAR) + ' ';
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
			, aprovados
		) VALUES (
			@pidOrdenTrabajo
			, @pidProducto
			, 0
		)

        SET @pmensaje = 'Finalizado con exito';
	END;
    









	/* Funcionalidad: Seleccionar Lista de Cotizacion
     * Construir un select con la sigueinte informacion:
     * Datos: @pidOrdenTrabajo
     *
     * Seleccionar los sigueintes datos en la tabla Lista_Cotizacion:
     * idProducto, NombreProducto, Cantidad, Precio, Subtotal
    */
    IF @paccion = 'SELECT-OT' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pidOrdenTrabajo = '' OR @pidOrdenTrabajo IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' idOrdenTrabajo ';
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
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + CAST(@pidOrdenTrabajo AS VARCHAR) + ' ';
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
			, @pcantidad AS 'Cantidad'
			, P.precioVenta
			, (@pcantidad * P.precioVenta) AS 'SubTotal'
		FROM Lista_Cotizacion LC
		INNER JOIN Producto P ON P.idProducto = LC.Producto_idProducto
		WHERE LC.OrdenTrabajo_idOrdenTrabajo = @pidOrdenTrabajo

        SET @pmensaje = 'Finalizado con exito';
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

	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
