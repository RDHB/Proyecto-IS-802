-- <=== GU_Gestion_Usuarios ===>
/* Requisitos de las acciones:
 * INSERT: @pcodigoEmpleado, @pnombreUsuario, @pcontrasenia
 *
 * UPDATE: @pidUsuario, @pnombreUsuario, @pcontrasenia, @pcorreoElectronico, @ptelefono
 *
 * SELECT: 
 * Opcionales: @pnombrePersona, idEstadoUsuario, idAreaTrabajo
 * Salida-Data: idUsuario, nombrePersona, nombreUsuario, contrasenia, correoElectronico, telefono
 *
 * DESACTIVATE: @pnombreUsuario
 *
 * ACTIVATE: @pnombreUsuario
*/
CREATE PROCEDURE GU_GESTION_USUARIOS(
    --Informacion Usuario
	@pidUsuario					INT,
	@pcodigoEmpleado			VARCHAR(45),
	@pnombreUsuario				VARCHAR(45),
	@pcontrasenia				VARCHAR(45),
	
	@pcorreoElectronico			VARCHAR(45),
	@ptelefono					VARCHAR(45),

	@pnombrePersona				VARCHAR(45),
	@pidEstadoUsuario			INT,
	@pidAreaTrabajo				INT,

	@pAccion					VARCHAR(45),
	
	-- Parametros de Salida
    -- Codigo de mensaje
	@pcodigoMensaje				INT OUTPUT,
	@pmensaje 					VARCHAR(1000) OUTPUT

	-- Otros parametros de salida
) AS
BEGIN
	-- Declaracion de Variables
	DECLARE @vconteo INT;

	DECLARE @Temp1 TABLE (
		idUsuario INT
		, nombrePersona VARCHAR(1000)
		, nombreUsuario VARCHAR(45)
		, correoElectronico VARCHAR(45)
		, numeroTelefono VARCHAR(45)
		, AreaTrabajo VARCHAR(45)
	);
	DECLARE @Temp2 TABLE (
		idUsuario INT
		, nombrePersona VARCHAR(1000)
		, nombreUsuario VARCHAR(45)
		, correoElectronico VARCHAR(45)
		, numeroTelefono VARCHAR(45)
		, AreaTrabajo VARCHAR(45)
	);

    /* Funcionalidad: Añadir usuarios al sistema
    * Construir un Insert con la sigueinte informacion:
    * codigoEmpleado, nombreUsuario, contrasenia
	*
    * Insertar los sigueintes datos en la tabla usuario:
    * codigoEmpleado, nombreUsuario, contrasenia, idUsuario(Auto-incrementado), estado-activo
    */
	IF @paccion = 'INSERT' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';


        
		-- Validacion de campos nulos
		IF @pcodigoEmpleado = '' OR @pcodigoEmpleado IS NULL BEGIN
			SET @pmensaje=@pmensaje + ' codigoEmpleado ';
		END;
		
		IF @pnombreUsuario = '' OR @pnombreUsuario IS NULL BEGIN
			SET @pmensaje=@pmensaje + ' nombreUsuario ';
		END;

		IF @pcontrasenia = '' OR @pcontrasenia IS NULL BEGIN
			SET @pmensaje=@pmensaje + ' contrasenia ';
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
			SET @pmensaje = @pmensaje + 'No hay un empleado asociado a este codigo: ' + @pcodigoEmpleado;
		END;

		SELECT @vconteo = COUNT(*) FROM Empleado E
		INNER JOIN Usuarios U ON U.Empleado_idEmpleado = E.idEmpleado
		WHERE E.codigoEmpleado = @pcodigoEmpleado;
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + 'Ya existe un usuario asociado a este codigo: ' + @pcodigoEmpleado;
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de procedimientos
		SELECT @vconteo = COUNT(*)  FROM Usuarios
		where nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + 'Ya hay un usuario registrado con este nombre: ' + @pnombreUsuario;
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;



		-- Accion del procedimiento 
		INSERT INTO Usuarios (
			idUsuario
			, nombreUsuario
			, contrasenia
			, Empleado_idEmpleado
			, Estado_Usuario_idEstado_Usuario
		)
		VALUES (
			(SELECT MAX(idUsuario) + 1 FROM Usuarios)
			, @pnombreUsuario
			, dbo.FN_ENCRIPTAR(@pcontrasenia)
			, (SELECT idEmpleado FROM Empleado WHERE codigoEmpleado = @pcodigoEmpleado)
			, 1
		);

		SET @pmensaje = 'Usuario creado';
	END;















    /* Funcionalidad: Modificar usuarios del sistema
    * Construir un Update con la sigueinte informacion:
    * @pidUsuario, @pnombreUsuario, @pcorreoElectronico, @ptelefono
	*
    * Modificar los sigueintes datos en la tabla Usuario:
    * nombreUsuario, contrasenia
	*
	* Modificar los sigueintes datos en la tabla Persona:
	* correoElectronico
	*
	* Modificar los sigueintes datos en la tabla Telefono:
	* telefono
    */
	IF @paccion = 'UPDATE' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pidUsuario = 0 BEGIN
			SET @pmensaje=@pmensaje + ' idUsuario ';
		END;

		IF @pnombreUsuario = '' OR @pnombreUsuario IS NULL BEGIN
			SET @pmensaje=@pmensaje + ' nombreUsuario ';
		END;

		IF @pcorreoElectronico = '' OR @pcorreoElectronico IS NULL BEGIN
			SET @pmensaje=@pmensaje + ' correoElectronico ';
		END;
		
		IF @ptelefono = '' OR @ptelefono IS NULL BEGIN
			SET @pmensaje=@pmensaje + ' telefono ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
		SELECT @vconteo = COUNT(*)  FROM Usuarios
		where idUsuario = @pidUsuario
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + 'El usuario ' + CAST(@pidUsuario AS VARCHAR) + ' no existe: ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;
		


		-- Validacion de procedimientos
		SELECT @vconteo = COUNT(*)  FROM Usuarios
		WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS
		AND idUsuario <> @pidUsuario
		
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + 'Ya hay un usuario registrado con este nombre: ' + @pnombreUsuario;
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;


		-- Accion del procedimiento
		-- Actualizar informacion Usuario
		UPDATE Usuarios SET 
			nombreUsuario = @pnombreUsuario
		WHERE idUsuario = @pidUsuario

		-- Actualizar informacion Usuario
		UPDATE Persona SET
			correoElectronico = @pcorreoElectronico
		WHERE idPersona = (
			SELECT Persona_idPersona FROM Empleado
			WHERE idEmpleado = (
				SELECT Empleado_idEmpleado FROM Usuarios WHERE idUsuario = @pidUsuario
			)
		)

		-- Actualizar informacion Usuario
		UPDATE Telefono SET
			numeroTelefono = @ptelefono
		WHERE Persona_idPersona = (
			SELECT Persona_idPersona FROM Empleado
			WHERE idEmpleado = (
				SELECT Empleado_idEmpleado FROM Usuarios WHERE idUsuario = @pidUsuario
			)
		) AND idTelefono = (
			SELECT MIN(idTelefono) FROM Telefono
			WHERE Persona_idPersona = (
				SELECT Persona_idPersona FROM Empleado
				WHERE idEmpleado = (
					SELECT Empleado_idEmpleado FROM Usuarios WHERE idUsuario = @pidUsuario
				)
			)
		)
		SET @pmensaje = 'Datos del usuario actualizados con exito';
	END;












	

	/* Funcionalidad: Seleccionar usuarios del sistema
    * Construir un select con la sigueinte informacion:
    * Opcionales: @pnombrePersona, idEstadoUsuario, idAreaTrabajo
	* Salida-Data: idUsuario, nombrePersona, nombreUsuario, contrasenia, correoElectronico, telefono
	*
    * Seleccionar los sigueintes datos en la tabla Usuario:
    * idUsuario, nombreUsuario
	*
	* Seleccionar los sigueintes datos en la tabla EstadoUsuario:
    * descripcion
	*
	* Seleccionar los sigueintes datos en la tabla Persona:
	* correoElectronico
	*
	* Seleccionar los sigueintes datos en la tabla Telefono:
	* telefono
    */
	IF @paccion = 'SELECT' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		
		-- Validacion de identificadores
		
		-- Validacion de procedimientos
		


		-- Accion del procedimiento
		-- Guardando informacion de los usuarios del sistema
		INSERT INTO @Temp1 
		SELECT 
			U.idUsuario
			, CONCAT(
				P.primerNombre
				, ' '
				, P.segundoNombre
				, ' '
				, P.primerApellido
				, ' '
				, P.segundoApellido
			) AS 'nombrePersona'
			, U.nombreUsuario
			, p.correoElectronico
			, (
				SELECT numeroTelefono FROM Telefono T1
				WHERE T1.idTelefono = (
					SELECT MIN(T2.idTelefono) FROM Telefono T2
					WHERE T2.Persona_idPersona = P.idPersona
				)
			) AS 'numeroTelefono'
			, (
				SELECT descripcion FROM AreaTrabajo WHERE idAreaTrabajo = E.AreaTrabajo_idAreaTrabajo
			) AS 'AreaTrabajo'
		FROM Usuarios U
		INNER JOIN Empleado E ON E.idEmpleado = U.Empleado_idEmpleado
		INNER JOIN Persona P ON P.idPersona = E.Persona_idPersona
		;



		-- Filtro nombrePersona
		IF @pnombrePersona <> '' OR @pnombrePersona <> NULL BEGIN
			
			-- Ejecuta el filtro en la variable @Temp2
			INSERT INTO @Temp2
				SELECT * FROM @Temp1 T
				WHERE T.nombrePersona LIKE '%' + @pnombrePersona + '%'
			;
			
			-- Guarda el filtro en la variable @Temp1
			DELETE FROM @Temp1;
			INSERT INTO @Temp1
				SELECT * FROM @Temp2
			;
			
			-- Vacia el filtro de la variable @Temp2
			DELETE FROM @Temp2;

		END;



		-- Filtro EstadoUsuario
		IF @pidEstadoUsuario <> 0 BEGIN
			
			-- Ejecuta el filtro en la variable @Temp2
			INSERT INTO @Temp2
				SELECT * FROM @Temp1 T
				WHERE T.idUsuario IN (
					SELECT idUsuario FROM Usuarios
					WHERE Estado_Usuario_idEstado_Usuario = @pidEstadoUsuario
				)
			;
			
			-- Guarda el filtro en la variable @Temp1
			DELETE FROM @Temp1;
			INSERT INTO @Temp1
				SELECT * FROM @Temp2
			;
			
			-- Vacia el filtro de la variable @Temp2
			DELETE FROM @Temp2;

		END;



		-- Filtro AreaTrabajo
		IF @pidAreaTrabajo <> 0 BEGIN

			-- Ejecuta el filtro en la variable @Temp2
			INSERT INTO @Temp2
				SELECT * FROM @Temp1 T
				WHERE T.idUsuario IN (
					SELECT U.idUsuario FROM Empleado E
					INNER JOIN Usuarios U ON E.idEmpleado = U.Empleado_idEmpleado
					WHERE E.AreaTrabajo_idAreaTrabajo = @pidAreaTrabajo
				)
			;
			
			-- Guarda el filtro en la variable @Temp1
			DELETE FROM @Temp1;
			INSERT INTO @Temp1
				SELECT * FROM @Temp2
			;
			
			-- Vacia el filtro de la variable @Temp2
			DELETE FROM @Temp2;

		END;
		


		-- Retornar consulta filtrada o no
		SELECT * FROM @Temp1;
		
		SET @pmensaje = 'Consulta finalizada con exito';
	END;










    /* Funcionalidad: Desactivar cuenta de usuario en el sistema
    * Construir un Update con la sigueinte informacion:
    * nombreUsuario
	*
    * Modificar los sigueintes datos en la tabla Usuarios:
    * Estado_Usuario_idEstado_Usuario = 2 (Deshabilitado)
    */
	IF @paccion = 'DESACTIVATE' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';
		

		-- Validacion de campos nulos
		IF @pnombreUsuario = '' OR @pnombreUsuario IS NULL BEGIN
			SET @pmensaje=@pmensaje + ' nombreUsuario ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;


		-- Validacion de identificadores
		SELECT @vconteo = COUNT(*)  FROM Usuarios
		where nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + 'El usuario ' + @pnombreUsuario + ' no existe: ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Accion del procedimiento 
		UPDATE Usuarios SET Estado_Usuario_idEstado_Usuario = 2 
		WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS;

		SET @pmensaje = 'Usuario desactivado';
	END;















	/* Funcionalidad: Activar cuenta de usuario en el sistema
    * Construir un Update con la sigueinte informacion:
    * nombreUsuario
	*
    * Modificar los sigueintes datos en la tabla Usuarios:
    * Estado_Usuario_idEstado_Usuario = 1 (Habilitado)
    */
	IF @paccion = 'ACTIVATE' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';
		

		-- Validacion de campos nulos
		IF @pnombreUsuario = '' OR @pnombreUsuario IS NULL BEGIN
			SET @pmensaje=@pmensaje + ' nombreUsuario ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;


		-- Validacion de identificadores
		SELECT @vconteo = COUNT(*)  FROM Usuarios
		WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + 'El usuario ' + @pnombreUsuario + ' no existe: ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Accion del procedimiento 
		UPDATE Usuarios SET Estado_Usuario_idEstado_Usuario = 1 
		WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS;

		SET @pmensaje = 'Usuario activado';
	END;
	
	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END


