-- <=== GU_Configuraciones ===>
/* Requisitos de las acciones:
 * SELECT-INFO: @pnombreUsaurio
 * Salida: idUsaurio, nombreUsuario, contrasenia, nombreArchivo, codigoEmpleado, AreaTrabajo, Cargo
 *			, nombreCompleto, numeroIdentidad, correoElectronico, direccion, Genero, fechaIngreso
 *			, HoraEntrada, HoraSalida, HorasExtras
 * 
 * 
 * UPDATE-CONTRASENIA: @pnombreUsuario, @pnewContrasenia
 * 
 * 
 * UPDATE-USUARIO: @pnombreUsuario, @pnewNombreUsuario
 * 
 * 
 * UPDATE-PERSONA: @pnombreUsuario, @pnewCorreoElectronico, @pnewDireccion
 * 
 * 
 * UPDATE-FPERFIL: @pnombreUsuario, @pextensionArchivo(.png, .jpg y .jpeg)
 * Salida: @pnombreArchivo, @pnombreArchivoAnterior
 * 
 * 
 * DELETE-FPERFIL: @pnombreUsuario
 * Salida: @pnombreArchivo
 * 
 * 
 * SELECT-TELEFONO: @pnombreUsuario
 * Salida: idUsaurio, nombreUsuario, idTelefono, numeroTelefono
 * 
 * 
 * ADD-TELEFONO: @pnombreUsuario, @pnewTelefono
 * 
 * 
 * UPDATE-TELEFONO: @pnombreUsuario, @pidTelefono, @pnewTelefono
 * 
 * 
 * DELETE-TELEFONO: @pnombreUsuario, @pidTelefono
*/
CREATE OR ALTER PROCEDURE GU_CONFIG (
    -- Parametros de Entrada
	-- ID
	@pnombreUsuario				VARCHAR(45),
	
	-- UPDATE
	@pnewContrasenia			VARCHAR(45),
	@pnewNombreUsuario			VARCHAR(45),
	@pnewCorreoElectronico		VARCHAR(45),
	@pnewDireccion				VARCHAR(45),
	@pextensionArchivo			VARCHAR(45),

	-- ADD
	@pnewTelefono				VARCHAR(45),

	-- ID DELETE
	@pidTelefono				INT,

    @paccion					VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje				INT OUTPUT,
	@pmensaje 					VARCHAR(1000) OUTPUT,

    -- Otros parametros de salida
	@pnombreArchivo				VARCHAR(55) OUTPUT,
	@pnombreArchivoAnterior		VARCHAR(55) OUTPUT
) AS
BEGIN
    -- Declaracion de Variables
    DECLARE	@vconteo INT;



    /* Funcionalidad: Seleccionar informacion
     * Construir un select con la sigueinte informacion:
     * Datos: @pnombreUsuario
     * 
	 * Seleccionar los sigueintes datos en la tabla Usuarios:
     * idUsuario, @nombreUsuario, contrasenia, nombreArchivo
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
		-- HoraEntrada, HoraSalida, HorasExtras
		SELECT 
			U.idUsuario
			, nombreUsuario
			, nombreArchivo
			, dbo.FN_ENCRIPTAR( contrasenia ) AS 'Contrasenia'
			, nombreArchivo
			, E.codigoEmpleado
			, (
				SELECT C.descripcion FROM Cargo C 
				WHERE C.idCargo = E.Cargo_idCargo
			) AS 'Cargo'
			, (
				SELECT ART.descripcion FROM AreaTrabajo ART
				WHERE ART.idAreaTrabajo = E.AreaTrabajo_idAreaTrabajo
			) AS 'AreaTrabajo'
			, CONCAT (
				P.primerNombre
				, ' '
				, P.segundoNombre
				, ' '
				, P.primerApellido
				, ' '
				, P.segundoApellido
			) AS 'NombreCompleto'
			, P.numeroIdentidad
			, P.correoElectronico
			, P.direccion
			, (
				SELECT G.descripcion FROM Genero G
				WHERE G.idGenero = P.Genero_idGenero
			) AS 'Genero'
			, P.fechaIngreso
			, (
				SELECT horaEntrada FROM ContratoPersonal
				WHERE idContratoPersonal = (
					SELECT MAX(idContratoPersonal) FROM Empleado E2
					INNER JOIN Historico_Contratos HC ON HC.Empleado_idEmpleado = E2.idEmpleado
					INNER JOIN ContratoPersonal C ON C.idContratoPersonal = HC.ContratoPersonal_idContratoPersonal
					WHERE E2.idEmpleado = E.idEmpleado
				)
			) AS 'HoraEntrada'
			, (
				SELECT horaSalida FROM ContratoPersonal
				WHERE idContratoPersonal = (
					SELECT MAX(idContratoPersonal) FROM Empleado E2
					INNER JOIN Historico_Contratos HC ON HC.Empleado_idEmpleado = E2.idEmpleado
					INNER JOIN ContratoPersonal C ON C.idContratoPersonal = HC.ContratoPersonal_idContratoPersonal
					WHERE E2.idEmpleado = E.idEmpleado
				)
			) AS 'HoraSalida'
			, (
				(
					SELECT dbo.FN_CANTIDAD_HE(E.idEmpleado, GETDATE())
				)
			) AS 'HorasExtras'
		FROM Usuarios U
		INNER JOIN Empleado E ON E.idEmpleado = U.Empleado_idEmpleado
		INNER JOIN Persona P ON P.idPersona = E.Persona_idPersona
		WHERE U.nombreUsuario = @pnombreUsuario



        SET @pmensaje = 'Consulta finalizada con exito';
	END;










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


		
		-- Validacion de procedimientos
		SELECT @vconteo = COUNT(*) FROM Usuarios
		WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS
		AND contrasenia = dbo.FN_ENCRIPTAR( @pnewContrasenia ) COLLATE SQL_Latin1_General_CP1_CS_AS;
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + ' El usuario no puede tener la misma contrasenia => ' + @pnewContrasenia + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;


		
		-- Accion del procedimiento 
		UPDATE Usuarios SET contrasenia = dbo.FN_ENCRIPTAR( @pnewContrasenia )
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
			SET @pmensaje = @pmensaje + ' El nuevo nombre del usuario es igual al actual ' + @pnewNombreUsuario;
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
    









	/* Funcionalidad: Actualizar foto de Perfil
     * Construir un update con la sigueinte informacion:
     * Datos: @pnombreUsuario, @pextensionArchivo
     * Salida: @pnombreArchivo, @pnombreArchivoAnterior
	 *
     * Actualizar los sigueintes datos en la tabla Usuarios:
     * nombreArchivo
    */
    IF @paccion = 'UPDATE-FPERFIL' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pnombreUsuario = '' OR @pnombreUsuario IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' nombreUsuario ';
		END;

		IF @pextensionArchivo = '' OR @pextensionArchivo IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' extensionArchivo ';
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
		IF NOT (@pextensionArchivo = '.png' OR @pextensionArchivo = '.jpg' OR @pextensionArchivo = '.jpeg') BEGIN
			SET @pmensaje = @pmensaje + ' La extension del archivo debe de ser => .png, .jpg, o .jpeg ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;


		
		-- Accion del procedimiento 
		SET @pnombreArchivoAnterior = (
			SELECT nombreArchivo FROM Usuarios 
			WHERE nombreUsuario = @pnombreUsuario
		)

		SET @pnombreArchivo = CONCAT(
			(SELECT idUsuario FROM Usuarios WHERE nombreUsuario = @pnombreUsuario)
			, @pextensionArchivo
		);
		UPDATE Usuarios SET nombreArchivo = @pnombreArchivo
		WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS;
		


        SET @pmensaje = 'Foto de perfil del usuario actualizada con exito';
	END;










	/* Funcionalidad: Actualizar foto de Perfil
     * Construir un update con la sigueinte informacion:
     * Datos: @pnombreUsuario
     * Salida: @pnombreArchivo
	 *
     * Actualizar los sigueintes datos en la tabla Usuarios:
     * nombreArchivo
    */
    IF @paccion = 'DELETE-FPERFIL' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pnombreUsuario = '' OR @pnombreUsuario IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' nombreUsuario ';
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
		SET @pnombreArchivoAnterior = (
			SELECT nombreArchivo FROM Usuarios 
			WHERE nombreUsuario = @pnombreUsuario
		)

		SET @pnombreArchivo = 'default.png';
		UPDATE Usuarios SET nombreArchivo = @pnombreArchivo
		WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS;
		


        SET @pmensaje = 'Foto de perfil del usuario eliminada con exito';
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
		SELECT 
			(
				SELECT idUsuario FROM Usuarios
				WHERE nombreUsuario = @pnombreUsuario
			) AS 'idUsuario'
			, @pnombreUsuario AS 'nombreUsuario'
			, T.idTelefono
			, T.numeroTelefono
		FROM Telefono T
		WHERE Persona_idPersona = (
			SELECT idPersona FROM Usuarios U
			INNER JOIN Empleado E ON E.idEmpleado = U.Empleado_idEmpleado
			INNER JOIN Persona P ON P.idPersona = E.Persona_idPersona
			WHERE U.nombreUsuario = @pnombreUsuario
		);



        SET @pmensaje = 'Consulta finalizda con exito';
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
	









	/* Funcionalidad: Modificar Telefono
     * Construir un update con la sigueinte informacion:
     * Datos: @pnombreUsuario, @pidTelefono, @pnewTelefono
     *
     * Actualizar los sigueintes datos en la tabla Telefono:
     * numeroTelefono
    */
    IF @paccion = 'UPDATE-TELEFONO' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pnombreUsuario = '' OR @pnombreUsuario IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' nombreUsuario ';
		END;
		
		IF @pidTelefono = '' OR @pidTelefono IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' idTelefono ';
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

		SELECT @vconteo = COUNT(*) FROM Telefono
		WHERE idTelefono = @pidTelefono;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + CAST(@pidTelefono AS VARCHAR) + ' ';
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
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' El usuario no cuenta con este numero de telefono => ' + 
				(SELECT numeroTelefono FROM Telefono WHERE idTelefono = @pidTelefono)
			+ ' ';
		END;

		SELECT @vconteo = COUNT(*) FROM Telefono
		WHERE Persona_idPersona = (
			SELECT Persona_idPersona FROM Empleado
			WHERE idEmpleado = (
				SELECT Empleado_idEmpleado FROM Usuarios
				WHERE nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS
			)
		) AND numeroTelefono = @pnewTelefono
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + ' El usuario ya cuenta con este numero de telefono => ' + 
				@pnewTelefono
			+ ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;
		

		
		-- Accion del procedimiento 
		UPDATE Telefono
		SET numeroTelefono = @pnewTelefono
		WHERE idTelefono = @pidTelefono



        SET @pmensaje = 'Telefono actualizado con exito';
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

		IF @pidTelefono = '' OR @pidTelefono IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' idTelefono ';
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
			SET @pmensaje = @pmensaje + ' No existe el identificador => ' + CAST(@pidTelefono AS VARCHAR) + ' ';
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
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + ' El usuario ' + @pnombreUsuario + ' no tiene este numero de telefono registrado => ' + 
			(SELECT numeroTelefono FROM Telefono WHERE idTelefono = @pidTelefono)
			+ ' ';
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