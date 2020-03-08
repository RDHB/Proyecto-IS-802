-- <=== GU_Gestion_Usuarios ===>
/* Requisitos de las acciones:
 * INSERT: @pcodigoEmpleado, @pnombreUsuario, @pcontrasenia
 *
 * UPDATE: @pnombreUsuario, @pcontrasenia
 *
 * DESACTIVATE: @pnombreUsuario
 *
 * ACTIVATE: @pnombreUsuario
*/
CREATE PROCEDURE GU_GESTION_USUARIOS(
    --Informacion Usuario
	@pcodigoEmpleado			VARCHAR(45),
	@pnombreUsuario				VARCHAR(45),
	@pcontrasenia				VARCHAR(45),
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
		where nombreUsuario = @pnombreUsuario 
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
			, @pcontrasenia
			, (SELECT idEmpleado FROM Empleado WHERE codigoEmpleado = @pcodigoEmpleado)
			, 1
		);

		SET @pmensaje = 'Usuario creado';
	END;















    /* Funcionalidad: Modificar usuarios del sistema
    * Construir un Update con la sigueinte informacion:
    * nombreUsuario, contrasenia (nueva)
	*
    * Modificar los sigueintes datos en la tabla usuario:
    * contrasenia (nueva)
    */
	IF @paccion = 'UPDATE' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
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
		SELECT @vconteo = COUNT(*)  FROM Usuarios
		where nombreUsuario = @pnombreUsuario 
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + 'El usuario ' + @pnombreUsuario + ' no existe: ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;
		


		-- Validacion de procedimientos
		SELECT @vconteo = COUNT(*)  FROM Usuarios
		where nombreUsuario = @pnombreUsuario and contrasenia = @pcontrasenia
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + 'El usuario ya tiene esta contraseña';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;



		-- Accion del procedimiento 
		UPDATE Usuarios SET contrasenia = @pcontrasenia WHERE nombreUsuario = @pnombreUsuario

		SET @pmensaje = 'Contrasenia guardada';
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
		where nombreUsuario = @pnombreUsuario 
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + 'El usuario ' + @pnombreUsuario + ' no existe: ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Accion del procedimiento 
		UPDATE Usuarios SET Estado_Usuario_idEstado_Usuario = 2 WHERE nombreUsuario = @pnombreUsuario

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
		where nombreUsuario = @pnombreUsuario 
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + 'El usuario ' + @pnombreUsuario + ' no existe: ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;



		-- Accion del procedimiento 
		UPDATE Usuarios SET Estado_Usuario_idEstado_Usuario = 1 WHERE nombreUsuario = @pnombreUsuario

		SET @pmensaje = 'Usuario activado';
	END;
	
	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END


