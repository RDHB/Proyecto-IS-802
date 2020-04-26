-- <=== RH_Permisos ===>
/* Requisitos de las acciones:
 * INSERT: @pcodigoEmpleado,  @pmotivo, @pfecha
 * Opcional: @pdescripcion
 * 
 * SELECT: @pcodigoEmpleado
 * Salida: @pnombreCompleto, @pcargo
*/
ALTER PROCEDURE [dbo].[RH_PERMISOS] (
    -- Parametros de Entrada
	@pcodigoEmpleado			VARCHAR(45),
	@pmotivo					VARCHAR(45),
	@pfecha						DATE,
	@pdescripcion				VARCHAR(45),
    @paccion					VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje				INT OUTPUT,
	@pmensaje 					VARCHAR(1000) OUTPUT,

    -- Otros parametros de salida
	@pnombreCompleto			VARCHAR(45) OUTPUT,
	@pcargo						VARCHAR(45) OUTPUT
) AS
BEGIN
    -- Declaracion de Variables
    DECLARE	@vconteo INT
		, @vidEmpleado INT = 0
		, @vidPermisos INT = 0
		, @vhoraEntrada TIME = ''
		, @vhoraSalida TIME = ''
	;



    /* Funcionalidad: Solicitud de Permisos Especiales
     * Construir un insert con la sigueinte informacion:
     * Datos: @pcodigoEmpleado,  @pmotivo, @pfecha
     * Datos Opcionales: @pdescripcion
     *
     * Insertar los sigueintes datos en la tabla Permisos:
     * idPermisos, motivo, fecha
	 * 
	 * Insertar los sigueintes datos en la tabla Solicitudes:
     * idSolicitudes, descripcion, Permisos_idPermisos, Empleado_idEmpleado
	 *
	 * Insertar los sigueintes datos en la tabla Huella:
     * idHuella, descripcion, horaEntrada, horaSalida, fecha, Empleado_idEmpleado
    */
    IF @paccion = 'INSERT' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pcodigoEmpleado = '' OR @pcodigoEmpleado IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' codigoEmpleado ';
		END;

		IF @pmotivo = '' OR @pmotivo IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' motivo ';
		END;

		IF @pfecha = '' OR @pfecha IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' fecha ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
        SELECT @vconteo = COUNT(*) FROM Empleado
		WHERE codigoEmpleado = @pcodigoEmpleado;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pcodigoEmpleado + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de procedimientos
		SET @vidEmpleado = (SELECT idEmpleado FROM Empleado WHERE codigoEmpleado = @pcodigoEmpleado)

		SELECT @vconteo = COUNT(*) FROM Permisos P
		INNER JOIN Solicitudes S ON P.idPermisos = S.Permisos_idPermisos
		WHERE Empleado_idEmpleado = @vidEmpleado;
		IF @vconteo >= 5 BEGIN
			SET @pmensaje = 'Error: El empleado no puede tener mas de 5 permisos especiales al mes';
		END;

		SELECT @vconteo = COUNT(*) FROM Permisos P
		INNER JOIN Solicitudes S ON P.idPermisos = S.Permisos_idPermisos
		WHERE Empleado_idEmpleado = @vidEmpleado
		AND fecha = @pfecha;
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = 'Error: El empleado no puede tener mas de 1 permiso en el mismo día';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;


		
		-- Accion del procedimiento
		SET @vidPermisos = (SELECT MAX(idPermisos) + 1 FROM Permisos);

		SET @vhoraEntrada =  (
			SELECT horaEntrada FROM ContratoPersonal
			WHERE idContratoPersonal = (
				SELECT MAX(idContratoPersonal) FROM Empleado E
				INNER JOIN Historico_Contratos HC ON HC.Empleado_idEmpleado = E.idEmpleado
				INNER JOIN ContratoPersonal C ON C.idContratoPersonal = HC.ContratoPersonal_idContratoPersonal
				WHERE E.codigoEmpleado = @pcodigoEmpleado
			)
		)

		SET @vhoraSalida =  (
			SELECT horaSalida FROM ContratoPersonal
			WHERE idContratoPersonal = (
				SELECT MAX(idContratoPersonal) FROM Empleado E
				INNER JOIN Historico_Contratos HC ON HC.Empleado_idEmpleado = E.idEmpleado
				INNER JOIN ContratoPersonal C ON C.idContratoPersonal = HC.ContratoPersonal_idContratoPersonal
				WHERE E.codigoEmpleado = @pcodigoEmpleado
			)
		)

		-- Insert Permisos
		INSERT INTO Permisos (
			idPermisos
			, motivo
			, fecha
		) VALUES (
			@vidPermisos
			, @pmotivo
			, @pfecha
		);

		-- Insert Solicitudes
		INSERT INTO Solicitudes(
			idSolicitudes
			, descripcion
			, Permisos_idPermisos
			, Empleado_idEmpleado
		) VALUES (
			(SELECT MAX(idSolicitudes) + 1 FROM Solicitudes)
			, @pdescripcion
			, @vidPermisos
			, @vidEmpleado
		);

		-- Insert Huella
		INSERT INTO Huella(
			idHuella
			, descripcion
			, horaEntrada
			, horaSalida
			, fecha
			, Empleado_idEmpleado
		) VALUES (
			(SELECT MAX(idHuella) + 1 FROM Huella)
			, @pdescripcion
			, @vhoraEntrada
			, @vhoraSalida
			, @pfecha
			, @vidEmpleado
		);


        SET @pmensaje = 'Permiso registrado con exito';
	END;
    









	/* Funcionalidad: Seleccionar datos del empleado
     * Construir un Select con la sigueinte informacion:
     * Datos: @pcodigoEmpleado
     *
     * Seleccionar los sigueintes datos en la tabla Permisos:
     * idEmpleado
	 * 
	 * Seleccionar los sigueintes datos en la tabla Persona:
     * primerNombre, segundoNombre, primerApellido, segundoApellido
	 *
	 * Insertar los sigueintes datos en la tabla Cargo:
     * descripcion
    */
    IF @paccion = 'SELECT' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pcodigoEmpleado = '' OR @pcodigoEmpleado IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' codigoEmpleado ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
        SELECT @vconteo = COUNT(*) FROM Empleado
		WHERE codigoEmpleado = @pcodigoEmpleado;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pcodigoEmpleado + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Accion del procedimiento
		SET @vidEmpleado = (SELECT idEmpleado FROM Empleado WHERE codigoEmpleado = @pcodigoEmpleado)

		SET @pnombreCompleto = (
			SELECT CONCAT(
				P.primerNombre
				, ' '
				, P.segundoNombre
				, ' '
				, P.primerApellido
				, ' '
				, P.segundoApellido
			) FROM Persona P
			INNER JOIN Empleado E ON E.Persona_idPersona = P.idPersona
			WHERE idEmpleado = @vidEmpleado
		);

		SET @pcargo = (
			SELECT C.descripcion FROM Empleado E
			INNER JOIN Cargo C ON C.idCargo = E.Cargo_idCargo
			WHERE idEmpleado = @vidEmpleado
		);


        SET @pmensaje = 'Datos consultados con exito';
	END;


	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
