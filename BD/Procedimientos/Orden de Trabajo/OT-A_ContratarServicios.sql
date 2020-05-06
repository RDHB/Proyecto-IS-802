-- <=== OT_A_CONTRATAR_SERVICIOS ===>
/* Requisitos de las acciones:
 * INSERT: @pidOrdenTrabajo, @pidServicios
 * 
 * SELECT: @pidOrdenTrabajo
 * Salida: Hacer una consulta de las tablas Lista_Servicios y Servicios
 *			Los servicios que se muestren en pantalla deben corresponder al idOrdenTrabajo
 *			Usar RIGHT JOIN
 *
 * DELETE: @pidOrdenTrabajo, @pidServicios
*/

CREATE PROCEDURE OT_A_CONTRATAR_SERVICIOS (
    -- Parametros de Entrada
	@pidOrdenTrabajo			INT,
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
    DECLARE	@vconteo INT, @vservicioEfectuado INT;



    /* Funcionalidad: Contratar Sericios
     * Construir un insert con la sigueinte informacion:
     * Datos: @pidOrdenTrabajo, @pidServicios
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
		IF @pidOrdenTrabajo = '' OR @pidOrdenTrabajo IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' idOrdenTrabajo ';
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
		WHERE idOrdenTrabajo = @pidOrdenTrabajo;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + CAST(@pidOrdenTrabajo AS VARCHAR) + ' ';
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

		-- Solo se puede agregar servicios a ordenes de trabajo que no esten finalizadas. Es decir idEstadoOT = 13

		SELECT @vconteo=COUNT(*) FROM OrdenTrabajo ot
		INNER JOIN EstadoOT e ON ot.EstadoOT_idEstadoOT=e.idEstadoOT
		WHERE idEstadoOT=13 AND idOrdenTrabajo=@pidOrdenTrabajo
		IF @vconteo <> 0 BEGIN
			SET @pmensaje= @pmensaje + 'Solo se puede agregar servicios a ordenes de trabajo no finalizadas =>';
		END;
		
		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;

		-- Accion del procedimiento 
		INSERT Lista_Servicios (OrdenTrabajo_idOrdenTrabajo, Servicios_idServicios, servicioEfectuado)
		VALUES (@pidOrdenTrabajo, @pidServicios, @vservicioEfectuado);

        SET @pmensaje = 'Finalizado con exito';
	END;
    









	/* Funcionalidad: Consultar Sericios
     * Construir un select con la sigueinte informacion:
     * Datos: @pidOrdenTrabajo
     *
     * Seleccionar los sigueintes datos en la tabla Lista_Servicios y Servicios:
     * OrdenTrabajo_idOrdenTrabajo, Servicios_idServicios, servicioEfectuado, nombre, precioCosto, duracion
    */
    IF @paccion = 'SELECT' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pidOrdenTrabajo = '' OR @pidOrdenTrabajo IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' idOrdenTrabajo ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
        SELECT @vconteo = COUNT(*) FROM OrdenTrabajo
		WHERE idOrdenTrabajo = @pidOrdenTrabajo;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + CAST(@pidOrdenTrabajo AS VARCHAR) + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de procedimientos
		-- No hay validaciones del procedimiento
		


		-- Accion del procedimiento 
		SELECT * FROM (
			SELECT 
				ls.OrdenTrabajo_idOrdenTrabajo
				, ls.Servicios_idServicios 
				, ls.servicioEfectuado
			FROM Lista_Servicios ls
			WHERE OrdenTrabajo_idOrdenTrabajo = @pidOrdenTrabajo
		) AS T
		RIGHT JOIN Servicios s ON T.Servicios_idServicios=s.idServicios
		
        SET @pmensaje = 'Consulta inalizada con exito';
	END;










	/* Funcionalidad: Cancelar Sericios
     * Construir un delete con la sigueinte informacion:
     * Datos: @pidOrdenTrabajo, @pidServicios
     *
     * Borrar los sigueintes datos en la tabla Lista_Servicios segun los siguientes campos:
     * OrdenTrabajo_idOrdenTrabajo = @pidOrdenTrabajo, Servicios_idServicios = @pidServicios
    */
    IF @paccion = 'DELETE' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pidOrdenTrabajo = '' OR @pidOrdenTrabajo IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' idOrdenTrabajo ';
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
		WHERE idOrdenTrabajo = @pidOrdenTrabajo;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pidOrdenTrabajo + ' ';
		END;

		SELECT @vconteo = COUNT(*) FROM Servicios
		WHERE idServicios = @pidServicios;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pidServicios + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de procedimientos
		-- Solo se pueden borrar servicios a ordenes de trabajo que no esten finalizadas. Es decir idEstadoOT = 13
		SELECT @vconteo=COUNT(*) FROM OrdenTrabajo ot
		INNER JOIN EstadoOT e ON ot.EstadoOT_idEstadoOT=e.idEstadoOT
		INNER JOIN Lista_Servicios ls ON ls.OrdenTrabajo_idOrdenTrabajo = ot.idOrdenTrabajo
		WHERE idEstadoOT=13 AND idOrdenTrabajo=@pidOrdenTrabajo AND ls.Servicios_idServicios=@pidServicios
		AND servicioEfectuado = 0;
		IF @vconteo<>0 BEGIN
			SET @pmensaje= @pmensaje + 'Solo se puede borrar servicios a ordenes de trabajo no finalizadas =>';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;

		-- Accion del procedimiento 
		DELETE FROM Lista_Servicios
		WHERE OrdenTrabajo_idOrdenTrabajo = @pidOrdenTrabajo AND Servicios_idServicios = @pidServicios;

        SET @pmensaje = 'Servicio removido con exito';
	END;

	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
