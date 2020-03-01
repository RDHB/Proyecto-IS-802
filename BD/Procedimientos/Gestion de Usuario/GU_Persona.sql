/* Cargar la respectiva pantalla del formulario
 * Llamar al procedimeinto almacenado SP_LOGIN
 * Identificar que pantallas van a ser visualizadas a traves del cargo del empleado
 * que se devuelve en el procedimeinto almacenado de login
*/




/* Funcionalidad: Devolver informacion de los usuarios del sistema
 * Construir un Select con la sigueinte informacion:
 * "Buscar por Nombre" like "Area de Trabajo" (puede estar vacia)
 * 
 * Se requieren los siguientes parametros: nombreusuario, areaTrabajo
 * Devuelve los en un JSON todos los datos de la tabla
 * Datos: idUsuario, codigoEmpleado, nombreUsuario, contrasenia
*/
CREATE PROCEDURE GU_CARGAR_USUARIOS(
    -- Parametros de Entrada
	@pcNombre				VARCHAR(45),
	@pnidAreaTrabajo		INT,
    
    -- Parametros de Salida
    -- Codigo de mensaje
	@pnCodigoMensaje			INT OUTPUT,
	@pcMensaje 					VARCHAR(1000) OUTPUT,

    -- Otros parametros de salida
	@pnidUsuario				INT OUTPUT,
	@pcCodigoEmpleado			VARCHAR (45) OUTPUT,
	@pcNombreUsuario			VARCHAR (45) OUTPUT,
	@pcContrasenia				VARCHAR (45) OUTPUT
)AS
BEGIN
	--Declaracion de Variables
	DECLARE @vnConteo INT;
	/* Funcionalidad: Devolver informacion de los usuarios del sistema
	* Construir un Select con la sigueinte informacion:
	* "Buscar por Nombre" like "Area de Trabajo" (puede estar vacia)
	* 
	* Se requieren los siguientes parametros: nombreusuario, areaTrabajo
	* Devuelve los en un JSON todos los datos de la tabla
	* Datos: idUsuario, codigoEmpleado, nombreUsuario, contrasenia
	*/
	--Validacion de identificadores
	
	/* Validar de que el nombre de la persona se encuentra
	 * Usar subconsulta en el select
	SELECT @vnConteo=COUNT(*) FROM Personas
	WHERE Nombre=@pcNombre;
	(SELECT primerNombre, segundoNombre, primerApellido, segundoApellido FROM PERSONA)

	IF @vnConteo=0 BEGIN
		SET @pcMensaje=@pcMensaje + 'Usuario no registrado.';
	END;
		
	IF @pcMensaje<>'' BEGIN
		set @pnCodigoMensaje=4;
		SET @pcMensaje='Error: Identificadores no validos: '+@pcMensaje;
		RETURN;
	END;
	*/
	--Validacion de procedimientos


END


--<=== Gestion de usuario ===>
CREATE PROCEDURE GU_GESTION_USUARIOS()
    -- Parametros de Entrada

    
    -- Parametros de Salida
    -- Codigo de mensaje

    -- Otros parametros de salida

AS
BEGIN
    /* Funcionalidad: Añadir usuarios al sistema
    * Construir un Insert con la sigueinte informacion:
    * codigoEmpleado, nombreUsuario, contrasenia
    * Insertar los sigueintes datos en la tabla usuario:
    * codigoEmpleado, nombreUsuario, contrasenia, idUsuario(Auto-incrementado), estado-activo
    */

    /* Funcionalidad: Modificar usuarios del sistema
    * Construir un Update con la sigueinte informacion:
    * nombreUsuario, contrasenia (nueva)
    * Modificar los sigueintes datos en la tabla usuario:
    * contrasenia (nueva)
    */

    /* Funcionalidad: Desactivar cuenta de usuario del sistema
    * Construir un Update con la sigueinte informacion:
    * nombreUsuario
    * Modificar los sigueintes datos en la tabla Usuarios:
    * Estado_Usuario_idEstado_Usuario = 2 (Deshabilitado)
    */
END


