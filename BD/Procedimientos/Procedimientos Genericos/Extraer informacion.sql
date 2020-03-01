CREATE PROCEDURE GENERIC_GESTION_TABLAS(
	-- Parametros de Entrada
	@pNombreTabla						VARCHAR(250),
	@pNombreCampo						VARCHAR(250),
	@pFiltroCampo						VARCHAR(250),
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

    -- ACCIONES: CONSULTAR, INSERTAR, ACTUALIZAR Y ELIMINAR
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
        -- Declaracion de Variables
        DECLARE	@vconteo INT;
        DECLARE @ConsultaSQL NVARCHAR(500);


        -- Setear Valores
        SET @pcodigoMensaje=0;
        SET @pmensaje='';
        SET @ConsultaSQL = '';


        -- Validacion de campos nulos
        IF @pNombreTabla = '' OR @pNombreTabla IS NULL BEGIN
            SET @pmensaje=@pmensaje + ' TABLE_NAME ';
        END;
        
        IF @pNombreCampo <> '' BEGIN
            IF @pFiltroCampo = '' OR @pFiltroCampo IS NULL BEGIN
                SET @pmensaje=@pmensaje + ' Filtro del Campo ';
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
                SET @pmensaje = @pmensaje + 'El tama�o del Filtro para el Campo supera el tam�o del campo de la tabla';
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
            select @ConsultaSQL;
        END ELSE BEGIN
            SET @ConsultaSQL = 
            'SELECT * FROM ' + @pNombreTabla;
            select @ConsultaSQL;
        END;
        EXEC (@ConsultaSQL);
        

        SET @pmensaje = 'Acceso Exitoso';
    END;






















    IF @pAccion='INSERTAR' BEGIN
        /* Funcionalidad: Insertar informacion en una tabla
        * Construir un Insert con la sigueinte informacion:
        * - Tabla de la que se desea insertar
        * - Datos en formato JSON
        * 
        * Se requieren los siguientes parametros: nombreTabla, JSON
        * Devuelve en un JSON todos los datos de la tabla
        */
        -- Declaracion de Variables
        DECLARE	@vconteo INT;
        DECLARE @ConsultaSQL NVARCHAR(500);


        -- Setear Valores
        SET @pcodigoMensaje=0;
        SET @pmensaje='';
        SET @ConsultaSQL = '';


        -- Validacion de campos nulos
        IF @pNombreTabla = '' OR @pNombreTabla IS NULL BEGIN
            SET @pmensaje=@pmensaje + ' TABLE_NAME ';
        END;
        
        IF @pNombreCampo <> '' BEGIN
            IF @pFiltroCampo = '' OR @pFiltroCampo IS NULL BEGIN
                SET @pmensaje=@pmensaje + ' Filtro del Campo ';
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
                SET @pmensaje = @pmensaje + 'El tama�o del Filtro para el Campo supera el tam�o del campo de la tabla';
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
            select @ConsultaSQL;
        END ELSE BEGIN
            SET @ConsultaSQL = 
            'SELECT * FROM ' + @pNombreTabla;
            select @ConsultaSQL;
        END;
        EXEC (@ConsultaSQL);
        

        SET @pmensaje = 'Acceso Exitoso';
    END;
END
