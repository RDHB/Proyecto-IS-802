-- <=== Nombre_Funcion ===>
/* Parametros de entrada: @pidEmpleado, @pfecha
 * 
 * RETUNR: @vcantidad_HE INT
*/
CREATE FUNCTION FN_CANTIDAD_HE (
    -- Parametros de Entrada
    @pidEmpleado					INT,
    @pfecha							DATE
) 
-- Return
RETURNS INT --<TIPO_DATO>
AS BEGIN
    -- Declaracion de Variables
    DECLARE @vcantidad_HE INT = 0
		, @vhoraEntrada INT = 0
		, @vhoraSalida INT = 0
		, @vhora INT = 0
		, @vhoraInicio INT = 0
		, @vhoraFin INT = 0
		, @vdiaInicio DATE = ''
		, @vdiaFin DATE = ''
		, @vfechaDia DATE = ''
	;


	-- <=== {Codigo para saber las horas extras trabajadas por el empleado en el mes actual} ===>
	-- Dia Inicio del mes actual
	SELECT @vdiaInicio = DATEADD( d, 1, EOMONTH(@pfecha,-1) );
	
	-- Dia Fin del mes actual
	SELECT @vdiaFin = EOMONTH(@pfecha);
	
	-- Ciclo que recorre los dias del mes actual
	SET @vfechaDia = @vdiaInicio;
	WHILE (@vfechaDia <= @vdiaFin) BEGIN
		
		-- Hora Entrada del empleado
		SELECT @vhoraEntrada = DATEPART(HOUR, (
			SELECT horaEntrada FROM Huella
			WHERE Empleado_idEmpleado = @pidEmpleado
			AND fecha = @vfechaDia
		));
		
		-- Hora Salida del empleado
		SELECT @vhoraSalida = DATEPART(HOUR, (
			SELECT horaSalida FROM Huella
			WHERE Empleado_idEmpleado = @pidEmpleado
			AND fecha = @vfechaDia
		));
		
		-- Hora Extra Inicio del area de trabajo del empleado
		SELECT @vhoraInicio = DATEPART(HOUR, (
			SELECT horaInicio FROM Horas_extras
			WHERE idHoras_extras IN (
				SELECT Horas_extras_idHoras_extras FROM Historico_HE
				WHERE AreaTrabajo_idAreaTrabajo IN (
					SELECT AreaTrabajo_idAreaTrabajo FROM Empleado
					WHERE idEmpleado = @pidEmpleado
				)
			)
			AND fecha = @vfechaDia
		));

		-- Hora Extra Fin del area de trabajo del empleado
		SELECT @vhoraFin = DATEPART(HOUR, (
			SELECT horaFin FROM Horas_extras
			WHERE idHoras_extras IN (
				SELECT Horas_extras_idHoras_extras FROM Historico_HE
				WHERE AreaTrabajo_idAreaTrabajo IN (
					SELECT AreaTrabajo_idAreaTrabajo FROM Empleado
					WHERE idEmpleado = @pidEmpleado
				)
			)
			AND fecha = @vfechaDia
		));
		
		-- Ciclo que recorre las horas trabajadas del empleado por dia
		SET @vhora = @vhoraEntrada;
		WHILE (@vhora < @vhoraSalida) BEGIN
			IF (@vhora BETWEEN @vhoraInicio AND (@vhoraFin - 1) ) BEGIN
				SET @vcantidad_HE += 1;
			END;
			SET @vhora += 1;
		END;
		SET @vfechaDia = DATEADD( d, 1, @vfechaDia )
	END;
	-- <========================================================================================>


    RETURN @vcantidad_HE;
END;