-- <=== Pantalla ===>
/* Requisitos de las acciones:
 * INSERT: @pvin, @pnumeroIdentidad
 * Salida: @pnumeroOT
 * 
 * SELECT: <No hay parametros>
 * Salida: Select(idOrdenTrabajo, nombreCliente, (Marca y Modelo), EstadoOT)
*/
CREATE PROCEDURE OT_A_GENERAR_OT (
    -- Parametros de Entrada
	@pvin						VARCHAR(45),
	@pnumeroIdentidad			VARCHAR(45),
    @paccion					VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje				INT OUTPUT,
	@pmensaje 					VARCHAR(1000) OUTPUT,

    -- Otros parametros de salida
	@pnumeroOT					VARCHAR(45) OUTPUT
) AS
BEGIN
    -- Declaracion de Variables
    DECLARE	@vconteo INT
		, @vidOrdenTrabajo INT
		, @vidVehiculo INT
		, @vidCliente INT
	;



    /* Funcionalidad: GenerarOT
     * Construir un insert con la sigueinte informacion:
     * Datos: @pvin, @pnumeroIdentidad
	 * Salida: @pnumeroOT
     *
     * Insertar los sigueintes datos en la tabla OrdenTrabajo:
     * idOrdenTrabajo, Cliente_idCliente, EstadoOT_idEstadoOT, Vehiculo_idVehiculo
    */
    IF @paccion = 'INSERT' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pvin = '' OR @pvin IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' vin ';
		END;

		IF @pnumeroIdentidad = '' OR @pnumeroIdentidad IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' numeroIdentidad ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
        SELECT @vconteo = COUNT(*) FROM Vehiculos
		WHERE vin = @pvin
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pvin + ' ';
		END;

		SELECT @vconteo = COUNT(*) FROM Persona
		WHERE numeroIdentidad = @pnumeroIdentidad
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pnumeroIdentidad + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de procedimientos
		SET @vidCliente = (
			SELECT C.idCliente FROM Persona P
			INNER JOIN Cliente C ON C.Persona_idPersona = P.idPersona
			WHERE numeroIdentidad = @pnumeroIdentidad
		)
		SET @vidVehiculo = (
			SELECT idVehiculos FROM Vehiculos
			WHERE vin = @pvin
		)

		SELECT @vconteo = COUNT(*) FROM OrdenTrabajo
		WHERE Vehiculos_idVehiculos = @vidVehiculo
		AND EstadoOT_idEstadoOT <> 13

		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + ' La orden de trabajo para este vehiculo aun no ha finalizado => ' + @pvin + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;


		
		-- Accion del procedimiento 
		SET @vidOrdenTrabajo = (SELECT MAX(idOrdenTrabajo) + 1 FROM OrdenTrabajo);
		
		SET @pnumeroOT = (SELECT dbo.FN_GENERAR_CODIGO_EMP('OT',@vidOrdenTrabajo,7));
		
		INSERT INTO OrdenTrabajo (
			idOrdenTrabajo
			, numeroOT
			, fechaInicio
			, Cliente_idCliente
			, EstadoOT_idEstadoOT
			, Vehiculos_idVehiculos
		) VALUES (
			@vidOrdenTrabajo
			, @pnumeroOT
			, GETDATE()
			, @vidCliente
			, 1
			, @vidVehiculo
		);
		
        SET @pmensaje = 'Orden de Trabajo agregada con exito';
	END;
    









	/* Funcionalidad: GenerarOT
     * Construir un select con la sigueinte informacion:
     * Datos: @pvin, @pnumeroIdentidad
     *
     * SELECT: <No hay parametros>
	 * Salida: Select(idOrdenTrabajo, numeroOT, nombreCliente, (Marca y Modelo), EstadoOT)
    */
    IF @paccion = 'SELECT' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';

		-- Validacion de campos nulos
		
		-- Validacion de identificadores
        
		-- Validacion de procedimientos
		
		-- Accion del procedimiento 
		SELECT 
			OT.idOrdenTrabajo
			, OT.numeroOT
			, (
				SELECT CONCAT(
					P.primerNombre
					, ' '
					, P.segundoNombre
					, ' '
					, P.primerApellido
					, ' '
					, P.segundoApellido
				) FROM Cliente C
				INNER JOIN Persona P ON P.idPersona = C.idCliente
				WHERE C.idCliente = OT.Cliente_idCliente
			) AS 'Cliente'
			, (
				SELECT numeroIdentidad FROM Cliente C
				INNER JOIN Persona P ON P.idPersona = C.idCliente
				WHERE C.idCliente = OT.Cliente_idCliente
			) AS 'numeroIdentidad'
			, CONCAT ( 
				(
					SELECT MA.descripcion FROM Modelo MO 
					INNER JOIN Marca MA ON MA.idMarca = MO.Marca_idMarca
					WHERE MO.idModelo = V.Modelo_idModelo
				)
				, ' '
				, (
					SELECT descripcion FROM Modelo MO WHERE MO.idModelo = V.Modelo_idModelo
				)
			) AS 'Vehiculo'
			, V.vin
			, (
				SELECT descripcion FROM EstadoOT WHERE idEstadoOT = OT.EstadoOT_idEstadoOT
			) AS 'EstadoOT'
		FROM OrdenTrabajo OT
		INNER JOIN Vehiculos V ON V.idVehiculos = OT.Vehiculos_idVehiculos
		INNER JOIN Cliente C ON C.idCliente = OT.Cliente_idCliente
		
        SET @pmensaje = 'Orden de Trabajo consultada con exito';
	END;

	-- En caso de no elegir una accion
	IF @paccion = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
