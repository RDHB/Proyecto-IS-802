-- <=== Nombre_Funcion ===>
/* Parametros de entrada:
 * Opcional: <@parametro1>, <@parametro2> ...
 * 
 * RETUNR: Dato1 <TIPO_DATO>
*/
ALTER FUNCTION [dbo].[FN_ENCRIPTAR] (
    -- Parametros de Entrada
    @ptexto_entrada					VARCHAR(45)
) 
-- Return
RETURNS VARCHAR(45) --<TIPO_DATO>
AS BEGIN
    -- Declaracion de Variables
	DECLARE @tCaracteres TABLE(
		id INT
		, simbolo VARCHAR(1)
		, consontante VARCHAR(1)
		, vocales VARCHAR(1)
	);
	INSERT INTO @tCaracteres (
		id
		, simbolo
		, consontante
		, vocales
	) VALUES
	(0, '!','f','o')
	, (1, '?','C','e')
	, (2, '*','D','U')
	, (3, ',','M','E')
	, (4, '/','N','O')
	, (5, '.','F','A')
	, (6, '-','c','i')
	, (7, '_','d','u')
	, (8, '+','m','a')
	, (9, ' ','n','I')
	;
	
    
	DECLARE	@vtexto_salida VARCHAR(45) = ''
		, @vletra VARCHAR(1) = ''
		, @vnumero_text VARCHAR(1) = ''
	;
	DECLARE @vi INT = 0
		, @vj INT = 0
	;

	

	WHILE (@vi < LEN(@ptexto_entrada) ) BEGIN
		SET @vletra = SUBSTRING(@ptexto_entrada, @vi+1, 1); -- Obtiene la letra a ser reemplazada
		SET @vj = 0;
		WHILE (@vj < 10) BEGIN
			SET @vnumero_text = CAST(@vj AS VARCHAR); -- Numero convertido en Texto
			SET @vnumero_text = REPLACE(@vnumero_text,' ','')
			
			-- Se reemplaza la seccion de los simbolos con la seccion de las consonantes
			IF (@vletra = (SELECT simbolo FROM @tCaracteres WHERE id = @vj) COLLATE SQL_Latin1_General_CP1_CS_AS) BEGIN
				SET @vletra = (SELECT consontante FROM @tCaracteres WHERE id = @vj);

			-- Se reemplaza la seccion de las consonantes con la seccion de los simbolos
			END ELSE IF (@vletra = (SELECT consontante FROM @tCaracteres WHERE id = @vj) COLLATE SQL_Latin1_General_CP1_CS_AS) BEGIN
				SET @vletra = (SELECT simbolo FROM @tCaracteres WHERE id = @vj);

			-- Se reemplazan los numeros con vocales
			END ELSE IF (@vletra = @vnumero_text) BEGIN
				SET @vletra = (SELECT vocales FROM @tCaracteres WHERE id = @vj);

			-- Se reemplazan las vocales con los numeros
			END ELSE IF (@vletra = (SELECT vocales FROM @tCaracteres WHERE id = @vj) COLLATE SQL_Latin1_General_CP1_CS_AS) BEGIN
				SET @vletra = @vnumero_text;

			END;
			
			SET @vj += 1;
		END;
		
		SET @vtexto_salida = @vtexto_salida + @vletra;
		SET @vi += 1;
	END;
	

    RETURN @vtexto_salida;
END;
