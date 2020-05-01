-- <=== GU_Configuraciones ===>
/* Requisitos de las acciones:
 * UPDATE-CONTRASENIA: @pnombreUsuario, @pnewContrasenia
 * 
 * 
 * UPDATE-USUARIO: @pnombreUsuario, @pnewNombreUsuario
 * 
 * 
 * UPDATE-PERSONA: @pnombreUsuario
 * Opcional: @pnewCorreoElectronico, @pnewDireccion
 * 
 * 
 * ADD-TELEFONO: @pnombreUsuario, @pnewTelefono
 * 
 * 
 * DELETE-TELEFONO: @pnombreUsuario, @pidTelefono
 * 
 * 
 * SELECT-INFO: @pnombreUsaurio
 * Salida: idUsaurio, nombreUsuario, contrasenia, codigoEmpleado, AreaTrabajo, Cargo
 *			, nombreCompleto, numeroIdentidad, correoElectronico, direccion, Genero, fechaIngreso
 * 
 * 
 * SELECT-TELEFONO: @pnombreUsuario
 * Salida: idUsaurio, nombreUsuario, idTelefono, numeroTelefono
*/
CREATE PROCEDURE GU_CONFIG (
    -- Parametros de Entrada
	-- ID
	@pnombreUsuario				VARCHAR(45),
	
	-- UPDATE
	@pnewContrasenia			VARCHAR(45),
	@pnewNombreUsuario			VARCHAR(45),
	@pnewCorreoElectronico		VARCHAR(45),
	@pnewDireccion				VARCHAR(45),

	-- ADD
	@pnewTelefono				VARCHAR(45),

	-- ID DELETE
	@pidTelefono				INT,

    @paccion					VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje				INT OUTPUT,
	@pmensaje 					VARCHAR(1000) OUTPUT

    -- Otros parametros de salida

) AS
BEGIN
    -- Declaracion de Variables
    DECLARE	@vconteo INT;



    /* Funcionalidad: Actualizar contraseña
     * Construir un update con la sigueinte informacion:
     * Datos: @pnombreUsuario, @pnewContrasenia
     *
     * Actualizar los sigueintes datos en la tabla Usuarios:
     * contrasenia
    */
    IF @paccion = 'UPDATE-CONTRASENIA' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pnombreUsuario = '' OR @pnombreUsuario IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' nombreUsuario ';
		END;

		IF @pnewContrasenia = '' OR @pnewContrasenia IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' newContrasenia ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
        SELECT @vconteo = COUNT(*) FROM Usuarios
		WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pnombreUsuario + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;


		select * from Usuarios
		
		-- Validacion de procedimientos
		SELECT @vconteo = COUNT(*) FROM Usuarios
		WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS
		AND contrasenia = dbo.FN_ENCRIPTAR( @pnewContrasenia ) COLLATE SQL_Latin1_General_CP1_CS_AS;
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + ' El usuario no puede tener la misma contrasenia => ' + dbo.FN_ENCRIPTAR( @pnewContrasenia ) + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;


		
		-- Accion del procedimiento 
		UPDATE Usuarios SET contrasenia = @pnewContrasenia
		WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS;



        SET @pmensaje = 'Contrasenia actualizado con exito';
	END;
    









	/* Funcionalidad: Actualizar nombreUsuario
     * Construir un update con la sigueinte informacion:
     * Datos: @pnombreUsuario, @pnewNombreUsuario
     *
     * Actualizar los sigueintes datos en la tabla Usuarios:
     * nombreUsuario
    */
    IF @paccion = 'UPDATE-USUARIO' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pnombreUsuario = '' OR @pnombreUsuario IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' nombreUsuario ';
		END;

		IF @pnewNombreUsuario = '' OR @pnewNombreUsuario IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' newNombreUsuario ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
        SELECT @vconteo = COUNT(*) FROM Usuarios
		WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pnombreUsuario + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;


		
		-- Validacion de procedimientos
		SELECT @vconteo = COUNT(*)  FROM Usuarios
		WHERE nombreUsuario = @pnewNombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS
		AND @pnombreUsuario <> @pnewNombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + ' Ya hay un usuario registrado con este nombre: ' + @pnewNombreUsuario;
		END;

		IF (@pnombreUsuario = @pnewNombreUsuario  COLLATE SQL_Latin1_General_CP1_CS_AS) BEGIN
			SET @pmensaje = @pmensaje + ' El nuevo nombre del usuario es igual al actual' + @pnewNombreUsuario;
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;


		
		-- Accion del procedimiento 
		UPDATE Usuarios SET nombreUsuario = @pnewNombreUsuario
		WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS;



        SET @pmensaje = 'Nombre de Usuario actualizado con exito';
	END;










	/* Funcionalidad: Actualizar Informacion de la Persona
     * Construir un update con la sigueinte informacion:
     * Datos: @pnombreUsuario, @pnewCorreoElectronico, @pnewDireccion
     *
     * Actualizar los sigueintes datos en la tabla Usuarios:
     * nombreUsuario
    */
    IF @paccion = 'UPDATE-PERSONA' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pnombreUsuario = '' OR @pnombreUsuario IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' nombreUsuario ';
		END;

		IF @pnewCorreoElectronico = '' OR @pnewCorreoElectronico IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' newCorreoElectronico ';
		END;
		
		IF @pnewDireccion = '' OR @pnewDireccion IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' newDireccion ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
        SELECT @vconteo = COUNT(*) FROM Usuarios
		WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pnombreUsuario + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;


		
		-- Validacion de procedimientos
		

		
		-- Accion del procedimiento 
		UPDATE Persona SET 
			correoElectronico = @pnewCorreoElectronico
			, direccion = @pnewDireccion
		WHERE idPersona = (
			SELECT E.Persona_idPersona FROM Empleado E
			WHERE E.idEmpleado = (
				SELECT U.Empleado_idEmpleado FROM Usuarios U
				WHERE U.nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS
			)
		);



        SET @pmensaje = 'Informacion del usuario actualizado con exito';
	END;
	









	/* Funcionalidad: Agregar Telefono
     * Construir un insert con la sigueinte informacion:
     * Datos: @pnombreUsuario, @pnewTelefono
     *
     * Insertar los sigueintes datos en la tabla Telefono:
     * idTelefono, numeroTelefono, Persona_idPersona
    */
    IF @paccion = 'ADD-TELEFONO' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pnombreUsuario = '' OR @pnombreUsuario IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' nombreUsuario ';
		END;

		IF @pnewTelefono = '' OR @pnewTelefono IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' newTelefono ';
		END;
		
		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
        SELECT @vconteo = COUNT(*) FROM Usuarios
		WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pnombreUsuario + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;


		
		-- Validacion de procedimientos
		SELECT @vconteo = COUNT(*) FROM Telefono
		WHERE Persona_idPersona = (
			SELECT Persona_idPersona FROM Empleado
			WHERE idEmpleado = (
				SELECT Empleado_idEmpleado FROM Usuarios
				WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS
			)
		) AND numeroTelefono = @pnewTelefono
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + ' El usuario ya cuenta con este numero de telefono => ' + @pnewTelefono + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;
		

		
		-- Accion del procedimiento 
		INSERT INTO Telefono (
			idTelefono
			, numeroTelefono
			, Persona_idPersona
		) VALUES (
			(SELECT MAX(idTelefono) + 1 FROM Telefono)
			, @pnewTelefono
			, (
				SELECT Persona_idPersona FROM Empleado
				WHERE idEmpleado = (
					SELECT Empleado_idEmpleado FROM Usuarios
					WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS
				)
			)
		)



        SET @pmensaje = 'Telefono agregado con exito';
	END;
	









	/* Funcionalidad: Agregar Telefono
     * Construir un insert con la sigueinte informacion:
     * Datos: @pnombreUsuario, @pnewTelefono
     *
     * Insertar los sigueintes datos en la tabla Telefono:
     * idTelefono, numeroTelefono, Persona_idPersona
    */
    IF @paccion = 'ADD-TELEFONO' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pnombreUsuario = '' OR @pnombreUsuario IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' nombreUsuario ';
		END;

		IF @pnewTelefono = '' OR @pnewTelefono IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' newTelefono ';
		END;
		
		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
        SELECT @vconteo = COUNT(*) FROM Usuarios
		WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pnombreUsuario + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;


		
		-- Validacion de procedimientos
		SELECT @vconteo = COUNT(*) FROM Telefono
		WHERE Persona_idPersona = (
			SELECT Persona_idPersona FROM Empleado
			WHERE idEmpleado = (
				SELECT Empleado_idEmpleado FROM Usuarios
				WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS
			)
		) AND numeroTelefono = @pnewTelefono
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + ' El usuario ya cuenta con este numero de telefono => ' + @pnewTelefono + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;
		

		
		-- Accion del procedimiento 
		INSERT INTO Telefono (
			idTelefono
			, numeroTelefono
			, Persona_idPersona
		) VALUES (
			(SELECT MAX(idTelefono) + 1 FROM Telefono)
			, @pnewTelefono
			, (
				SELECT Persona_idPersona FROM Empleado
				WHERE idEmpleado = (
					SELECT Empleado_idEmpleado FROM Usuarios
					WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS
				)
			)
		)



        SET @pmensaje = 'Telefono agregado con exito';
	END;









	
	/* Funcionalidad: Eliminar Telefono
     * Construir un delete con la sigueinte informacion:
     * Datos: @pnombreUsuario, @pidTelefono
     *
     * Eliminar los sigueintes datos en la tabla Telefono:
     * idTelefono, numeroTelefono, Persona_idPersona
    */
    IF @paccion = 'DELETE-TELEFONO' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pnombreUsuario = '' OR @pnombreUsuario IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' nombreUsuario ';
		END;

		IF @pnewTelefono = '' OR @pnewTelefono IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' @pidTelefono ';
		END;
		
		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
        SELECT @vconteo = COUNT(*) FROM Usuarios
		WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pnombreUsuario + ' ';
		END;

		SELECT @vconteo = COUNT(*) FROM Telefono
		WHERE idTelefono = @pidTelefono;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pidTelefono + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;


		
		-- Validacion de procedimientos
		SELECT @vconteo = COUNT(*) FROM Telefono
		WHERE Persona_idPersona = (
			SELECT Persona_idPersona FROM Empleado
			WHERE idEmpleado = (
				SELECT Empleado_idEmpleado FROM Usuarios
				WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS
			)
		) AND idTelefono = @pidTelefono
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + ' El usuario no tiene este numero de telefono registrado => ' + @pnewTelefono + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;
		

		
		-- Accion del procedimiento 
		DELETE FROM Telefono WHERE idTelefono = @pidTelefono;



        SET @pmensaje = 'Telefono eliminado con exito';
	END;










	/* Funcionalidad: Seleccionar informacion
     * Construir un select con la sigueinte informacion:
     * Datos: @pnombreUsuario
     * 
	 * Seleccionar los sigueintes datos en la tabla Usuarios:
     * idUsuario, @nombreUsuario, contrasenia
	 * 
	 * Seleccionar los sigueintes datos en la tabla Empleado:
     * codigoEmpleado
	 * 
	 * Seleccionar los sigueintes datos en la tabla Cargo:
     * descripcion
	 * 
	 * Seleccionar los sigueintes datos en la tabla AreaTrabajo:
     * descripcion
	 * 
	 * Seleccionar los sigueintes datos en la tabla Persona:
     * nombreCompleto, numeroIdentidad, correoElectronico, direccion, fechaIngreso
	 * 
     * Seleccionar los sigueintes datos en la tabla Genero:
     * descripcion
    */
    IF @paccion = 'SELECT-INFO' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pnombreUsuario = '' OR @pnombreUsuario IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' nombreUsuario ';
		END;

		IF @pnewTelefono = '' OR @pnewTelefono IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' @pidTelefono ';
		END;
		
		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
        SELECT @vconteo = COUNT(*) FROM Usuarios
		WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pnombreUsuario + ' ';
		END;

		SELECT @vconteo = COUNT(*) FROM Telefono
		WHERE idTelefono = @pidTelefono;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pidTelefono + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;


		
		-- Validacion de procedimientos
		SELECT @vconteo = COUNT(*) FROM Telefono
		WHERE Persona_idPersona = (
			SELECT Persona_idPersona FROM Empleado
			WHERE idEmpleado = (
				SELECT Empleado_idEmpleado FROM Usuarios
				WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS
			)
		) AND idTelefono = @pidTelefono
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + ' El usuario no tiene este numero de telefono registrado => ' + @pnewTelefono + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;
		

		
		-- Accion del procedimiento 
		DELETE FROM Telefono WHERE idTelefono = @pidTelefono;



        SET @pmensaje = 'Telefono eliminado con exito';
	END;










	/* Funcionalidad: Seleccionar Telefonos
     * Construir un select con la sigueinte informacion:
     * Datos: @pnombreUsuario
     *
	 * Seleccionar los sigueintes datos en la tabla Usuarios:
     * idUsuario, @nombreUsuario
	 *
     * Seleccionar los sigueintes datos en la tabla Telefono:
     * idTelefono, numeroTelefono
    */
    IF @paccion = 'SELECT-TELEFONO' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pnombreUsuario = '' OR @pnombreUsuario IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' nombreUsuario ';
		END;

		IF @pnewTelefono = '' OR @pnewTelefono IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' @pidTelefono ';
		END;
		
		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
        SELECT @vconteo = COUNT(*) FROM Usuarios
		WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pnombreUsuario + ' ';
		END;

		SELECT @vconteo = COUNT(*) FROM Telefono
		WHERE idTelefono = @pidTelefono;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + @pidTelefono + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;


		
		-- Validacion de procedimientos
		SELECT @vconteo = COUNT(*) FROM Telefono
		WHERE Persona_idPersona = (
			SELECT Persona_idPersona FROM Empleado
			WHERE idEmpleado = (
				SELECT Empleado_idEmpleado FROM Usuarios
				WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS
			)
		) AND idTelefono = @pidTelefono
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + ' El usuario no tiene este numero de telefono registrado => ' + @pnewTelefono + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;
		

		
		-- Accion del procedimiento 
		DELETE FROM Telefono WHERE idTelefono = @pidTelefono;



        SET @pmensaje = 'Telefono eliminado con exito';
	END;

	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
