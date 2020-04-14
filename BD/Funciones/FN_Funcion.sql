-- <=== Devolver codigo Empleado ===>
/* Parametros de entrada:
 * Opcional: @piniciales, @pnitem, @pitem_max
 * 
 * RETUNR: @vcodigoEmpleado VARCHAR(45)
*/
CREATE FUNCTION FN_GENERAR_CODIGO_EMP (
    -- Parametros de Entrada
    @piniciales					VARCHAR(45),
    @pnitem						INT,
    @pitem_max					INT
) 
-- Return
RETURNS VARCHAR(45) --<TIPO_DATO>
AS BEGIN
    -- Declaracion de Variables
    DECLARE	@vcodigoEmpleado VARCHAR(45);
	SET @vcodigoEmpleado = CAST(@pnitem AS VARCHAR);
	IF (LEN(@vcodigoEmpleado) > @pitem_max) BEGIN
		RETURN NULL;
	END;
	
	DECLARE @i INT = 1;
	WHILE ( @i <= @pitem_max - LEN(CAST(@pnitem AS VARCHAR)) ) BEGIN
		SET @vcodigoEmpleado = '0' + @vcodigoEmpleado;
		SET @i = @i + 1;
	END;
    RETURN CAST(@piniciales AS VARCHAR) + @vcodigoEmpleado;
END;
