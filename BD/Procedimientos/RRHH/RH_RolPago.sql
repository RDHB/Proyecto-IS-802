-- <=== RH_ROLPAGO===>
/* Requisitos de las acciones:
 * INSERT: @pcodigoEmpleado
 * Opcional: @pcomisiones, @pdeducciones, @ppagoHE
 *
 * SELECT: @pcodigoEmpleado
*/
CREATE PROCEDURE RH_ROL_PAGO (
    -- Parametros de Entrada
    @pcodigoEmpleado			VARCHAR(45),
	@ppagoHE					DECIMAL(18,4),
	@pcomisiones				DECIMAL(18,4),
	@pdeducciones				DECIMAL(18,4),
    @paccion					VARCHAR(45),

    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje				INT OUTPUT,
	@pmensaje 					VARCHAR(1000) OUTPUT

    -- Otros parametros de salida
) AS
BEGIN
    -- Declaracion de Variables
    DECLARE	@vconteo INT = 0
		, @vidEmpleado INT = 0
		, @vfecha DATE = GETDATE()
		, @vcargo VARCHAR(45) = ''
		, @vsueldoBase DECIMAL(18,4) = 0
		, @vcantidadHE INT = 0
		, @vtotalPago DECIMAL(18,4) = 0
	;
	


    /* Funcionalidad: Efectuar_Pago
     * Construir un insert con la sigueinte informacion:
     * Datos: @pcodigoEmpleado
     * Datos Opcionales: @pcomisiones, @pdeducciones, @ppagoHE
     *
     * Insertar los sigueintes datos en la tabla RolPago:
     * idRolPago, cargo, fecha, sueldoBase, cantidadHE, PagoHE, comisiones, deducciones, totalPago, Empleado_idEmpleado
    */
    IF @paccion = 'INSERT' BEGIN
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
			SET @pmensaje = @pmensaje + ' No existe el identificador codigoEmpleado => ' + @pcodigoEmpleado + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de procedimientos
		/* Recomendaciones:
		 * El empleado solo puede tener un pago al mes
		*/
		-- El empleado solo puede tener un pago al mes
		SELECT @vconteo = COUNT(*) FROM RolPago
		WHERE Empleado_idEmpleado = (SELECT idEmpleado FROM Empleado WHERE codigoEmpleado = @pcodigoEmpleado)
		AND MONTH(fecha) = MONTH( GETDATE() ) 
		AND YEAR(fecha) = YEAR( GETDATE() )
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + ' El empleado ya se la ha pagado en el mes actual ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;


		
		-- Accion del procedimiento 
		SET @vidEmpleado = (
			SELECT idEmpleado FROM Empleado WHERE codigoEmpleado = @pcodigoEmpleado
		);

		SET @vcargo = (
			SELECT C.descripcion FROM Empleado E 
			INNER JOIN Cargo C ON C.idCargo = E.Cargo_idCargo 
			WHERE E.codigoEmpleado = @pcodigoEmpleado
		);

		SET @vsueldoBase = (
			SELECT sueldo FROM ContratoPersonal
			WHERE idContratoPersonal = (
				SELECT MAX(idContratoPersonal) FROM Empleado E
				INNER JOIN Historico_Contratos HC ON HC.Empleado_idEmpleado = E.idEmpleado
				INNER JOIN ContratoPersonal C ON C.idContratoPersonal = HC.ContratoPersonal_idContratoPersonal
				WHERE E.codigoEmpleado = @pcodigoEmpleado
			)
		);

		SET @vcantidadHE = (select dbo.FN_CANTIDAD_HE(@vidEmpleado,@vfecha) AS 'Cantidad Horas Extras');

		SET @vtotalPago = @vsueldoBase + (@ppagoHE * @vcantidadHE) + @pcomisiones - @pdeducciones;

		INSERT INTO RolPago (
			idRolPago
			, cargo
			, fecha
			, sueldoBase
			, cantidadHE
			, pagoHE
			, comisiones
			, deducciones
			, totalPago
			, Empleado_idEmpleado
		) VALUES (
			(SELECT MAX(idRolPago) + 1 FROM RolPago)
			, @vcargo
			, @vfecha
			, @vsueldoBase
			, @vcantidadHE
			, @ppagoHE
			, @pcomisiones
			, @pdeducciones
			, @vtotalPago
			, @vidEmpleado
		);

        SET @pmensaje = 'Sueldo del empleado pagado con exito';
	END;










	/* Funcionalidad: Consultar Informacion Post-Pago
     * Construir un select con la sigueinte informacion:
     * Datos: @pcodigoEmpleado
     *
     * Seleccionar los sigueintes datos en la tabla RolPago:
     * Cargo, sueldoBase, cantidadHE, PagoHE, comisiones, deducciones, fecha, totalPago
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
			SET @pmensaje = @pmensaje + ' No existe el identificador codigoEmpleado => ' + @pcodigoEmpleado + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;


		
		-- Accion del procedimiento 
		SET @vidEmpleado = (
			SELECT idEmpleado FROM Empleado WHERE codigoEmpleado = @pcodigoEmpleado
		);

		SET @vcargo = (
			SELECT C.descripcion FROM Empleado E 
			INNER JOIN Cargo C ON C.idCargo = E.Cargo_idCargo 
			WHERE E.codigoEmpleado = @pcodigoEmpleado
		);

		SET @vsueldoBase = (
			SELECT sueldo FROM ContratoPersonal
			WHERE idContratoPersonal = (
				SELECT MAX(idContratoPersonal) FROM Empleado E
				INNER JOIN Historico_Contratos HC ON HC.Empleado_idEmpleado = E.idEmpleado
				INNER JOIN ContratoPersonal C ON C.idContratoPersonal = HC.ContratoPersonal_idContratoPersonal
				WHERE E.codigoEmpleado = @pcodigoEmpleado
			)
		);

		SET @vcantidadHE = (select dbo.FN_CANTIDAD_HE(@vidEmpleado,@vfecha) AS 'Cantidad Horas Extras');

		SET @vtotalPago = @vsueldoBase + (@ppagoHE * @vcantidadHE) + @pcomisiones - @pdeducciones;

		SELECT
			@pcodigoEmpleado AS 'codigoEmpleado'
			, @vcargo AS 'cargo'
			, @vsueldoBase AS 'sueldoBase'
			, @vcantidadHE AS 'cantidadHE'
			, @ppagoHE AS 'pagoHE'
			, @pcomisiones AS 'comisiones'
			, @pdeducciones AS 'deducciones'
			, @vfecha AS 'fecha'
			, @vtotalPago AS 'totalPago'
		;

        SET @pmensaje = 'Consulta finalizada con exito';
	END;



	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
