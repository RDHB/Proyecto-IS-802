/*
select * from Usuarios

declare @cMensaje int;
declare @Mensaje varchar(1000);
declare @cEmpleado varchar(50);

exec SP_LOGIN
	'Murphy', 
	'FSJ44MIN4FJ', 
	@cMensaje output,
	@Mensaje output,
	@cEmpleado output
;

select @cMensaje;
select @Mensaje;
select @cEmpleado;
*/

GO
CREATE OR REPLACE PROCEDURE SP_LOGIN(
	--Informacion Usuario
	@pcNombreUsuario			VARCHAR(45),
	@pcContrasenia				VARCHAR(45),
	
	--Parametros de Salida
	@pnCodigoMensaje			INT OUTPUT,
	@pcMensaje 					VARCHAR(1000) OUTPUT,
	@pnCodigoEmpleado			VARCHAR(50) OUTPUT
)
AS
BEGIN
	--Declaracion de Variables
	DECLARE	@vnConteo INT;
	SET @pnCodigoMensaje=0;
	SET @pcMensaje='';



	

	--Validacion de campos nulos
	IF @pcNombreUsuario='' or @pcNombreUsuario IS NULL BEGIN
		SET @pcMensaje=@pcMensaje + ' nombreUsuario, ';
	END;
	
	IF @pcContrasenia='' or @pcContrasenia IS NULL BEGIN
		SET @pcMensaje=@pcMensaje + ' contrasenia ';
	END;
	
	IF @pcMensaje<>'' BEGIN
		set @pnCodigoMensaje=3;
		SET @pcMensaje='Error: Campos vacios: '+@pcMensaje;
		RETURN;
	END;


	
	

	--Validacion de identificadores
	SELECT @vnConteo=COUNT(*) FROM Usuarios
	WHERE NombreUsuario=@pcNombreUsuario;

	IF @vnConteo=0 BEGIN
		SET @pcMensaje=@pcMensaje + 'Usuario no registrado.';
	END;
		
	IF @pcMensaje<>'' BEGIN
		set @pnCodigoMensaje=4;
		SET @pcMensaje='Error: Identificadores no validos: '+@pcMensaje;
		RETURN;
	END;





	--Validacion de procedimientos
	IF @pcContrasenia <> (
		SELECT Contrasenia FROM Usuarios
		WHERE NombreUsuario=@pcNombreUsuario
	) BEGIN
		SET @pcMensaje=@pcMensaje + 'La contraseña es incorrecta.';
	END;

	IF @pcMensaje<>'' BEGIN
		set @pnCodigoMensaje=5;
		SET @pcMensaje='Error: Validacion en la condicion del procdimiento: ' + @pcMensaje;
		RETURN;
	END;


	
	
	select @pnCodigoEmpleado=e.codigoEmpleado from Empleado e
	inner join Usuarios u on e.idEmpleado=u.Empleado_idEmpleado
	where u.nombreUsuario=@pcNombreUsuario;
	SET @pcMensaje='Acceso Exitoso';
END
