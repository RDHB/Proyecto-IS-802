-- <=== RH_Vacaciones ===>
/* Requisitos de las acciones:
 * INSERT: @pcodigoEmpleado,  @pcantidadDias, @pfechaInicio
 * Opcional: @pdescripcion
 * Salida: @pfechaFin, @pfechaReingreso
 * 
 * SELECT: @pcodigoEmpleado
 * Salida: @pnombreCompleto, @pcargo
*/
CREATE PROCEDURE RH_VACACIONES (
    -- Parametros de Entrada
	@pcodigoEmpleado			VARCHAR(45),
	@pcantidadDias				INT,
	@pfechaInicio				DATE,
	@pdescripcion				VARCHAR(45),
    @paccion					VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje				INT OUTPUT,
	@pmensaje 					VARCHAR(1000) OUTPUT,

    -- Otros parametros de salida
	@pfechaFin					DATE OUTPUT,
	@pfechaReingreso			DATE OUTPUT,
	@pnombreCompleto			VARCHAR(45) OUTPUT,
	@pcargo						VARCHAR(45) OUTPUT
) AS
BEGIN
    -- Declaracion de Variables
    DECLARE	@vconteo INT
		, @vidEmpleado INT = 0
		, @vidVacaiones INT = 0
		, @vdia INT = 0
	;



    /* Funcionalidad: Solicitud de Vacaciones
     * Construir un insert con la sigueinte informacion:
     * Datos: @pcodigoEmpleado,  @pcantidadDias, @pfechaInicio, @pfechaFin, @pfechaReingreso
     * Datos Opcionales: @pdescripcion
     *
     * Insertar los sigueintes datos en la tabla Vacaiones:
     * idVacaciones, cantidadDias, fechaInicio, fechaFin, fechaReingreso
	 * 
	 * Insertar los sigueintes datos en la tabla Solicitudes:
     * idSolicitudes, descripcion, Vacaciones_idVacaciones, Empleado_idEmpleado
    */
    IF @paccion = 'INSERT' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pcodigoEmpleado = '' OR @pcodigoEmpleado IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' codigoEmpleado ';
		END;

		IF @pcantidadDias = '' OR @pcantidadDias IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' cantidadDias ';
		END;

		IF @pfechaInicio = '' OR @pfechaInicio IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' fechaInicio ';
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
		
		-- Validar que la fecha de inicio no este entre una vacaciones ya existentes
		SELECT @vconteo = COUNT(*) FROM Vacaciones V
		INNER JOIN Solicitudes S ON S.Vacaciones_idVacaciones = V.idVacaciones
		WHERE @pfechaInicio BETWEEN fechaInicio AND fechaFin
		AND S.Empleado_idEmpleado = @vidEmpleado
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + ' La fecha de inicio esta entre una de vacaciones ya existente ';
		END;

		-- Un empleado no puede tener mas de tres solicitudes de vacaciones al año
		SELECT @vconteo = COUNT(*) FROM Vacaciones V
		INNER JOIN Solicitudes S ON S.Vacaciones_idVacaciones = V.idVacaciones
		WHERE S.Empleado_idEmpleado = @vidEmpleado
		AND DATEPART(YEAR, fechaInicio) = DATEPART(YEAR, GETDATE())
		IF @vconteo >= 3 BEGIN
			SET @pmensaje = @pmensaje + ' El empleado no puede tener mas de 3 solicitudes de vaciones en el mismo año ';
		END;

		-- Los dias de vacaciones no pueden superar los 40 dias
		IF @pcantidadDias > 40 BEGIN
			SET @pmensaje = @pmensaje + ' Los dias de vacaciones no pueden superar los 40 dias ';
		END;

		-- La fecha de inicio no puede empezar un Domingo
		IF DATENAME( WEEKDAY, @pfechaInicio ) = 'Sunday' BEGIN
			SET @pmensaje = @pmensaje + ' La fecha de inicio no puede empezar un Domingo ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;


		
		-- Accion del procedimiento
		SET @vidVacaiones = (SELECT MAX(idVacaciones) + 1 FROM Vacaciones);

		-- Establecer fechaFin
		SET @vdia = 1;
		SET @pfechaFin = @pfechaInicio;
		WHILE (@vdia < @pcantidadDias) BEGIN
			IF DATENAME( WEEKDAY, @pfechaFin ) <> 'Sunday' BEGIN
				SET @vdia += 1;
			END;
			SET @pfechaFin = DATEADD(DAY, 1, @pfechaFin);
		END;

		-- Establecer fechaReingreso
		SET @vdia = 1;
		SET @pfechaReingreso = @pfechaFin;
		WHILE (@vdia <= 1) BEGIN
			SET @pfechaReingreso = DATEADD(DAY, 1, @pfechaReingreso);
			IF DATENAME( WEEKDAY, @pfechaReingreso ) <> 'Sunday' BEGIN
				SET @vdia += 1;
			END;
		END;

		-- Insert Vacaciones
		INSERT INTO Vacaciones(
			idVacaciones
			, cantidadDias
			, fechaInicio
			, fechaFin
			, fechaRetorno
		) VALUES (
			@vidVacaiones
			, @pcantidadDias
			, @pfechaInicio
			, @pfechaFin
			, @pfechaReingreso
		);

		-- Insert Solicitudes
		INSERT INTO Solicitudes(
			idSolicitudes
			, descripcion
			, Vacaciones_idVacaciones
			, Empleado_idEmpleado
		) VALUES (
			(SELECT MAX(idSolicitudes) + 1 FROM Solicitudes)
			, @pdescripcion
			, @vidVacaiones
			, @vidEmpleado
		);

        SET @pmensaje = 'Vacaciones registradas con exito';
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
