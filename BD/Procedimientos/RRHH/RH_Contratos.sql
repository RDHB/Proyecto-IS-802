-- <=== RH_Contratos ===>
/* Requisitos de las acciones:
 * INSERT: @pnumeroIdentidad, @psueldo, @phoraInicio,
 * @phoraFin, @pidTipoContrato, @pidAreaTrabajo, @pidCargo, @paccion
 * 
 * Salida: @pcodigoEmpleado
*/


CREATE PROCEDURE RH_CONTRATOS (
    -- Parametros de Entrada
	@pnumeroIdentidad			VARCHAR(45),
	@psueldo					DECIMAL,
	@phoraInicio				TIME,
	@phoraFin					TIME,
	@pidTipoContrato			INT,
	@pidAreaTrabajo				INT,
	@pidCargo					INT,
    @paccion					VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje				INT OUTPUT,
	@pmensaje 					VARCHAR(1000) OUTPUT,

    -- Otros parametros de salida
	@pcodigoEmpleado			VARCHAR(45) OUTPUT
) AS
BEGIN
    -- Declaracion de Variables
    DECLARE	@vconteo INT
	, @vidEmpleado INT
	, @vidPersona INT
	, @vidContrato INT
	;



    /* Funcionalidad: Contratar Personal
     * Construir un select con la sigueinte informacion:
     * Datos: @pnumeroIdentidad, @psueldo, @phoraInicio,
	 * @phoraFin, @pidTipoContrato, @pidAreaTrabajo, @pidCargo, @pcodigoEmpleado
     *
     * Insertar los sigueintes datos en la tabla Empleado:
     * idEmpleado, codigoEmpleado, descripcion, jefeInmediato, Persona_idPersona, Cargo_idCargo, AreaTrabajo_idAreaTrabajo
	 * 
	 * Insertar los sigueintes datos en la tabla ContratoPersonal:
     * idContratoPersonal, fechaContrato, sueldo, horaEntrada, horaSalida, TipoContrato_idTipoContrato
	 * 
	 * Insertar los sigueintes datos en la tabla Historico_Contratos:
     * idHistorico_Contratos, ContratoPersonal_idContratoPersonal, Empleado_idEmpleado
    */
    IF @paccion = 'INSERT' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pnumeroIdentidad = '' OR @pnumeroIdentidad IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' numeroIdentidad ';
		END;

		IF @psueldo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' sueldo ';
		END;
		
		IF @phoraInicio = '' OR @phoraInicio IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' horaInicio ';
		END;
		

		IF @phoraFin = '' OR @phoraFin IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' horaFin ';
		END;
		
		IF @pidTipoContrato = '' OR @pidTipoContrato IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' idTipoContrato ';
		END;
		
		IF @pidAreaTrabajo = '' OR @pidAreaTrabajo IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' idAreaTrabajo ';
		END;
		
		IF @pidCargo = '' OR @pidCargo IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' idCargo ';
		END;
		
		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
        SELECT @vconteo = COUNT(*) FROM Persona
		WHERE numeroIdentidad = @pnumeroIdentidad;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador idnumeroIdentidad => ' + CAST(@pnumeroIdentidad AS VARCHAR) + ' ';
		END;

		SELECT @vconteo = COUNT(*) FROM TipoContrato
		WHERE idTipoContrato = @pidTipoContrato;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador idTipoContrato => ' + CAST(@pidTipoContrato AS VARCHAR) + ' ';
		END;
		
		SELECT @vconteo = COUNT(*) FROM AreaTrabajo
		WHERE idAreaTrabajo = @pidAreaTrabajo;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador idAreaTrabajo => ' + CAST(@pidAreaTrabajo AS VARCHAR) + ' ';
		END;
		
		SELECT @vconteo = COUNT(*) FROM Cargo
		WHERE idCargo = @pidCargo;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador idCargo => ' + CAST(@pidCargo AS VARCHAR) + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de procedimientos
		-- Validar que la hora de entrada sea menor que la hora de salida
		IF @phoraInicio > @phoraFin BEGIN
			SET @pmensaje = @pmensaje + ' La hora de entrada es mayor que la hora de salia ';
		END;

		-- * La diferencia de la hora de entrada con la hora de salida debe ser mayor a 6 y menor a 10
		IF datediff(hh, @phoraInicio, @phoraFin) < 7 OR datediff(hh, @phoraInicio, @phoraFin) > 9 BEGIN
			SET @pmensaje = @pmensaje + ' La diferencia de horas debe de estar de 7 a 9 => ' + CAST(datediff(hh, @phoraInicio, @phoraFin) AS VARCHAR) + ' ';
		END;
		
		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procedimiento: ' + @pmensaje;
			RETURN;
		END;
		

		
		-- Accion del procedimiento 
		SET @vidPersona = (SELECT idPersona FROM Persona WHERE numeroIdentidad = @pnumeroIdentidad);
		SET @vidContrato = (SELECT MAX(idContratoPersonal) + 1 FROM ContratoPersonal);
		SET @vidEmpleado = (SELECT idEmpleado FROM Empleado WHERE Persona_idPersona = @vidPersona);
		
		
		SELECT @vconteo = COUNT(*) FROM Empleado 
		WHERE Persona_idPersona = @vidPersona;
		IF @vconteo = 0 BEGIN
			SET @vidEmpleado = (SELECT MAX(idEmpleado) + 1 FROM Empleado);
			SET @pcodigoEmpleado = (select dbo.FN_GENERAR_CODIGO_EMP('EMP',@vidEmpleado,4) AS CodigoEmpleado);
			-- Empleado
			INSERT INTO Empleado (
				idEmpleado
				, codigoEmpleado
				, descripcion
				, Persona_idPersona
				, Cargo_idCargo
				, AreaTrabajo_idAreaTrabajo
			) VALUES (
				@vidEmpleado
				, @pcodigoEmpleado
				, 'Recien Contratado'
				, @vidPersona
				, @pidCargo
				, @pidAreaTrabajo
			);
		END;
		UPDATE Empleado SET 
			Cargo_idCargo = @pidCargo
			, AreaTrabajo_idAreaTrabajo = @pidAreaTrabajo
		WHERE idEmpleado = @vidEmpleado;

		-- Contrato Personal
		INSERT INTO ContratoPersonal (
			idContratoPersonal
			, fechaContrato
			, sueldo
			, horaEntrada
			, horaSalida
			, TipoContrato_idTipoContrato
		) VALUES (
			@vidContrato
			, CONVERT(DATE, GETDATE())
			, @psueldo
			, @phoraInicio
			, @phoraFin
			, @pidTipoContrato
		);

		-- Historico_Contratos
		INSERT INTO Historico_Contratos (
			idHistorico_Contratos
			, ContratoPersonal_idContratoPersonal
			, Empleado_idEmpleado
		) VALUES (
			(SELECT MAX(idHistorico_Contratos) + 1 FROM Historico_Contratos)
			, @vidContrato
			, @vidEmpleado
		);


		-- Eliminar de Aspirante y Curriculum
		DELETE FROM Curriculum 
		WHERE Aspirante_idAspirante = (
			SELECT idAspirante FROM Aspirante
			WHERE Persona_idPersona = (
				SELECT idPersona FROM Persona
				WHERE numeroIdentidad = @pnumeroIdentidad
			)
		)
		DELETE FROM Aspirante 
		WHERE Persona_idPersona = (
			SELECT idPersona FROM Persona
			WHERE numeroIdentidad = @pnumeroIdentidad
		)

        SET @pmensaje = 'Personal Contratado';
	END;
    
	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
