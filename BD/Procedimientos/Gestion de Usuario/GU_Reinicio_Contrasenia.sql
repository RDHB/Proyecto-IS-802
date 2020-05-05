-- <=== Pantalla ===>
/* Requisitos de las acciones:
 * RESET: @pnombreUsuario
 * Salida: @presetContrasenia, @pcorreoElectronico
*/
CREATE PROCEDURE GU_REINICIO_CONTRASENIA(
    -- Parametros de Entrada
	@pnombreUsuario				VARCHAR(45),
    @paccion					VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje				INT OUTPUT,
	@pmensaje 					VARCHAR(1000) OUTPUT,

    -- Otros parametros de salida
	@presetContrasenia			VARCHAR(45) OUTPUT,
	@pcorreoElectronico			VARCHAR(45) OUTPUT
) AS
BEGIN
    -- Declaracion de Variables
    DECLARE	@vconteo INT;



    /* Funcionalidad: <nombre_funcionalidad>
     * Construir un update con la sigueinte informacion:
     * Datos: @pnombreUsuario, @presetContrasenia, @pcorreoElectronico
     *
     * Actualizar los sigueintes datos en la tabla Usuarios:
     * contrasenia
    */
    IF @paccion = 'RESET' BEGIN
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
		/* Consultas para la funcion FN_RANDOM_STRING
		 * SELECT dbo.FN_RANDOM_STRING(8,'C') AS 'Cadena aleatoria','Solo Letras' AS Contiene  --Cadena aleatoria que contiene Letras.
		 * UNION ALL
		 * SELECT dbo.FN_RANDOM_STRING(8,'N'),'Solo Números'  --Cadena aleatoria que contiene Números.
		 * UNION ALL
		 * SELECT dbo.FN_RANDOM_STRING(8,'CN'), 'Letras y Números'--Cadena aleatoria que contiene Letras y Números.
		*/
		-- Devolver la contrasenia reiniciada
		SET @presetContrasenia = dbo.FN_RANDOM_STRING(8,'CN');

		-- Inserta la contrasenia reiniciada pero encriptada
		UPDATE Usuarios SET contrasenia = dbo.FN_ENCRIPTAR( @presetContrasenia )
		WHERE nombreUsuario = @pnombreUsuario  COLLATE SQL_Latin1_General_CP1_CS_AS;

		SET @pcorreoElectronico = (
			SELECT P.correoElectronico FROM Usuarios U
			INNER JOIN Empleado E ON E.idEmpleado = U.Empleado_idEmpleado
			INNER JOIN Persona P ON P.idPersona = E.Persona_idPersona
			WHERE U.nombreUsuario = @pnombreUsuario COLLATE SQL_Latin1_General_CP1_CS_AS
		);



        SET @pmensaje = 'Contrasenia reiniciada con exito';
	END;
    
	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
