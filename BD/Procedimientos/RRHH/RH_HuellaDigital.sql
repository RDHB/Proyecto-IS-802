-- <=== RH_Huella ===>
/* Requisitos de las acciones:
 * INSERTAR: @pcodigoEmpleado, @phoraEntrada, @phoraSalida, @pfecha, @paccion
 * Opcional: @pdescripcion
 * 
 * SELECT-EMPLEADO: @pcodigoEmpleado
 * SALIDA: @pAreaTrabajo, @pCargo
 * 
 * SELECT-HUELLA: @pcodigoEmpleado, @pfecha
 * SALIDA: @pdescripcion, @phoraEntrada, @phoraSalida
*/
CREATE PROCEDURE RH_HUELLA (
    -- Parametros de Entrada
	@pcodigoEmpleado				VARCHAR(45),
	@pfecha							DATE,
    @paccion						VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje					INT OUTPUT,
	@pmensaje 						VARCHAR(1000) OUTPUT,

    -- Otros parametros de salida @pAreaTrabajo, @pCargo
	@pCargo 						VARCHAR(1000) OUTPUT,
	@pAreaTrabajo 					VARCHAR(1000) OUTPUT,
	@pdescripcion					VARCHAR(45) OUTPUT,
	@phoraEntrada					TIME OUTPUT,
	@phoraSalida					TIME OUTPUT
) AS
BEGIN
    -- Declaracion de Variables
    DECLARE	@vconteo INT;



    /* Funcionalidad: Insertar/Modificar Huella
     * Insert/update con la sigueinte informacion:
     * Datos: @pcodigoEmpleado, @phoraEntrada, @phoraSalida, @pfecha
     * Datos Opcionales: @pdescripcion
     *
     * Insertar/Actualizar los sigueintes datos en la tabla Huella:
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

		IF @phoraEntrada = '' OR @phoraEntrada IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' horaEntrada ';
		END;

		IF @phoraSalida = '' OR @phoraSalida IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' horaSalida ';
		END;

		IF @pfecha = '' OR @pfecha IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' @pfecha ';
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
			SET @pmensaje = @pmensaje + ' No existe el identificador codigoEmpleado=> ' + @pcodigoEmpleado + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de procedimientos
		/* Recomendaciones:
		 * Validar que la hora de entrada sea menor que la hora de salida
		 * Todas las huellas deben comprender por lo menos 1 hora y maximo durar 11 horas
		 * Las huellas deben crearse en el mismo dia si se utiliza la maquina, si no deben crearse en un rango de un mes del dia actual
		 * El empleado no puede tener mas de una huella en el mismo dia
		*/
		-- Validar que la hora de entrada sea menor que la hora de salida
		IF @phoraEntrada > @phoraSalida BEGIN
			SET @pmensaje = @pmensaje + ' La hora de entrada es mayor que la hora de salia ';
		END;

		-- La diferencia de la hora de entrada con la hora de salida debe ser mayor a 0 y menor a 12
		IF datediff(hh, @phoraEntrada, @phoraSalida) < 1 OR datediff(hh, @phoraEntrada, @phoraSalida) > 11 BEGIN
			SET @pmensaje = @pmensaje + ' La diferencia de horas debe de estar de 7 a 9 => ' + CAST(datediff(hh, @phoraEntrada, @phoraSalida) AS VARCHAR) + ' ';
		END;

		-- Las huellas deben crearse en un rango de un mes al dia actual
		IF @pfecha NOT BETWEEN DATEADD(MONTH, -2,GETDATE()) AND GETDATE() BEGIN
			SET @pmensaje = @pmensaje + ' Ha experido el perido para ingresar horas trabajadas ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;


		
		-- Accion del procedimiento 
		SELECT @vconteo = COUNT(*) FROM Empleado E
		INNER JOIN Huella H ON H.Empleado_idEmpleado = E.idEmpleado
		WHERE E.codigoEmpleado = @pcodigoEmpleado
		AND fecha = @pfecha;
		
		IF @vconteo = 0 BEGIN
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
				, @phoraEntrada
				, @phoraSalida
				, @pfecha
				, (SELECT idEmpleado FROM Empleado WHERE codigoEmpleado = @pcodigoEmpleado)
			);
		END;

		-- Actualizar informacion
		UPDATE Huella SET 
		descripcion = @pdescripcion
		, horaEntrada = @phoraEntrada
		, horaSalida = @phoraSalida
		WHERE Empleado_idEmpleado = (SELECT idEmpleado FROM Empleado WHERE codigoEmpleado = @pcodigoEmpleado)
		AND fecha = @pfecha;

        SET @pmensaje = 'Horas registradas con exito';
	END;
    








	/* Funcionalidad: Seleccionar Empleado
     * Construir un select con la sigueinte informacion:
     * Datos: @pcodigoEmpleado
     *
     * Seleccionar los sigueintes datos en la tabla AreaTrabajo:
     * descripcion
	 *
	 * Seleccionar los sigueintes datos en la tabla Cargo:
     * descripcion
    */
	IF @paccion = 'SELECT-EMPLEADO' BEGIN
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
		SET @pAreaTrabajo = (
			SELECT descripcion FROM AreaTrabajo 
			WHERE idAreaTrabajo = (SELECT AreaTrabajo_idAreaTrabajo FROM Empleado WHERE codigoEmpleado = @pcodigoEmpleado)
		);

		SET @pCargo = (
			SELECT descripcion FROM Cargo 
			WHERE idCargo = (SELECT Cargo_idCargo FROM Empleado WHERE codigoEmpleado = @pcodigoEmpleado)
		);

        SET @pmensaje = 'Consulta finalizada con exito';
	END;










	/* Funcionalidad: Seleccionar Huella
     * Construir un select con la sigueinte informacion:
     * Datos: @pcodigoEmpleado, @pfecha
     *
     * Seleccionar los sigueintes datos en la tabla Huella:
     * descripcion, horaEntrada, horaSalida
    */
	IF @paccion = 'SELECT-HUELLA' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pcodigoEmpleado = '' OR @pcodigoEmpleado IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' codigoEmpleado ';
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



		-- Accion del procedimiento 
		SET @pdescripcion = (
			SELECT descripcion FROM Huella
			WHERE Empleado_idEmpleado = (SELECT idEmpleado FROM Empleado WHERE codigoEmpleado = @pcodigoEmpleado)
			AND fecha = @pfecha
		);

		SET @phoraEntrada = (
			SELECT horaEntrada FROM Huella
			WHERE Empleado_idEmpleado = (SELECT idEmpleado FROM Empleado WHERE codigoEmpleado = @pcodigoEmpleado)
			AND fecha = @pfecha
		);
		
		SET @phoraSalida = (
			SELECT horaSalida FROM Huella
			WHERE Empleado_idEmpleado = (SELECT idEmpleado FROM Empleado WHERE codigoEmpleado = @pcodigoEmpleado)
			AND fecha = @pfecha
		);


        SET @pmensaje = 'Consulta finalizad con exito';
	END;

	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
