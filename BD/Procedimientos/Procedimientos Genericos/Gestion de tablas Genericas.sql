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
    -- Validacion de campos nulos
    IF @pAccion = '' OR @pAccion IS NULL BEGIN
        SET @pmensaje=@pmensaje + ' Accion ';
    END;

    IF @pmensaje <> '' BEGIN
        SET @pcodigoMensaje = 3;
        SET @pmensaje = 'Error: Campos vacios: ' + @pmensaje;
        RETURN;
    END;


	-- Declaracion de Variables
	DECLARE	@vconteo INT;
	DECLARE @ConsultaSQL NVARCHAR(500);

    IF @pAccion='CONSULTAR' BEGIN
        /* Funcionalidad: Devolver informacion de una tabla
        * Construir un Select con la sigueinte informacion:
        * - Tabla de la que se desea consultar
        * - Campo del que se desea filtrar ( <nombre del campo> si es ninguno no se filtra )
        * - Caracteres a buscar ( Usar %Like% )
        * 
        * Se requieren los siguientes parametros: nombreTabla, nombreCampo
        * Devuelve en un JSON todos los datos de la tabla
        */
        
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





















	-- Declaracion de Variables
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
    IF @pAccion='INSERTAR' BEGIN
        /* Funcionalidad: Insertar informacion en una tabla
        * Construir un Insert con la sigueinte informacion:
        * - Tabla de la que se desea insertar
        * - Datos en formato JSON
        * 
        * Se requieren los siguientes parametros: nombreTabla, DATOS_JSON
        * Añade un nuevo registro a la tabla especifica con la informacion del JSON
        */
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
			DECLARE @tmpTabla TABLE (columna VARCHAR(45));
            
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
			WHERE TABLE_NAME = 'Genero';
        END TRY  
        BEGIN CATCH  
            -- Execute error retrieval routine.
			SET @pmensaje = @pmensaje + 'Formato del JSON invalido';
			IF CURSOR_STATUS('global','cursor_columns')>=-1 BEGIN
				DEALLOCATE myCursor
			END
			IF CURSOR_STATUS('global','cursor_columns_json')>=-1 BEGIN
				DEALLOCATE myCursor
			END
        END CATCH;

        IF @pmensaje <> '' BEGIN
            SET @pcodigoMensaje = 5;
            SET @pmensaje = 'Error: Validacion en la condicion del procdimiento: ' + @pmensaje;
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
END
