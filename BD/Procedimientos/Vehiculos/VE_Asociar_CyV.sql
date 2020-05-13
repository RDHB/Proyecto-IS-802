-- <=== Pantalla ===>
/* Requisitos de las acciones:
 * SELECT: <No tiene parametros, solo devuelve informacion>
 * 
 * LINK: @pvin, @pnumeroIdentidad
 * 
 * UNLINK: @pvin, @pnumeroIdentidad
*/
CREATE PROCEDURE VE_ASOCIAR_CYV(
    -- Parametros de Entrada
	@pvin						VARCHAR(45),
	@pnumeroIdentidad			VARCHAR(45),
    @paccion					VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje				INT OUTPUT,
	@pmensaje 					VARCHAR(1000) OUTPUT

    -- Otros parametros de salida

)AS
BEGIN
    -- Declaracion de Variables
    DECLARE	@vconteo INT;



    /* Funcionalidad: Devolver informacion de todos los Clientes con sus respectivos vehiculos
     * Construir un SELECT con la sigueinte informacion:
     * Datos: <ninguno>
     *
     * Consultar los sigueintes datos en las tablas Vehiculos, Modelo, Marca, Cliente y Persona:
     * vin, marca, modelo, numeroIdentidad, (primerNombre, segundoNombre, primerApellido, segundoApellido) AS NombreCompleto
    */
    IF @paccion = 'SELECT' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Accion del procedimiento 
		SELECT 
			V.vin
			, ( -- descripcion Marca
				SELECT descripcion FROM Marca Ma
				WHERE Ma.idMarca = ( -- idMarca
					SELECT Mo.Marca_idMarca FROM Modelo Mo
					WHERE Mo.idModelo = V.Modelo_idModelo
				)
			)
			, ( -- descripcion Modelo
				SELECT descripcion FROM Modelo Mo2
				WHERE Mo2.idModelo = V.Modelo_idModelo
			)
			, ( -- numeroIdentidad
				SELECT P.numeroIdentidad FROM Persona P
				INNER JOIN Cliente C2 ON C2.Persona_idPersona = P.idPersona
				WHERE C2.idCliente = VCV.Cliente_idCliente
			)
			,( -- NombreCompleto
				SELECT CONCAT(
					P2.primerNombre
					, P2.segundoNombre
					, P2.primerApellido
					, P2.segundoApellido
				) AS NombreCompleto
				FROM Persona P2
				INNER JOIN Cliente C2 ON C2.Persona_idPersona = P2.idPersona
				WHERE C2.idCliente = VCV.Cliente_idCliente
			)
		FROM VinculoCyV VCV
		INNER JOIN Cliente C ON C.idCliente = VCV.Cliente_idCliente
		INNER JOIN Vehiculos V ON V.idVehiculos = VCV.Vehiculos_idVehiculos


        SET @pmensaje = 'Consulta exitosa';
	END;










	/* Funcionalidad: Vincular Cliente y Vehiculo (LINK)
	 * Construir un INSERT con la sigueinte informacion:
     * Datos: @pvin, @pnumeroIdentidad
     *
     * Insertar los sigueintes datos en la tabla VinculoCyV:
     * idVinculoCyV, Cliente_idCliente, Vehiculos_idVehiculos
    */
    IF @paccion = 'LINK' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pvin = '' OR @pvin IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' vin ';
		END;

		IF @pnumeroIdentidad = '' OR @pnumeroIdentidad IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' numeroIdentidad ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
        SELECT @vconteo = COUNT(*) FROM Vehiculos
		WHERE vin = @pvin;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pvin + ' ';
		END;

        SELECT @vconteo = COUNT(*) FROM Persona
		WHERE numeroIdentidad = @pnumeroIdentidad;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pnumeroIdentidad + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de procedimientos
		-- Hay una relacion del vehiculo con otro cliente? Si (el vehiculo ya tiene dueño)
		SELECT @vconteo = COUNT(*) FROM VinculoCyV
		WHERE Vehiculos_idVehiculos = (
			SELECT idVehiculos 
			FROM Vehiculos
			WHERE vin = @pvin
		)
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + ' El vehiculo ya tiene dueño ';
		END;

		SELECT @vconteo = COUNT(*) FROM Cliente C
		INNER JOIN Persona P ON P.idPersona = C.Persona_idPersona
		WHERE P.numeroIdentidad = @pnumeroIdentidad
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No hay cliente registrado con este numero de identidad => ' + @pnumeroIdentidad + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;



		-- Accion del procedimiento 
		INSERT INTO VinculoCyV (
			idVinculoCyV
			, Cliente_idCliente
			, Vehiculos_idVehiculos
		) VALUES (
			(
				SELECT MAX(idVinculoCyV) + 1 
				FROM VinculoCyV
			)
			, (
				SELECT C.idCliente FROM Cliente C
				INNER JOIN Persona P ON P.idPersona = C.Persona_idPersona
				WHERE P.numeroIdentidad = @pnumeroIdentidad
			)
			, (
				SELECT idVehiculos FROM Vehiculos 
				WHERE vin = @pvin
			)
		)

        SET @pmensaje = 'Cliente y Vehiculo vinculados con exito';
	END;










	/* Funcionalidad: Desvincular Cliente y Vehiculo (UNLINK)
	 * Construir un DELETE con la sigueinte informacion:
     * Datos: @pvin, @pnumeroIdentidad
     *
     * Eliminar los sigueintes datos en la tabla VinculoCyV:
     * idVinculoCyV, Cliente_idCliente, Vehiculos_idVehiculos
    */
    IF @paccion = 'UNLINK' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pvin = '' OR @pvin IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' vin ';
		END;

		IF @pnumeroIdentidad = '' OR @pnumeroIdentidad IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' numeroIdentidad ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
        SELECT @vconteo = COUNT(*) FROM Vehiculos
		WHERE vin = @pvin;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pvin + ' ';
		END;

        SELECT @vconteo = COUNT(*) FROM Persona
		WHERE numeroIdentidad = @pnumeroIdentidad;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pnumeroIdentidad + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de procedimientos
		SELECT @vconteo = COUNT(*) FROM Cliente C
		INNER JOIN Persona P ON P.idPersona = C.Persona_idPersona
		WHERE P.numeroIdentidad = @pnumeroIdentidad
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No hay cliente registrado con este numero de identidad => ' + @pnumeroIdentidad + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;



		-- Hay una relacion cliente vehiculo? No (No hay vinculo que desactivar)
		SELECT @vconteo = COUNT(*) FROM VinculoCyV
		WHERE Vehiculos_idVehiculos = (
			SELECT idVehiculos 
			FROM Vehiculos
			WHERE vin = @pvin
		)
		AND Cliente_idCliente = (
			SELECT C.idCliente FROM Cliente C
			INNER JOIN Persona P ON P.idPersona = C.Persona_idPersona
			WHERE P.numeroIdentidad = @pnumeroIdentidad
		)
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No hay vinculo que desactivar ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;



		-- Accion del procedimiento 
		DELETE FROM VinculoCyV 
		WHERE Vehiculos_idVehiculos = (
			SELECT idVehiculos 
			FROM Vehiculos
			WHERE vin = @pvin
		)
		AND Cliente_idCliente = (
			SELECT C.idCliente FROM Cliente C
			INNER JOIN Persona P ON P.idPersona = C.Persona_idPersona
			WHERE P.numeroIdentidad = @pnumeroIdentidad
		)

        SET @pmensaje = 'Cliente y Vehiculo desvinculados con exito';
	END;
    
	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
