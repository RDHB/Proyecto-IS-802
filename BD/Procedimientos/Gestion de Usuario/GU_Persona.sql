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
CREATE PROCEDURE GU_CARGAR_USUARIOS()

AS
BEGIN

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


