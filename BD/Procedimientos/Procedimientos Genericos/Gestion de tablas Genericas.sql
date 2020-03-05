-- <=== Gestion Tablas ===>
/* Requisitos de las acciones:
 * SELECT: @pNombreTabla, 
 * Opcional: @pNombreCampo, @pFiltroCampo
 *
 * INSERT: @pNombreCampo, @json
 *
 * UPDATE: @pNombreCampo, @json
 *
 * DELETE: @pNombreCampo, @json
*/
CREATE PROCEDURE [dbo].[GENERIC_GESTION_TABLAS](
	-- Parametros de Entrada
	@pNombreTabla						VARCHAR(250),
	@pNombreCampo						VARCHAR(250),
	@pFiltroCampo						VARCHAR(250),
    @pjson								NVarChar(MAX),
    @pAccion                            VARCHAR(45),
    
    
    -- Parametros de Salida
    -- Codigo de mensaje
    @pcodigoMensaje				INT OUTPUT,
	@pmensaje 					VARCHAR(1000) OUTPUT
)AS
BEGIN
    -- Declaracion de Variables
	DECLARE	@vconteo INT;
	DECLARE @ConsultaSQL NVARCHAR(500);
	DECLARE @tmpTabla TABLE (columna VARCHAR(45));
	DECLARE @vnombre_idCampo VARCHAR(45);
	DECLARE @vidCampo INT;
	DECLARE @idTable TABLE (id int);
	
	-- Variables String para la consulta
    DECLARE @vcolumnas VARCHAR(MAX) = ''
    	, @vvariables VARCHAR(MAX) = ''
		,@colum_name_json VARCHAR(MAX) = ''
		, @vcolumnas_json VARCHAR(MAX) = ''
	;

    -- Variables CURSOR
    DECLARE @colum_name VARCHAR(MAX)
    	, @data_type VARCHAR(MAX)
        , @character_len INT
    ;



	/* Funcionalidad: Devolver informacion de una tabla
    * Construir un Select con la sigueinte informacion:
    * - Tabla de la que se desea consultar
    * - Campo del que se desea filtrar ( <nombre del campo> si es ninguno no se filtra )
    * - Caracteres a buscar ( Usar %Like% )
    * 
    * Se requieren los siguientes parametros: nombreTabla, nombreCampo(opcional), FiltroCampo(opcional)
    * Devuelve en un JSON con todos los datos de la tabla
    */
    IF @pAccion='SELECT' BEGIN
        -- Setear Valores
        SET @pcodigoMensaje=0;
        SET @pmensaje='';
        SET @ConsultaSQL = '';


        -- Validacion de campos nulos
        IF @pNombreTabla = '' OR @pNombreTabla IS NULL BEGIN
            SET @pmensaje = @pmensaje + ' TABLE_NAME ';
        END;
        
        IF @pNombreCampo <> '' BEGIN
            IF @pFiltroCampo = '' OR @pFiltroCampo IS NULL BEGIN
                SET @pmensaje = @pmensaje + ' Filtro del Campo ';
            END;
        END;
        
        IF @pmensaje <> '' BEGIN
            SET @pcodigoMensaje = 3;
            SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
            RETURN;
        END;



        -- Validacion de identificadores
        IF @pNombreCampo <> '' BEGIN
            SELECT @vconteo = COUNT(*) FROM INFORMATION_SCHEMA.TABLES
            WHERE TABLE_NAME = @pNombreTabla;
            IF @vconteo = 0 BEGIN
                SET @pmensaje = @pmensaje + 'Tabla no existe';
            END;
            
            SELECT @vconteo = COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
            where TABLE_NAME = @pNombreTabla AND COLUMN_NAME = @pNombreCampo;
            IF @vconteo = 0 BEGIN
                SET @pmensaje = @pmensaje + 'Campo no existe';
            END;
                
            IF @pmensaje <> '' BEGIN
                SET @pcodigoMensaje = 4;
                SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
                RETURN;
            END;
        END;



        -- Validacion de procedimientos
        IF @pNombreCampo <> '' BEGIN
            SELECT @vconteo = COUNT(*) 
            FROM INFORMATION_SCHEMA.COLUMNS
            WHERE TABLE_NAME = @pNombreTabla 
                AND COLUMN_NAME = @pNombreCampo
                AND DATA_TYPE = 'VARCHAR';
            IF @vconteo = 0 BEGIN
                SET @pmensaje = @pmensaje + 'El campo a filtrar no es de tipo VARCHAR';
            END;

            IF LEN ( @pFiltroCampo )  > (
                SELECT CHARACTER_MAXIMUM_LENGTH 
                FROM INFORMATION_SCHEMA.COLUMNS
                WHERE TABLE_NAME = @pNombreTabla 
                    AND COLUMN_NAME = @pNombreCampo
                    AND DATA_TYPE = 'VARCHAR'
            ) BEGIN
                SET @pmensaje = @pmensaje + 'El tamaño del Filtro para el Campo supera el tamño del campo de la tabla';
            END;
        END;
        
        IF @pmensaje <> '' BEGIN
            SET @pcodigoMensaje = 5;
            SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
            RETURN;
        END;



        -- Accion del procedimiento 
        IF @pNombreCampo <> '' BEGIN
            SET @ConsultaSQL = 
            'SELECT * FROM ' + @pNombreTabla 
            + ' WHERE ' + @pNombreCampo + ' like ' + char(39) + '%' + @pFiltroCampo + '%' + char(39);
        END ELSE BEGIN
            SET @ConsultaSQL = 
            'SELECT * FROM ' + @pNombreTabla;
        END;
        EXEC (@ConsultaSQL);
        

        SET @pmensaje = 'Consulta Exitosa';
    END;




















	/* Funcionalidad: Insertar informacion en una tabla
    * Construir un Insert con la sigueinte informacion:
    * - Tabla de la que se desea insertar
    * - Datos en formato JSON
    * 
    * Se requieren los siguientes parametros: nombreTabla, DATOS_JSON
    * Añade un nuevo registro a la tabla especificada con la informacion del JSON
    */
    IF @pAccion='INSERT' BEGIN
        -- Setear Valores
        SET @pcodigoMensaje = 0;
        SET @pmensaje = '';
        SET @ConsultaSQL = '';



        -- Validacion de campos nulos
        IF @pNombreTabla = '' OR @pNombreTabla IS NULL BEGIN
            SET @pmensaje = @pmensaje + ' TABLE_NAME ';
        END;
        
        IF @pjson <> '' BEGIN
            IF @pjson = '' OR @pjson IS NULL BEGIN
                SET @pmensaje = @pmensaje + ' DATOS_JSON ';
            END;
        END;
        
        IF @pmensaje <> '' BEGIN
            SET @pcodigoMensaje = 3;
            SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
            RETURN;
        END;



        -- Validacion de identificadores
		SELECT @vconteo = COUNT(*) FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_NAME = @pNombreTabla;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + 'Tabla no existe';
		END;
            
		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;
        


        -- Validacion de procedimientos
        BEGIN TRY
			INSERT INTO @tmpTabla SELECT x.[key] FROM OPENJSON(@pjson, '$') AS x;
            
            DECLARE cursor_columns_json CURSOR
            FOR SELECT columna FROM @tmpTabla;
			
			DECLARE cursor_columns CURSOR
			FOR SELECT 
    			COLUMN_NAME
    			, DATA_TYPE
    			, CHARACTER_MAXIMUM_LENGTH
		    FROM 
    			INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = @pNombreTabla;
        END TRY  
        BEGIN CATCH  
            -- Execute error retrieval routine.
			IF ERROR_NUMBER() = 245 BEGIN
				SET @pmensaje = @pmensaje + 'El tipo de dato de los campos del JSON no coinciden con los de la tabla original ';
			END ELSE IF ERROR_NUMBER() = 13609 BEGIN
				SET @pmensaje = @pmensaje + 'El formato en el que esta escrito el JSON es inválido';
			END ELSE BEGIN
				SET @pmensaje = @pmensaje + 'Formato del JSON invalido'  + ' ' + ERROR_MESSAGE() + CAST(ERROR_NUMBER() AS VARCHAR);
			END;
        END CATCH;

        IF @pmensaje <> '' BEGIN
            SET @pcodigoMensaje = 5;
            SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			IF CURSOR_STATUS('global','cursor_columns')>=-1 BEGIN
				DEALLOCATE cursor_columns;
			END
			IF CURSOR_STATUS('global','cursor_columns_json')>=-1 BEGIN
				DEALLOCATE cursor_columns_json;
			END
            RETURN;
        END;
		
        OPEN cursor_columns_json;
        FETCH NEXT FROM cursor_columns_json INTO @colum_name_json;
        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @vcolumnas_json = @vcolumnas_json + @colum_name_json;
			FETCH NEXT FROM cursor_columns_json INTO @colum_name_json;
			IF @@FETCH_STATUS = 0 BEGIN
        		SET @vcolumnas_json = @vcolumnas_json + ', ';
        	END;
        END;
        CLOSE cursor_columns_json;
        DEALLOCATE cursor_columns_json;
        
        -- Abrir cursor
        OPEN cursor_columns;

        -- Se prepara el cursor
        FETCH NEXT FROM cursor_columns INTO @colum_name, @data_type, @character_len;

        -- Bucle
        WHILE @@FETCH_STATUS = 0
        BEGIN
        	-- Guardando los nombres de los campos de la tabla
        	SET @vcolumnas = @vcolumnas + @colum_name;
        	IF @data_type = 'varchar' BEGIN
        		SET @vvariables = @vvariables + @colum_name + ' ' + @data_type + '(' + CAST(@character_len AS VARCHAR) + ')';
        	END ELSE BEGIN
        		SET @vvariables = @vvariables + @colum_name + ' ' + @data_type;
        	END;

            -- Obteniendo columna por columna de la tabla por registro
            FETCH NEXT FROM cursor_columns INTO
        		@colum_name
        		, @data_type
        		, @character_len
        	;

        	-- Identifica si habra otra vuelta del ciclo para agregar otra columna
        	IF @@FETCH_STATUS = 0 BEGIN
        		SET @vcolumnas = @vcolumnas + ', '
        		SET @vvariables = @vvariables + ', '
        	END;
        END;
		
		-- Se cierra el cursor
        CLOSE cursor_columns;
        DEALLOCATE cursor_columns;
		
        IF @vcolumnas_json <> @vcolumnas BEGIN
            SET @pmensaje = 'Los campos no coinciden con la tabla: ' + @pNombreTabla;
        END;
		IF @vcolumnas_json is null BEGIN
		    SET @pmensaje = 'El JSON esta vacio: ';
		END;
        IF @pmensaje <> '' BEGIN
            SET @pcodigoMensaje = 5;
            SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
            RETURN;
        END;



        -- Accion del procedimiento 
        -- Se construye la consulta INSERT a partir de los nombres de las columnas
        SET @ConsultaSQL = 'INSERT INTO ' + @pNombreTabla + ' ( '
        	+ @vcolumnas
        	+ ' ) (SELECT '
        	+ @vcolumnas
        	+ ' FROM OPENJSON(' + CHAR(39) + @pjson + CHAR(39) + ') WITH ( '
        	+ @vvariables
        	+ ' ))'
        ;

		BEGIN TRY
			-- Se ejecuta la consulta
			EXEC (@ConsultaSQL);
		END TRY  
        BEGIN CATCH
            -- Execute error retrieval routine.
			SET @pmensaje = @pmensaje + 'Datos no validos - ';
			SET @pmensaje = @pmensaje + CAST(ERROR_NUMBER() AS VARCHAR) + ': ' +ERROR_MESSAGE();
        END CATCH;
		
		IF @pmensaje <> '' BEGIN
            SET @pcodigoMensaje = 5;
            SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
            RETURN;
        END;

        SET @pmensaje = 'Registro insertado';
    END;






















	/* Funcionalidad: Actualizar informacion en una tabla
    * Construir un Update con la sigueinte informacion:
    * - Tabla de la que se desea actualizar
    * - Datos en formato JSON
    * 
    * Se requieren los siguientes parametros: nombreTabla, DATOS_JSON
    * Actualiza un registro de la tabla especificada con la informacion del JSON
    */
	IF @pAccion='UPDATE' BEGIN
        -- Setear Valores
        SET @pcodigoMensaje = 0;
        SET @pmensaje = '';
        SET @ConsultaSQL = '';



        -- Validacion de campos nulos
        IF @pNombreTabla = '' OR @pNombreTabla IS NULL BEGIN
            SET @pmensaje = @pmensaje + ' TABLE_NAME ';
        END;
        
        IF @pjson <> '' BEGIN
            IF @pjson = '' OR @pjson IS NULL BEGIN
                SET @pmensaje = @pmensaje + ' DATOS_JSON ';
            END;
        END;
        
        IF @pmensaje <> '' BEGIN
            SET @pcodigoMensaje = 3;
            SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
            RETURN;
        END;



        -- Validacion de identificadores
		SELECT @vconteo = COUNT(*) FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_NAME = @pNombreTabla;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + 'Tabla no existe';
		END;
            
		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;
        


        -- Validacion de procedimientos
        BEGIN TRY
			INSERT INTO @tmpTabla SELECT x.[key] FROM OPENJSON(@pjson, '$') AS x;
            
            DECLARE cursor_columns_json CURSOR
            FOR SELECT columna FROM @tmpTabla;
			
			-- Obtiene el campo id y su valor de los datos del JSON
			SET @vnombre_idCampo = (SELECT TOP 1 columna FROM @tmpTabla);
			SET @ConsultaSQL = 'SELECT * FROM openjson(' + CHAR(39) + @pjson + CHAR(39) + ') WITH (' + @vnombre_idCampo + ' int ' + CHAR(39) + '$.' + @vnombre_idCampo + CHAR(39) + ')';
			INSERT INTO @idTable (id) EXEC (@ConsultaSQL);
			SELECT TOP 1 @vidCampo = id FROM @idTable;
			
			DECLARE cursor_columns CURSOR
			FOR SELECT 
    			COLUMN_NAME
    			, DATA_TYPE
    			, CHARACTER_MAXIMUM_LENGTH
		    FROM 
    			INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = @pNombreTabla;
        END TRY  
        BEGIN CATCH  
            -- Execute error retrieval routine.
			IF ERROR_NUMBER() = 245 BEGIN
				SET @pmensaje = @pmensaje + 'El tipo de dato de los campos del JSON no coinciden con los de la tabla original ';
			END ELSE IF ERROR_NUMBER() = 13609 BEGIN
				SET @pmensaje = @pmensaje + 'El formato en el que esta escrito el JSON es inválido';
			END ELSE BEGIN
				SET @pmensaje = @pmensaje + 'Formato del JSON invalido'  + ' ' + ERROR_MESSAGE() + CAST(ERROR_NUMBER() AS VARCHAR);
			END;
        END CATCH;

		SET @ConsultaSQL = 'SELECT COUNT(' + @vnombre_idCampo + ') FROM ' + @pNombreTabla
			+ ' WHERE ' + @vnombre_idCampo + ' = ' + CAST(@vidCampo AS VARCHAR);
		DELETE FROM @idTable;
		INSERT INTO @idTable (id) EXEC (@ConsultaSQL);
		SELECT TOP 1 @vconteo = id FROM @idTable;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + 'EL registro no existe';
		END;
		
        IF @pmensaje <> '' BEGIN
            SET @pcodigoMensaje = 5;
            SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			IF CURSOR_STATUS('global','cursor_columns')>=-1 BEGIN
				DEALLOCATE cursor_columns;
			END
			IF CURSOR_STATUS('global','cursor_columns_json')>=-1 BEGIN
				DEALLOCATE cursor_columns_json;
			END
            RETURN;
        END;
		
		
        OPEN cursor_columns_json;
        FETCH NEXT FROM cursor_columns_json INTO @colum_name_json;
        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @vcolumnas_json = @vcolumnas_json + @colum_name_json + ' = B.' + @colum_name_json;
			FETCH NEXT FROM cursor_columns_json INTO @colum_name_json;
			IF @@FETCH_STATUS = 0 BEGIN
        		SET @vcolumnas_json = @vcolumnas_json + ', ';
        	END;
        END;
        CLOSE cursor_columns_json;
        DEALLOCATE cursor_columns_json;
        
        -- Abrir cursor
        OPEN cursor_columns;

        -- Se prepara el cursor
        FETCH NEXT FROM cursor_columns INTO @colum_name, @data_type, @character_len;

        -- Bucle
        WHILE @@FETCH_STATUS = 0
        BEGIN
        	-- Guardando los nombres de los campos de la tabla
        	SET @vcolumnas = @vcolumnas + @colum_name + ' = B.' + @colum_name;
        	IF @data_type = 'varchar' BEGIN
        		SET @vvariables = @vvariables + @colum_name + ' ' + @data_type + '(' + CAST(@character_len AS VARCHAR) + ')';
        	END ELSE BEGIN
        		SET @vvariables = @vvariables + @colum_name + ' ' + @data_type;
        	END;

            -- Obteniendo columna por columna de la tabla por registro
            FETCH NEXT FROM cursor_columns INTO
        		@colum_name
        		, @data_type
        		, @character_len
        	;

        	-- Identifica si habra otra vuelta del ciclo para agregar otra columna
        	IF @@FETCH_STATUS = 0 BEGIN
        		SET @vcolumnas = @vcolumnas + ', '
        		SET @vvariables = @vvariables + ', '
        	END;
        END;
		
		-- Se cierra el cursor
        CLOSE cursor_columns;
        DEALLOCATE cursor_columns;
		
        IF @vcolumnas_json <> @vcolumnas BEGIN
            SET @pmensaje = 'Los campos no coinciden con la tabla: ' + @pNombreTabla;
        END;
		IF @vcolumnas_json is null BEGIN
		    SET @pmensaje = 'El JSON esta vacio: ';
		END;
        IF @pmensaje <> '' BEGIN
            SET @pcodigoMensaje = 5;
            SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
            RETURN;
        END;
		


        -- Accion del procedimiento 
        -- Se construye la consulta INSERT a partir de los nombres de las columnas
        SET @ConsultaSQL = 'UPDATE ' + @pNombreTabla + ' SET '
        	+ @vcolumnas
        	+ ' FROM ' + @pNombreTabla + ' AS A '
        	+ ' JOIN OPENJSON(' + CHAR(39) + @pjson + CHAR(39) + ') WITH ( '
        	+ @vvariables
        	+ ' ) B ON B.' + @vnombre_idCampo + ' = A.' + @vnombre_idCampo
        ;

		BEGIN TRY
			-- Se ejecuta la consulta
			EXEC (@ConsultaSQL);
		END TRY  
        BEGIN CATCH
            -- Execute error retrieval routine.
			SET @pmensaje = @pmensaje + 'Datos del JSON no validos - ';
			SET @pmensaje = @pmensaje + CAST(ERROR_NUMBER() AS VARCHAR) + ': ' + ERROR_MESSAGE();
        END CATCH;
		
		IF @pmensaje <> '' BEGIN
            SET @pcodigoMensaje = 5;
            SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
            RETURN;
        END;

        SET @pmensaje = 'Registro actualizado';
    END;






















	/* Funcionalidad: Eliminar informacion en una tabla
    * Construir un Delete con la sigueinte informacion:
    * - Tabla de la que se desea eliminar
    * - Datos en formato JSON
    * 
    * Se requieren los siguientes parametros: nombreTabla, DATOS_JSON
    * Elimina un registro de la tabla especificada con la informacion del JSON
    */
	IF @pAccion='DELETE' BEGIN
        -- Setear Valores
        SET @pcodigoMensaje = 0;
        SET @pmensaje = '';
        SET @ConsultaSQL = '';



        -- Validacion de campos nulos
        IF @pNombreTabla = '' OR @pNombreTabla IS NULL BEGIN
            SET @pmensaje = @pmensaje + ' TABLE_NAME ';
        END;
        
        IF @pjson <> '' BEGIN
            IF @pjson = '' OR @pjson IS NULL BEGIN
                SET @pmensaje = @pmensaje + ' DATOS_JSON ';
            END;
        END;
        
        IF @pmensaje <> '' BEGIN
            SET @pcodigoMensaje = 3;
            SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
            RETURN;
        END;



        -- Validacion de identificadores
		SELECT @vconteo = COUNT(*) FROM INFORMATION_SCHEMA.TABLES
		WHERE TABLE_NAME = @pNombreTabla;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + 'Tabla no existe';
		END;
            
		IF @pmensaje <> '' BEGIN
			SET @pcodigoMensaje = 4;
			SET @pmensaje = 'Error: Identificadores no validos: ' + @pmensaje;
			RETURN;
		END;
        


        -- Validacion de procedimientos
        BEGIN TRY
			INSERT INTO @tmpTabla SELECT x.[key] FROM OPENJSON(@pjson, '$') AS x;

			-- Obtiene el campo id y su valor de los datos del JSON
			SET @vnombre_idCampo = (SELECT TOP 1 columna FROM @tmpTabla);
			SET @ConsultaSQL = 'SELECT * FROM OPENJSON(' + CHAR(39) + @pjson + CHAR(39) + ') WITH (' + @vnombre_idCampo + ' int ' + CHAR(39) + '$.' + @vnombre_idCampo + CHAR(39) + ')';
			INSERT INTO @idTable (id) EXEC (@ConsultaSQL);
			SELECT TOP 1 @vidCampo = id FROM @idTable;

        END TRY  
        BEGIN CATCH  
            -- Execute error retrieval routine.
			IF ERROR_NUMBER() = 245 BEGIN
				SET @pmensaje = @pmensaje + 'El tipo de dato de los campos del JSON no coinciden con los de la tabla original ';
			END ELSE IF ERROR_NUMBER() = 13609 BEGIN
				SET @pmensaje = @pmensaje + 'El formato en el que esta escrito el JSON es inválido';
			END ELSE BEGIN
				SET @pmensaje = @pmensaje + 'Formato del JSON invalido'  + ' ' + ERROR_MESSAGE() + CAST(ERROR_NUMBER() AS VARCHAR);
			END;
        END CATCH;

		SET @ConsultaSQL = 'SELECT COUNT(' + @vnombre_idCampo + ') FROM ' + @pNombreTabla
			+ ' WHERE ' + @vnombre_idCampo + ' = ' + CAST(@vidCampo AS VARCHAR);
		DELETE FROM @idTable;
		INSERT INTO @idTable (id) EXEC (@ConsultaSQL);
		SELECT TOP 1 @vconteo = id FROM @idTable;
		IF @vconteo = 0 BEGIN
			SET @pmensaje = @pmensaje + 'EL registro no existe';
		END;
		
		SELECT @vconteo = COUNT(COLUMN_NAME) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @pNombreTabla AND COLUMN_NAME = @vnombre_idCampo;
		IF @vconteo = 0 BEGIN
		    SET @pmensaje = 'EL campo (' + @vnombre_idCampo + ') no pertenece a la tabla (' + @pNombreTabla + ')';
		END;

		IF @vcolumnas_json is null BEGIN
		    SET @pmensaje = 'El JSON esta vacio: ';
		END;
        
		IF @pmensaje <> '' BEGIN
            SET @pcodigoMensaje = 5;
            SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
			IF CURSOR_STATUS('global','cursor_columns')>=-1 BEGIN
				DEALLOCATE cursor_columns;
			END
			IF CURSOR_STATUS('global','cursor_columns_json')>=-1 BEGIN
				DEALLOCATE cursor_columns_json;
			END
            RETURN;
        END;



        -- Accion del procedimiento 
        -- Se construye la consulta INSERT a partir de los nombres de las columnas
        SET @ConsultaSQL = 'DELETE FROM ' + @pNombreTabla 
        	+ ' WHERE ' + @vnombre_idCampo + ' = ' + CAST(@vidCampo AS VARCHAR)
        ;

		BEGIN TRY
			-- Se ejecuta la consulta
			EXEC (@ConsultaSQL);
		END TRY  
        BEGIN CATCH
            -- Execute error retrieval routine.
			SET @pmensaje = @pmensaje + 'Datos del JSON no validos - ';
			SET @pmensaje = @pmensaje + CAST(ERROR_NUMBER() AS VARCHAR) + ': ' + ERROR_MESSAGE();
        END CATCH;
		
		IF @pmensaje <> '' BEGIN
            SET @pcodigoMensaje = 5;
            SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
            RETURN;
        END;

        SET @pmensaje = 'Registro eliminado';
    END;

	-- En caso de no elegir una accion
	IF @pmensaje = '' BEGIN
		SET @pcodigoMensaje = -1;
		SET @pmensaje = 'Error: No se definio la accion a realizar ' + @pmensaje;
	END;
END
