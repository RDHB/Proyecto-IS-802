-- <=== Pantalla ===>
/* Requisitos de las acciones:
 * INSERT: @pidAreaTrabajo, @phoraInicio, @phoraFin, @pfecha
 * 
 * SELECT: @pidAreaTrabajo, @pfecha
 * Salida: @phoraInicio, @phoraFin
*/
CREATE PROCEDURE RH_HORAS_EXTRAS (
    -- Parametros de Entrada
	@pidAreaTrabajo				VARCHAR(45),
	@phoraInicio				VARCHAR(45) OUTPUT,
	@phoraFin					VARCHAR(45) OUTPUT,
	@pfecha						VARCHAR(45),
    @paccion					VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje				INT OUTPUT,
	@pmensaje 					VARCHAR(1000) OUTPUT
) AS
BEGIN
    -- Declaracion de Variables
    DECLARE	@vconteo INT
		,@vidHoras_extras INT
	;



    /* Funcionalidad: <nombre_funcionalidad>
     * Construir un insert con la sigueinte informacion:
     * Datos: @pidAreaTrabajo, @phoraInicio, @phoraFin, @pfecha
     *
     * Insertar los sigueintes datos en la tabla Horas_extras:
     * idHoras_extras, horaInicio, horaFin, fecha
	 * 
	 * Insertar los sigueintes datos en la tabla Historico_HE:
     * idHistorico_HE, AreaTrabajo_idAreaTrabajo, Horas_extras_idHoras_extras
    */
    IF @paccion = 'INSERT' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pidAreaTrabajo = '' OR @pidAreaTrabajo IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' idAreaTrabajo ';
		END;

		IF @phoraInicio = '' OR @phoraInicio IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' horaInicio ';
		END;

		IF @phoraFin = '' OR @phoraFin IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' horaFin ';
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
        SELECT @vconteo = COUNT(*) FROM AreaTrabajo
		WHERE idAreaTrabajo = @pidAreaTrabajo;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador idAreaTrabajo=> ' + CAST(@pidAreaTrabajo AS VARCHAR) + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de procedimientos
		-- Validar que la hora de inicio sea menor que la hora fin
		IF @phoraInicio > @phoraFin BEGIN
			SET @pmensaje = @pmensaje + ' La hora de entrada es mayor que la hora de salia ';
		END;

		-- Todas las horas extras deben empezar a partir de las 4 de la tarde
		IF DATEPART(HOUR, @phoraInicio) < 16 BEGIN
			SET @pmensaje = @pmensaje + ' Las horas extras deben empezar a partir de las 16:00 horas ';
		END;

		-- La diferencia de la hora de inicio con la hora de fin debe ser mayor a 0 y menor a 12
		IF datediff(hh, @phoraInicio, @phoraFin) < 0 OR datediff(hh, @phoraInicio, @phoraFin) > 3 BEGIN
			SET @pmensaje = @pmensaje + ' La diferencia de horas debe ser de 1 a 3 horas => ' + CAST(datediff(hh, @phoraInicio, @phoraFin) AS VARCHAR) + ' ';
		END;

		-- Las Horas Extras deben crearse en un rango de un mes a la fecha actual y deben empezar dentro de un dia a la fecha actual
		IF @pfecha NOT BETWEEN DATEADD(DAY, 1, CONVERT(DATE, GETDATE())) AND DATEADD(MONTH, 1,CONVERT(DATE, GETDATE())) BEGIN
			SET @pmensaje = @pmensaje + ' Las horas extras se pueden crear en un rango de 1 mes a la fecha actual y no puden crearse para el mismo dia ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;


		
		-- Accion del procedimiento 
		SELECT @vconteo = COUNT(*) FROM Horas_extras HE
		INNER JOIN Historico_HE HHE ON HHE.Horas_extras_idHoras_extras = HE.idHoras_extras
		WHERE HHE.AreaTrabajo_idAreaTrabajo = @pidAreaTrabajo
		AND HE.fecha = @pfecha;
		
		IF @vconteo = 0 BEGIN
			SET @vidHoras_extras = (SELECT MAX(idHoras_extras) + 1 FROM Horas_extras);
			INSERT INTO Horas_extras(
				idHoras_extras
				, horaInicio
				, horaFin
				, fecha
			) VALUES (
				@vidHoras_extras
				, @phoraInicio
				, @phoraFin
				, @pfecha
			);

			INSERT INTO Historico_HE(
				idHistorico_HE
				, AreaTrabajo_idAreaTrabajo
				, Horas_extras_idHoras_extras
			) VALUES (
				(SELECT MAX(idHistorico_HE) + 1 FROM Historico_HE)
				, @pidAreaTrabajo
				, @vidHoras_extras
			);
		END;


		
		-- Actualizar informacion
		UPDATE Horas_extras SET 
		horaInicio = @phoraInicio
		, horaFin = @phoraFin
		WHERE idHoras_extras = (
			SELECT Horas_extras_idHoras_extras FROM Historico_HE HHE
			INNER JOIN Horas_extras HE ON HE.idHoras_extras = HHE.Horas_extras_idHoras_extras
			WHERE HHE.AreaTrabajo_idAreaTrabajo = @pidAreaTrabajo
			AND HE.fecha = @pfecha
		);


        SET @pmensaje = 'Horas Extras registradas con exito';
	END;
    









	/* Funcionalidad: <nombre_funcionalidad>
     * Construir un select con la sigueinte informacion:
     * Datos: @pidAreaTrabajo, @pfecha
     *
     * Seleccionar los sigueintes datos en la tabla Horas_extras:
     * horaInicio, horaFin
    */
    IF @paccion = 'SELECT' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pidAreaTrabajo = '' OR @pidAreaTrabajo IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' idAreaTrabajo ';
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
        SELECT @vconteo = COUNT(*) FROM AreaTrabajo
		WHERE idAreaTrabajo = @pidAreaTrabajo;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador idAreaTrabajo=> ' + CAST(@pidAreaTrabajo AS VARCHAR) + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Accion del procedimiento 
		SET @phoraInicio = (
			SELECT HE.horaInicio FROM Horas_extras HE
			INNER JOIN Historico_HE HHE ON HHE.Horas_extras_idHoras_extras = HE.idHoras_extras
			WHERE HHE.AreaTrabajo_idAreaTrabajo = @pidAreaTrabajo
			AND HE.fecha = @pfecha
		);

		SET @phoraFin = (
			SELECT HE.horaFin FROM Horas_extras HE
			INNER JOIN Historico_HE HHE ON HHE.Horas_extras_idHoras_extras = HE.idHoras_extras
			WHERE HHE.AreaTrabajo_idAreaTrabajo = @pidAreaTrabajo
			AND HE.fecha = @pfecha
		);


        SET @pmensaje = 'Consulta finalizada con exito';
	END;



	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
