-- <=== OT_A_CONTRATAR_SERVICIOS ===>
/* Requisitos de las acciones:
 * INSERT: @pnumeroOT, @pidServicios
 * 
 * SELECT: @pnumeroOT
 * Salida: idOrdenTrabajo, numeroOT, idServicio, nombre, servicioEfectuado, precioCosto, duracion
 *
 * DELETE: @pnumeroOT, @pidServicios
 * 
 * SAVE: @pnumeroOT
*/
CREATE OR ALTER PROCEDURE OT_A_CONTRATAR_SERVICIOS (
    -- Parametros de Entrada
	@pnumeroOT					VARCHAR(45),
	@pidServicios				INT,
    @paccion					VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje				INT OUTPUT,
	@pmensaje 					VARCHAR(1000) OUTPUT

    -- Otros parametros de salida

) AS
BEGIN
    -- Declaracion de Variables
    DECLARE	@vconteo INT
		, @vservicioEfectuado INT = 0
	;



    /* Funcionalidad: Contratar Sericios
     * Construir un insert con la sigueinte informacion:
     * Datos: @pnumeroOT, @pidServicios
     *
     * Insertar los sigueintes datos en la tabla Lista_Servicios:
     * OrdenTrabajo_idOrdenTrabajo, Servicios_idServicios, servicioEfectuado = 0
    */
    IF @paccion = 'INSERT' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';
		SET @vservicioEfectuado=0;



		-- Validacion de campos nulos
		IF @pnumeroOT = '' OR @pnumeroOT IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' numeroOT ';
		END;

		IF @pidServicios = 0 BEGIN
			SET @pmensaje = @pmensaje + ' idServicios ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
        SELECT @vconteo = COUNT(*) FROM OrdenTrabajo
		WHERE numeroOT = @pnumeroOT;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pnumeroOT + ' ';
		END;

		SELECT @vconteo = COUNT(*) FROM Servicios
		WHERE idServicios = @pidServicios;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + CAST(@pidServicios AS VARCHAR) + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de procedimientos
		-- En la orden de trabajo no pueden contratarse dos servicios del mismo tipo
		SELECT @vconteo=COUNT(*) FROM OrdenTrabajo OT
		INNER JOIN Lista_Servicios LS ON LS.OrdenTrabajo_idOrdenTrabajo = OT.idOrdenTrabajo
		WHERE numeroOT = @pnumeroOT
		AND LS.Servicios_idServicios = @pidServicios
		IF @vconteo <> 0 BEGIN
			SET @pmensaje= @pmensaje + ' Ya esta este servicio en la orden de Trabajo';
		END;

		-- No se puede dar reivision del vehiculo en este momento, consulte el estado de la Orden de Trabajo
		SELECT @vconteo=COUNT(*) FROM OrdenTrabajo
		WHERE EstadoOT_idEstadoOT = 2 AND numeroOT = @pnumeroOT
		IF @vconteo = 0 BEGIN
			SET @pmensaje= @pmensaje + ' No se puede contratar servicios en este momento, consulte el estado de la Orden de Trabajo';
		END;
		
		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;



		-- Accion del procedimiento 
		INSERT Lista_Servicios (
			OrdenTrabajo_idOrdenTrabajo
			, Servicios_idServicios
			, servicioEfectuado
		)
		VALUES (
			(SELECT idOrdenTrabajo FROM OrdenTrabajo WHERE numeroOT = @pnumeroOT)
			, @pidServicios
			, @vservicioEfectuado
		);

        SET @pmensaje = 'Servicio contratado con exito';
	END;
    









	/* Funcionalidad: Consultar Sericios
     * Construir un select con la sigueinte informacion:
     * Datos: @pnumeroOT
	 * Salida: idOrdenTrabajo, numeroOT, idServicio, nombre, servicioEfectuado, precioCosto, duracion
     *
     * Seleccionar los sigueintes datos en la tabla Lista_Servicios y Servicios:
     * OrdenTrabajo_idOrdenTrabajo, numeroOT, Servicios_idServicios, nombre, servicioEfectuado, precioCosto, duracion
    */
    IF @paccion = 'SELECT' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pnumeroOT = '' OR @pnumeroOT IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' numeroOT ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
        SELECT @vconteo = COUNT(*) FROM OrdenTrabajo
		WHERE numeroOT = @pnumeroOT;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pnumeroOT + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de procedimientos
		-- No hay validaciones del procedimiento
		


		-- Accion del procedimiento 
		SELECT 
			T.OrdenTrabajo_idOrdenTrabajo AS 'idOrdenTrabajo'
			, (
				SELECT numeroOT FROM OrdenTrabajo OT
				WHERE OT.idOrdenTrabajo = T.OrdenTrabajo_idOrdenTrabajo
			) AS 'numerOT'
			, S.idServicios
			, S.nombre
			, T.servicioEfectuado AS 'servicioEfectuado'
			, S.precioCosto
			, S.duracion
		FROM (
			SELECT 
				LS.OrdenTrabajo_idOrdenTrabajo
				, LS.Servicios_idServicios 
				, LS.servicioEfectuado
			FROM Lista_Servicios LS
			WHERE OrdenTrabajo_idOrdenTrabajo = (
				SELECT idOrdenTrabajo FROM OrdenTrabajo
				WHERE numeroOT = @pnumeroOT
			)
		) AS T
		RIGHT JOIN Servicios S ON T.Servicios_idServicios = S.idServicios
		ORDER BY idOrdenTrabajo DESC, idServicios ASC
		
		
        SET @pmensaje = 'Consulta finalizada con exito';
	END;










	/* Funcionalidad: Cancelar Sericios
     * Construir un delete con la sigueinte informacion:
     * Datos: @pnumeroOT, @pidServicios
     *
     * Borrar los sigueintes datos en la tabla Lista_Servicios segun los siguientes campos:
     * OrdenTrabajo_idOrdenTrabajo = idOrdenTrabajo, Servicios_idServicios = @pidServicios
    */
    IF @paccion = 'DELETE' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pnumeroOT = '' OR @pnumeroOT IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' @pnumeroOT ';
		END;

		IF @pidServicios = '' OR @pidServicios IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' idServicios ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
        SELECT @vconteo = COUNT(*) FROM OrdenTrabajo
		WHERE numeroOT = @pnumeroOT;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pnumeroOT + ' ';
		END;

		SELECT @vconteo = COUNT(*) FROM Servicios
		WHERE idServicios = @pidServicios;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + CAST(@pidServicios AS VARCHAR) + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de procedimientos
		-- Solo se pueden borrar servicios a ordenes de trabajo que no esten finalizadas. Es decir idEstadoOT = 13
		SELECT @vconteo=COUNT(*) FROM OrdenTrabajo
		WHERE EstadoOT_idEstadoOT = 2 AND numeroOT=@pnumeroOT
		IF @vconteo = 0 BEGIN
			SET @pmensaje= @pmensaje + ' No se puede eliminar servicios en este momento, consulte el estado de la Orden de Trabajo';
		END;

		SELECT @vconteo=COUNT(*) FROM OrdenTrabajo OT
		INNER JOIN Lista_Servicios LS ON LS.OrdenTrabajo_idOrdenTrabajo = OT.idOrdenTrabajo
		WHERE numeroOT = @pnumeroOT
		AND LS.Servicios_idServicios = @pidServicios
		IF @vconteo = 0 BEGIN
			SET @pmensaje= @pmensaje + ' Este servicio no ha sido contratado';
		END;

		SELECT @vconteo=COUNT(*) FROM OrdenTrabajo OT
		INNER JOIN Lista_Servicios LS ON LS.OrdenTrabajo_idOrdenTrabajo = OT.idOrdenTrabajo
		WHERE numeroOT = @pnumeroOT
		AND LS.Servicios_idServicios = @pidServicios
		AND LS.servicioEfectuado = 1
		IF @vconteo <> 0 BEGIN
			SET @pmensaje= @pmensaje + ' El servicio ya se ha efectuado';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;

		-- Accion del procedimiento 
		DELETE FROM Lista_Servicios
		WHERE OrdenTrabajo_idOrdenTrabajo = (
			SELECT idOrdenTrabajo FROM OrdenTrabajo 
			WHERE numeroOT = @pnumeroOT
		)
		AND Servicios_idServicios = @pidServicios;

        SET @pmensaje = 'Servicio removido con exito';
	END;










	/* Funcionalidad: Guardar cambios
     * Construir un update con la sigueinte informacion:
     * Datos: @pnumeroOT
     *
     * Actualizar los sigueintes datos en la tabla OrdenTrabajo:
     * EstadoOT_idEstadoOT = 3
    */
    IF @paccion = 'SAVE' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pnumeroOT = '' OR @pnumeroOT IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' numeroOT ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
        SELECT @vconteo = COUNT(*) FROM OrdenTrabajo
		WHERE numeroOT = @pnumeroOT;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pnumeroOT + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de procedimientos
		SELECT @vconteo=COUNT(*) FROM OrdenTrabajo
		WHERE EstadoOT_idEstadoOT = 2 AND numeroOT=@pnumeroOT
		IF @vconteo = 0 BEGIN
			SET @pmensaje= @pmensaje + ' No se puede guardar cambios en este momento, consulte el estado de la Orden de Trabajo';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;
		


		-- Accion del procedimiento
		SELECT @vconteo = COUNT(*) FROM Lista_Servicios
		WHERE OrdenTrabajo_idOrdenTrabajo = (
			SELECT idOrdenTrabajo FROM OrdenTrabajo
			WHERE numeroOT = @pnumeroOT
		)
		AND servicioEfectuado = 0
		IF @vconteo = 0 BEGIN
			UPDATE OrdenTrabajo SET 
				EstadoOT_idEstadoOT = 11
			WHERE numeroOT = @pnumeroOT
		END ELSE BEGIN
			UPDATE OrdenTrabajo SET 
				EstadoOT_idEstadoOT = 3
			WHERE numeroOT = @pnumeroOT
		END;


		
        SET @pmensaje = 'Datos guardados con exito';
	END;

	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
