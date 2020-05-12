-- <=== RH_EntrevistaTrabajo ===>
/* Requisitos de las acciones:
 * INSERT: @pnumeroIdentidad, @pprimerNombre, @pprimerApellido, @psegundoApellido, @pcorreoElectronico
 * , @pdireccion, @pnumeroTelefono, @prdescripcion, @pFecha, @paccion
 * Opcional: @psegundoNombre
 *
 * Salida: @pNombreArchivo
*/
CREATE PROCEDURE RH_ENTREVISTA_TRABAJO (
    -- Parametros de Entrada
	@pnumeroIdentidad			VARCHAR(45),
	@pprimerNombre				VARCHAR(45),
	@psegundoNombre				VARCHAR(45),
	@pprimerApellido			VARCHAR(45),
	@psegundoApellido			VARCHAR(45),
	@pcorreoElectronico			VARCHAR(45),
	@pdireccion					VARCHAR(45),
	@pnumeroTelefono			VARCHAR(45),
	@pidGenero					INT,
	@pdescripcion				VARCHAR(45),
	@pFecha						DATE,
    @paccion					VARCHAR(45),
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje				INT OUTPUT,
	@pmensaje 					VARCHAR(1000) OUTPUT,

    -- Otros parametros de salida
	@pNombreArchivo 			VARCHAR(45) OUTPUT
) AS
BEGIN
    -- Declaracion de Variables
    DECLARE	@vconteo INT,
	@vidPersona INT
	;

    /* Funcionalidad: <nombre_funcionalidad>
     * Construir tres insert con la sigueinte informacion:
     * Datos: @pnumeroIdentidad, @pprimerNombre, @psegundoNombre, @pprimerApellido, @psegundoApellido, @pcorreoElectronico
	 * , @pdireccion, @pnumeroTelefono, @pidGenero, @pdescripcion, @pFecha, @pNombreArchivo
     *
     * Insertar los sigueintes datos en la tabla Persona:
     * idPersona, primerNombre, segundoNombre, primerApellido, segundoApellido, correoElectronico, numeroTelefono, numeroIdentidad
	 *
	 * Insertar los sigueintes datos en la tabla Aspirante:
	 * idAspirante, descripcion, fechaEntrevista, Persona_idPersona
	 *
	 * Insertar los sigueintes datos en la tabla Curriculum:
	 * idCurriculum, nombreArchivo, Aspirante_idAspirante
    */
    IF @paccion = 'INSERT' BEGIN
		-- Setear Valores
		SET @pcodigoMensaje=0;
		SET @pmensaje='';



		-- Validacion de campos nulos
		IF @pnumeroIdentidad = '' OR @pnumeroIdentidad IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' numeroIdentidad ';
		END;

		IF @pprimerNombre = '' OR @pprimerNombre IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' primerNombre ';
		END;

		IF @pprimerApellido = '' OR @pprimerApellido IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' primerApellido ';
		END;

		IF @psegundoApellido = '' OR @psegundoApellido IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' segundoApellido ';
		END;
		
		IF @pcorreoElectronico = '' OR @pcorreoElectronico IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' correoElectronico ';
		END;
		
		IF @pdireccion = '' OR @pdireccion IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' direccion ';
		END;
		
		IF @pnumeroTelefono = '' OR @pnumeroTelefono IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' numeroTelefono ';
		END;
		
		IF @pidGenero = '' OR @pidGenero IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' idGenero ';
		END;
		
		IF @pdescripcion = '' OR @pdescripcion IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' descripcion ';
		END;
		
		IF @pFecha = '' OR @pFecha IS NULL BEGIN
			SET @pmensaje = @pmensaje + ' Fecha ';
		END;
		
		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 3;
			SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
			RETURN;
		END;



		-- Validacion de identificadores
		-- Validacion de procedimientos
		SELECT @vconteo = COUNT(*)  FROM Empleado E
		INNER JOIN Usuarios U ON U.Empleado_idEmpleado = E.idEmpleado
		WHERE Persona_idPersona = (
			SELECT idPersona FROM Persona
			WHERE numeroIdentidad = @pnumeroIdentidad
		)
		AND Estado_Usuario_idEstado_Usuario = 1;
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = 'El aspirante ya esta registrado como un empleado: ' + @pprimerNombre + ' ' + @pprimerApellido;
		END;
		
		SELECT @vconteo = COUNT(*) FROM Telefono
		WHERE Persona_idPersona = (
			SELECT idPersona FROM Persona
			WHERE numeroIdentidad = @pnumeroIdentidad
		)
		AND numeroTelefono = @pnumeroTelefono
		IF @vconteo <> 0 BEGIN
			SET @pmensaje = @pmensaje + ' El usuario ya cuenta con este numero de telefono => ' + @pnumeroTelefono + ' ';
		END;

		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 5;
			SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			RETURN;
		END;


		
		-- Accion del procedimiento 
		-- Crear Persona
		SELECT @vconteo = COUNT(*)  FROM Persona
		WHERE numeroIdentidad = @pnumeroIdentidad;
		IF @vconteo = 0 BEGIN			
			SELECT @vconteo = COUNT(*) FROM Genero
			WHERE idGenero = @pidGenero;
			IF @vconteo = 0 BEGIN
				SET @pmensaje = @pmensaje + ' No existe el identificador => ' + CAST(@pidGenero AS VARCHAR) + ' ';
			END;
			IF @pmensaje <> '' BEGIN
				SET @pcodigoMensaje = 5;
				SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
				RETURN;
			END;

			SET @vidPersona = (SELECT MAX(idPersona) + 1 FROM Persona);

			-- INSERT Persona
			INSERT INTO Persona (
				idPersona
				,primerNombre
				,segundoNombre
				,primerApellido
				,segundoApellido
				,correoElectronico
				,direccion
				,numeroIdentidad
				,fechaIngreso
				,Genero_idGenero
			) VALUES (
				@vidPersona
				,@pprimerNombre
				,@psegundoNombre
				,@pprimerApellido
				,@psegundoApellido
				,@pcorreoElectronico
				,@pdireccion
				,@pnumeroIdentidad
				,CONVERT(DATE, GETDATE())
				,@pidGenero
			);

			-- INSERT Telefono
			INSERT INTO Telefono (
				idTelefono
				, numeroTelefono
				, Persona_idPersona
			)
			VALUES (
				(SELECT MAX(idTelefono) + 1 FROM Telefono)
				, @pnumeroTelefono
				, @vidPersona
			);

		END;

		-- Crear Aspirante
		SELECT @vconteo = COUNT(*)  FROM Aspirante
		WHERE Persona_idPersona = (
			SELECT idPersona FROM Persona
			WHERE numeroIdentidad = @pnumeroIdentidad
		);
		IF @vconteo = 0 BEGIN
			INSERT INTO Aspirante (
				idAspirante
				,descripcion
				, Persona_idPersona
			) VALUES (
				(SELECT MAX(idAspirante) + 1 FROM Aspirante)
				, ' '
				, (
					SELECT idPersona FROM Persona
					WHERE numeroIdentidad = @pnumeroIdentidad
				)
			)
		END;

		-- Fijar Fecha
		UPDATE Aspirante SET fechaEntrevista = @pFecha, descripcion = @pdescripcion
		WHERE Persona_idPersona = (
			SELECT idPersona FROM Persona
			WHERE numeroIdentidad = @pnumeroIdentidad
		);
		
		-- Crear Curriculum
		SET @pNombreArchivo = CONCAT(
			CAST( 
				(
					SELECT MAX(idCurriculum) + 1 FROM Curriculum
				) AS VARCHAR
			)
			, '. '
			, (
				SELECT CONCAT(p.primerNombre, ' ', p.primerApellido) FROM Persona p
				WHERE p.numeroIdentidad = @pnumeroIdentidad
			)
			, '.docx'
		);
		
		INSERT INTO Curriculum (
			idCurriculum
			, nombreArchivo
			, Aspirante_idAspirante
		) VALUES(
			(
				SELECT MAX(idCurriculum) + 1 FROM Curriculum
			)
			, @pNombreArchivo
			, (
				SELECT a.idAspirante FROM Persona p
				inner join Aspirante a ON p.idPersona = a.Persona_idPersona
				WHERE p.numeroIdentidad = @pnumeroIdentidad
			)
		);
		
        SET @pmensaje = 'Aspirante registrado con exito';
	END;
    
	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
