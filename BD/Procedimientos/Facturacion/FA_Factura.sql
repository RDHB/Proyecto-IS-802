-- <=== FA_FACTURA ===>
/* Requisitos de las acciones:
 * SELECT-FA: @numeroOT
 * Salida: idFactura, numeroFactura, fecha, total_a_pagar, idOrdenTrabajo
 *		, codigoEmpleado, nombreEmpleado
 *		, idDescuento, descripcionD, porcentaje, fecha_de_validez
 *		, idPromocion, descripcionP, fechaInicio, fechaFin
 * 
 * SELECT-OT: @numeroOT
 * Salida: numeroOT, fechaInicio, fechaFin, estado_del_vehiculo, objetosPersonales
 *		, reparacionesEfectuadas, reparacionesNoEfectuadas, recomendaciones
 *		, numeroIdentidad, nombreCliente, vin,infoVehiculo
 * 
 * SELECT-S: @pnumeroOT
 * Salida: idServicio, nombre, precioCosto, duracion, servicioEfectuado
 *
 * SELECT-L: @pnumeroOT
 * Salida: idProducto, nombre, cantidad, precioVenta, subTotal, rebajados
 * 
 * SAVE: @pnumeroOT, @pidEmpleado
 * Opcionales: @pidFormaPago, @pidDescuento
*/
CREATE OR ALTER PROCEDURE FA_FACTURA (
    -- Parametros de Entrada
	@pnumeroOT						VARCHAR(45),
	@pidEmpleado					INT,
	@pidFormaPago					INT,
	@pidDescuento					INT,
    @paccion						VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje					INT OUTPUT,
	@pmensaje 						VARCHAR(1000) OUTPUT,

    -- Otros parametros de salida
	@pnumeroFactura					VARCHAR(45) OUTPUT
) AS
BEGIN
    -- Declaracion de Variables
    DECLARE	@vconteo INT
		, @vidFactura INT = NULL
		, @vfecha DATE = NULL
		, @vtotal_a_pagar DECIMAL = 0
		, @vidCliente INT = NULL
		, @vidOrdenTrabajo INT = NULL
		, @vidPromociones INT = NULL
		, @vporcentaje DECIMAL(18,4)
	;



    /* Funcionalidad: Consultar informacion Factura
     * Construir un select con la sigueinte informacion:
     * Datos: @pnumeroOT
     *
     * Consultar los sigueintes datos en la tabla Factura:
	 * idFactura, numeroFactura, fecha, total_a_pagar, OrdenTrabajo_idOrdenTrabajo
	 *		, codigoEmpleado, nombreEmpleado
	 *		, idDescuento, descripcionD, porcentaje, fecha_de_validez
	 *		, idPromocion, descripcionP, fechaInicio, fechaFin
    */
    IF @paccion = 'SELECT-FA' BEGIN
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
			FA.idFactura
			, FA.numeroFactura
			, FA.fecha
			, FA.total_a_pagar
			, FA.OrdenTrabajo_idOrdenTrabajo AS 'idOrdenTrabajo'
			, (
				SELECT codigoEmpleado FROM Empleado
				WHERE idEmpleado = FA.Empleado_idEmpleado
			) AS 'codigoEmpleado'
			, (
				SELECT 
					CONCAT(
						P.primerNombre
						, ' '
						, P.segundoNombre
						, ' '
						, P.primerApellido
						, ' '
						, P.segundoApellido
					)
				FROM Persona P
				INNER JOIN Empleado E ON E.Persona_idPersona = P.idPersona
				WHERE E.idEmpleado = FA.Empleado_idEmpleado
			) AS 'nombreEmpleado'
			, D.idDescuento
			, D.descripcion AS 'descripcionD'
			, D.porcentaje
			, D.fecha_de_validez
			, P.idPromociones
			, P.descripcion AS 'descripcionP'
			, P.fechaInicio
			, P.fechaFin
		FROM Factura FA
		LEFT JOIN Descuento D ON D.idDescuento = FA.Descuento_idDescuento
		LEFT JOIN Promociones P ON P.idPromociones = FA.Promociones_idPromociones
		WHERE OrdenTrabajo_idOrdenTrabajo = (
			SELECT idOrdenTrabajo FROM OrdenTrabajo
			WHERE numeroOT = @pnumeroOT
		);



        SET @pmensaje = 'Consulta finalizada con exito';
	END;










	/* Funcionalidad: Consultar informacion Orden de Trabajo
     * Construir un select con la sigueinte informacion:
     * Datos: @pnumeroOT
     *
     * Consultar los sigueintes datos en la tabla OrdenTrabajo:
     * numeroOT, fechaInicio, fechaFin, estado_del_vehiculo, objetosPersonales
	 *		, reparacionesEfectuadas, reparacionesNoEfectuadas, recomendaciones
	 *		, numeroIdentidad, nombreCliente, vin,infoVehiculo
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
		-- No hay validaciones del procedimiento
		


		-- Accion del procedimiento 
		SELECT 
			numeroOT
			, fechaInicio
			, fechaFin
			, estado_del_vehiculo
			, objetosPersonales
			, reparacionesEfectuadas
			, reparacionesNoEfectuadas
			, EstadoOT_idEstadoOT
			, P.numeroIdentidad
			, CONCAT(
					P.primerNombre
					, ' '
					, P.segundoNombre
					, ' '
					, P.primerApellido
					, ' '
					, P.segundoApellido
			) AS 'nombreCliente' 
			, (
				SELECT vin FROM Vehiculos V
				WHERE V.idVehiculos = OT.Vehiculos_idVehiculos
			) AS 'vin'
			, CONCAT ( 
				(
					SELECT MA.descripcion FROM Modelo MO 
					INNER JOIN Marca MA ON MA.idMarca = MO.Marca_idMarca
					WHERE MO.idModelo = (
						SELECT V.Modelo_idModelo FROM Vehiculos V
						WHERE idVehiculos = OT.Vehiculos_idVehiculos
					)
				)
				, ' '
				, (
					SELECT descripcion FROM Modelo MO WHERE MO.idModelo = (
						SELECT V.Modelo_idModelo FROM Vehiculos V
						WHERE idVehiculos = OT.Vehiculos_idVehiculos
					)
				)
			) AS 'Vehiculo'
		FROM OrdenTrabajo OT
		INNER JOIN Cliente C ON C.idCliente = OT.Cliente_idCliente
		INNER JOIN Persona P ON P.idPersona = C.Persona_idPersona
		WHERE numeroOT = @pnumeroOT


        SET @pmensaje = 'Consulta finalizada con exito';
	END;










	/* Funcionalidad: Consultar Sericios
     * Construir un select con la sigueinte informacion:
     * Datos: @pnumeroOT
	 * Salida: idServicio, nombre, precioCosto, duracion, servicioEfectuado
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
		WHERE T.servicioEfectuado = 1;
		
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
    IF @paccion = 'SELECT-L' BEGIN
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
     * Datos: @pnumeroOT, @pidEmpleado
	 * Opcionales: @pidFormaPago, @pidDescuento
     *
     * Actualizar los sigueintes datos en la tabla OrdenTrabajo:
     * EstadoOT_idEstadoOT = 13
    */
    IF @paccion = 'SAVE' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pnumeroOT = '' OR @pnumeroOT IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' numeroOT ';
		END;

		IF @pidEmpleado = 0 BEGIN
			SET @pmensaje = @pmensaje + ' idEmpleado ';
		END;
		
		IF @pidFormaPago = 0 BEGIN
			SET @pidFormaPago = 1;
		END;

		IF @pidDescuento = 0 BEGIN
			SET @pidDescuento = NULL;
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
			SET @pmensaje = @pmensaje + ' numeroOT => ' + @pnumeroOT + ', ';
		END;

		SELECT @vconteo = COUNT(*) FROM Empleado
		WHERE idEmpleado = @pidEmpleado;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' idEmpleado => ' + CAST(@pidEmpleado AS VARCHAR) + ', ';
		END;

		SELECT @vconteo = COUNT(*) FROM FormaPago
		WHERE idFormaPago = @pidFormaPago;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' idFormaPaggo => ' + CAST(@pidFormaPago AS VARCHAR) + ', ';
		END;

		SELECT @vconteo = COUNT(*) FROM Descuento
		WHERE idDescuento = @pidDescuento;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' idDescuento => ' + CAST(@pidDescuento AS VARCHAR) + ', ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + 'No existe el identificador' + @pmensaje;
			RETURN;
		END;



		-- Validacion de procedimientos
		SELECT @vconteo=COUNT(*) FROM OrdenTrabajo
		WHERE EstadoOT_idEstadoOT = 12 AND numeroOT=@pnumeroOT
		IF @vconteo = 0 BEGIN
			SET @pmensaje= @pmensaje + ' No se puede guardar cambios en este momento, consulte el estado de la Orden de Trabajo';
		END;

		SELECT @vconteo = COUNT(*) FROM Descuento
		WHERE idDescuento = @pidDescuento
		AND fecha_de_validez > GETDATE();
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' El descuento ya caduco ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;
		


		-- Accion del procedimiento
		SET @vidFactura = (SELECT COUNT(*) + 1 FROM Factura);

		SET @pnumeroFactura = (SELECT DBO.FN_GENERAR_CODIGO_EMP('FA', @vidFactura,7) );

		SET @vfecha = GETDATE();

		SET @vtotal_a_pagar = (
			SELECT SUM(S.precioCosto) FROM Lista_Servicios LS
			INNER JOIN Servicios S ON LS.Servicios_idServicios = S.idServicios
			INNER JOIN OrdenTrabajo OT ON OT.idOrdenTrabajo = LS.OrdenTrabajo_idOrdenTrabajo
			WHERE LS.servicioEfectuado = 1 AND numeroOT = @pnumeroOT
		) + (
			SELECT SUM(P.precioVenta) FROM Lista_MyR LMR
			INNER JOIN Producto P ON LMR.Producto_idProducto = P.idProducto
			INNER JOIN OrdenTrabajo OT ON OT.idOrdenTrabajo = LMR.OrdenTrabajo_idOrdenTrabajo
			WHERE LMR.rebajados = 1 AND numeroOT = @pnumeroOT
		);

		SET @vidCliente = (
			SELECT Cliente_idCliente FROM OrdenTrabajo
			WHERE numeroOT = @pnumeroOT
		);

		SET @vidOrdenTrabajo = (
			SELECT idOrdenTrabajo FROM OrdenTrabajo
			WHERE numeroOT = @pnumeroOT
		);

		SET @vidPromociones = (
			SELECT idPromociones FROM Promociones
			WHERE GETDATE() BETWEEN fechaInicio AND fechaFin
		);
		IF @vidPromociones = 0 BEGIN
			SET @vidPromociones = NULL;
		END;

		SET @vporcentaje = 0;
		IF @pidDescuento IS NOT NULL BEGIN
			SET @vporcentaje = (
				SELECT porcentaje FROM Descuento
				WHERE idDescuento = @pidDescuento
			);
		END;



		--Crear Factura
		SET @vtotal_a_pagar = @vtotal_a_pagar - ( @vtotal_a_pagar * (@vporcentaje/100) );
		INSERT INTO Factura (
			idFactura
			, numeroFactura
			, fecha
			, total_a_pagar
			, Cliente_idCliente
			, Empleado_idEmpleado
			, FormaPago_idFormaPago
			, OrdenTrabajo_idOrdenTrabajo
			, Promociones_idPromociones
			, Descuento_idDescuento
		) VALUES(
			@vidFactura
			, @pnumeroFactura
			, @vfecha
			, @vtotal_a_pagar
			, @vidCliente
			, @pidEmpleado
			, @pidFormaPago
			, @vidOrdenTrabajo
			, @vidPromociones
			, @pidDescuento
		);


		-- EstadoOT modificado
		UPDATE OrdenTrabajo SET 
			EstadoOT_idEstadoOT = 13
		WHERE numeroOT = @pnumeroOT;

		
		
        SET @pmensaje = 'Datos guardados con exito';
	END;
    
	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
