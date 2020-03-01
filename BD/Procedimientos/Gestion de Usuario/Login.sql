GO
-- <=== Pantalla Login ===>
ALTER PROCEDURE SP_LOGIN(
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
	WHERE nombreUsuario = @pnombreUsuario;
	IF @vconteo = 0 BEGIN
		SET @pmensaje = @pmensaje + 'Usuario no registrado.';
	END;
	
	SELECT @vconteo = COUNT(*)  FROM Usuarios
	where nombreUsuario = @pnombreUsuario 
	and Estado_Usuario_idEstado_Usuario = 1
	IF @vconteo = 0 BEGIN
		SET @pmensaje = @pmensaje + 'Usuario Deshabilitado.';
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
	
	select p.idPersona
		, CONCAT(p.primerNombre, ' ', p.primerApellido ) AS Nombre
		, e.idEmpleado
		, e.descripcion
		, e.codigoEmpleado
		, e.jefeInmediato
		, (
			SELECT CONCAT (primerNombre, ' ', segundoNombre, ' ', primerApellido, ' ', segundoApellido) AS NombreCompleto  FROM Persona p2
			inner join Empleado e2 on p2.idPersona = e2.Persona_idPersona
			WHERE e2.idEmpleado = e.jefeInmediato
		) as NombreJefeInmediato
		, e.AreaTrabajo_idAreaTrabajo
		, (
			SELECT descripcion FROM AreaTrabajo at3
			WHERE at3.idAreaTrabajo = e.AreaTrabajo_idAreaTrabajo
		) as AreaTrabajo
		, e.Cargo_idCargo
		, (
			SELECT descripcion FROM Cargo c4
			WHERE c4.idCargo = e.Cargo_idCargo
		) as Cargo 
		, u.idUsuario
		, u.nombreUsuario
		, u.contrasenia
		, u.Estado_Usuario_idEstado_Usuario 
		, (
			SELECT descripcion FROM Estado_Usuario eu5
			WHERE eu5.idEstado_Usuario = u.Estado_Usuario_idEstado_Usuario
		) as EstadoUsuario
	from Persona p
	inner join Empleado e on p.idPersona = e.Persona_idPersona
	inner join Usuarios u on u.Empleado_idEmpleado = e.idEmpleado
	where u.nombreUsuario = @pnombreUsuario;
	
	select @pCodigoEmpleado=e.codigoEmpleado from Empleado e
	inner join Usuarios u on e.idEmpleado=u.Empleado_idEmpleado
	where u.nombreUsuario=@pNombreUsuario;
	
	select @pIdCargo=Cargo_idCargo from Empleado
	where codigoEmpleado=@pCodigoEmpleado;
	SET @pmensaje = 'Acceso Exitoso';
END
