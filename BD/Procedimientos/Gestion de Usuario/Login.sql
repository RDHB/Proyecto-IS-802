GO
-- <=== Pantalla Login ===>
CREATE PROCEDURE SP_LOGIN(
	--Informacion Usuario
	@pnombreUsuario				VARCHAR(45),
	@pcontrasenia				VARCHAR(45),
	
	-- Parametros de Salida
    -- Codigo de mensaje
	@pcodigoMensaje				INT OUTPUT,
	@pmensaje 					VARCHAR(1000) OUTPUT,

	-- Otros parametros de salida
	@pcodigoEmpleado			VARCHAR(50) OUTPUT,
	@pidCargo					INT OUTPUT
) AS
BEGIN
	/* Funcionalidad: Login de Usuarios
    * Construir un select con la sigueinte informacion:
    * nombreUsuario, contrasenia
    *
    * Consultar los sigueintes datos en la tabla Empleado:
    * codigoEmpleado, idCargo
    */
	-- Declaracion de Variables
    DECLARE	@vconteo INT;

    -- Setear Valores
	SET @pcodigoMensaje = 0;
	SET @pmensaje = '';


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
	SELECT @vconteo = COUNT(*) FROM Usuarios
	WHERE NombreUsuario = @pnombreUsuario;

	IF @vconteo = 0 BEGIN
		SET @pmensaje = @pmensaje + 'Usuario no registrado.';
	END;
		
	IF @pmensaje <> '' BEGIN
		SET @pcodigoMensaje = 4;
		SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
		RETURN;
	END;

	
	-- Validacion de procedimientos
	IF @pcontrasenia <> (
		SELECT Contrasenia FROM Usuarios
		WHERE NombreUsuario = @pnombreUsuario
	) BEGIN
		SET @pmensaje=@pmensaje + 'La contraseña es incorrecta.';
	END;

	IF @pmensaje <> '' BEGIN
		SET @pcodigoMensaje = 5;
		SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
		RETURN;
	END;


	-- Accion del procedimiento 
	select @pcodigoEmpleado = e.codigoEmpleado, @pidCargo = Cargo_idCargo from Empleado e
	inner join Usuarios u on e.idEmpleado = u.Empleado_idEmpleado
	where u.nombreUsuario = @pnombreUsuario;
	
	SET @pmensaje = 'Acceso Exitoso';
END
