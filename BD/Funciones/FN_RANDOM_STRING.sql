-- <=== Nombre_Funcion ===>
/* Parametros de entrada:
 * Opcional: <@parametro1>, <@parametro2> ...
 * 
 * RETUNR: Dato1 <TIPO_DATO>
*/
CREATE FUNCTION FN_RANDOM_STRING (
    @size AS INT, --Tamaño de la cadena aleatoria
    @op AS VARCHAR(2) --Opción para letras(ABC..), numeros(123...) o ambos.
)
-- Return
RETURNS VARCHAR(62) --<TIPO_DATO>
AS BEGIN
	-- Declaracion de Variables
	DECLARE @chars AS VARCHAR(52),
	@numbers AS VARCHAR(10),
	@strChars AS VARCHAR(62),        
	@strPass AS VARCHAR(62),
	@index AS INT,
	@cont AS INT

	SET @strPass = ''
	SET @strChars = ''    
	SET @chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	SET @numbers = '0123456789'

	SET @strChars = (
		CASE @op WHEN 'C' THEN @chars --Letras
			WHEN 'N' THEN @numbers --Números
			WHEN 'CN' THEN @chars + @numbers --Ambos (Letras y Números)
			ELSE '------'
		END
	);

	SET @cont = 0
	WHILE @cont < @size
	BEGIN
		SET @index = ceiling( ( SELECT rnd FROM vwRandom ) * (len(@strChars)))--Uso de la vista para el Rand() y no generar error.
		SET @strPass = @strPass + substring(@strChars, @index, 1)
		SET @cont = @cont + 1
	END    
	
	RETURN @strPass
END;
