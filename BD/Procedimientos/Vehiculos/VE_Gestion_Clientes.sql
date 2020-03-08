-- <=== VE_RegistrarCliente ===>
/* Requisitos de las acciones:
 * INSERT: @pprimerNombre, @pprimerapellido, @psegundoapellido, @pnumeroIdentidad, @pidGenero, @pnumeroTelefono, @paccion
 * Opcional:  @psegundoNombre, @pcorreoElectronico, @pdireccion
 * 
 * <ACCION 2>: ...
*/
CREATE PROCEDURE VE_GESTION_CLIENTES(
    -- Parametros de Entrada
	@pprimerNombre 						VARCHAR(45),
	@psegundoNombre						VARCHAR(45),
	@pprimerapellido					VARCHAR(45),
	@psegundoapellido					VARCHAR(45),
	@pcorreoElectronico					VARCHAR(45),
	@pdireccion							VARCHAR(45),
	@pnumeroIdentidad					VARCHAR(45),
	@pidGenero							INT,
	@pnumeroTelefono					VARCHAR(45),
    @paccion							VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje						INT OUTPUT,
	@pmensaje 							VARCHAR(1000) OUTPUT

    -- Otros parametros de salida

)AS
BEGIN
    -- Declaracion de Variables
    DECLARE	@vconteo INT;
	DECLARE @vfechaIngreso DATE;
	DECLARE @vidPersona INT;



    /* Funcionalidad: Registrar Cliente
    * Construir un INSERT con la sigueinte informacion:
    * Datos: @pprimerNombre, @pprimerapellido, @psegundoapellido, @pnumeroIdentidad, @pidGenero, @pnumeroTelefono, @paccion
	* Datos Opcionales:  @psegundoNombre, @pcorreoElectronico, @pdireccion
    *
    * Insertar los sigueintes datos en la tabla Persona:
    * Campos: idPersona, primerNombre, segundoNombre, primerapellido, segundoApellido, correoElectronico, direccion, numeroIdentidad, fechaIngreso, idGenero
	*
	* Insertar los sigueintes datos en la tabla Telefono:
	* Campos: idTelefono, numeroTelefono, Persona_idPersona
	*
	* Insertar los sigueintes datos en la tabla Cliente:
	* Campos: idCliente, descripcion, Persona_idPersona
    */
    IF @paccion = 'INSERT' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje = 0;
		SET @pmensaje = '';
		SET @vfechaIngreso = CONVERT(DATE, GETDATE());
		SELECT @vidPersona = MAX(idPersona) + 1 FROM Persona



		-- Validacion de campos nulos
		IF @pprimerNombre = '' OR @pprimerNombre IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' primerNombre ';
		END;
		
		IF @pprimerapellido = '' OR @pprimerapellido IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' primerapellido ';
		END;

		IF @psegundoapellido = '' OR @psegundoapellido IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' segundoApellido ';
		END;

		IF @pnumeroIdentidad = '' OR @pnumeroIdentidad IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' numeroIdentidad ';
		END;
		
		IF @pidGenero = '' OR @pidGenero IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' idGenero ';
		END;

		IF @pnumeroTelefono = '' OR @pnumeroTelefono IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' numeroTelefono ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
		SELECT @vconteo = COUNT(*) FROM Persona
		WHERE numeroIdentidad = @pnumeroIdentidad;
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + ' Ya existe el identificador => ' + @pnumeroIdentidad + ' ';
		END;

		SELECT @vconteo = COUNT(*) FROM Genero
		WHERE idGenero = @pidGenero;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + CAST(@pidGenero AS VARCHAR) + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de procedimientos



		-- Accion del procedimiento
		-- INSERT Persona
		INSERT INTO Persona (
			idPersona
			, primerNombre
			, segundoNombre
			, primerApellido
			, segundoApellido
			, correoElectronico
			, direccion
			, numeroIdentidad
			, fechaIngreso
			, Genero_idGenero
		) 
		VALUES (
			@vidPersona
			, @pprimerNombre
			, @psegundoNombre
			, @pprimerapellido
			, @psegundoapellido
			, @pcorreoElectronico
			, @pdireccion
			, @pnumeroIdentidad
			, @vfechaIngreso
			, @pidGenero
		);

		-- INSERT Telefono
		INSERT INTO Telefono (
			idTelefono
			, numeroTelefono
			, Persona_idPersona
		)
		VALUES (
			(SELECT MAX(idTelefono) + 1 FROM Telefono)
			, @pnumeroTelefono
			, @vidPersona
		);

		-- INSERT Cliente
		INSERT INTO Cliente (
			idCliente
			, descripcion
			, Persona_idPersona
		)
		VALUES (
			(SELECT MAX(idCliente) + 1 FROM Cliente)
			, ''
			, @vidPersona
		);

        SET @pmensaje = 'Cliente registrado con exito';
	END;
    
	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
