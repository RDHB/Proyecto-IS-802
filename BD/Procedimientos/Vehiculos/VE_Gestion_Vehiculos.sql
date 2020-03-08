-- <=== Pantalla ===>
/* Requisitos de las acciones:
 * INSERT: @pvin, @pcolor, @pplaca, @pnumeroMotor, @pcaja_de_cambios, @pidModelo, @paccion
 * 
 * <ACCION 2>: ...
*/
CREATE PROCEDURE VE_GESTION_VEHICULOS(
    -- Parametros de Entrada
    @pvin	 							VARCHAR(45),
	@pcolor								VARCHAR(45),
	@pplaca								VARCHAR(45),
	@pnumeroMotor						VARCHAR(45),
	@pcaja_de_cambios					VARCHAR(45),
	@pidModelo							INT,
    @paccion							VARCHAR(45),
    
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje				INT OUTPUT,
	@pmensaje 					VARCHAR(1000) OUTPUT

    -- Otros parametros de salida

)AS
BEGIN
    -- Declaracion de Variables
    DECLARE	@vconteo INT;
	


    /* Funcionalidad: Registrar Cliente
    * Construir un INSERT con la sigueinte informacion:
    * Datos: @pvin, @pcolor, @pplaca, @pnumeroMotor, @pcaja_de_cambios, @pidModelo, @paccion
    *
    * Insertar los sigueintes datos en la tabla Vehiculos:
    * idVehiculo, vin, color, placa, numeroMotor, caja_de_cambios, Modelo_idModelo
    */
    IF @paccion = 'INSERT' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje = 0;
		SET @pmensaje = '';
		


		-- Validacion de campos nulos
		IF @pvin = '' OR @pvin IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' vin ';
		END;
		
		IF @pcolor = '' OR @pcolor IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' color ';
		END;

		IF @pplaca = '' OR @pplaca IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' placa ';
		END;

		IF @pnumeroMotor = '' OR @pnumeroMotor IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' numeroMotor ';
		END;
		
		IF @pcaja_de_cambios = '' OR @pcaja_de_cambios IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' caja_de_cambios ';
		END;

		IF @pidModelo = '' OR @pidModelo IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' idModelo ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
        SELECT @vconteo = COUNT(*) FROM Vehiculos
		WHERE vin = @pvin;
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + ' Ya existe el identificador => ' + @pvin + ' ';
		END;

		SELECT @vconteo = COUNT(*) FROM Modelo
		WHERE idModelo = @pidModelo;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + CAST(@pidModelo AS VARCHAR) + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de procedimientos



		-- Accion del procedimiento
		-- INSERT Vehiculos
		INSERT INTO Vehiculos(
			idVehiculos
			, vin
			, color
			, placa
			, numeroMotor
			, caja_de_cambios
			, Modelo_idModelo
		) 
		VALUES (
			(SELECT MAX(idVehiculos) + 1 FROM Vehiculos)
			, @pvin
            , @pcolor
            , @pplaca
            , @pnumeroMotor
            , @pcaja_de_cambios
            , @pidModelo
		);

        SET @pmensaje = 'Vehiculo añadido con exito';
	END;
    
	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
