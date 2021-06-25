-- ---------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- ---------------------------------------------------------------------------------
-- SP_MAURICIOPRO
DELIMITER ;
DROP PROCEDURE IF EXISTS `SP_MAURICIOPRO`;
DELIMITER $$

CREATE PROCEDURE `SP_MAURICIOPRO`(
/* SP para realizar suma de los dias*/

	Par_FechaInicio             DATE,        	 
	Par_NumDias					INT(2),

	Par_Salida					CHAR(1), 		-- Indica mensaje de Salida
	INOUT Par_NumErr			INT(11),		-- Numero de Error
	INOUT Par_ErrMen			VARCHAR(400),	-- Descripcion de Error

	Aud_EmpresaID				INT(11),		-- Parametro de Auditoria
	Aud_Usuario					INT(11),		-- Parametro de Auditoria
	Aud_FechaActual				DATETIME,		-- Parametro de Auditoria
	Aud_DireccionIP				VARCHAR(15),	-- Parametro de Auditoria
	Aud_ProgramaID				VARCHAR(50),	-- Parametro de Auditoria
	Aud_Sucursal				INT(11),		-- Parametro de Auditoria
	Aud_NumTransaccion			BIGINT(20)		-- Parametro de Auditoria

)
TerminaStore: BEGIN
	-- Declaracion de Constantes
	DECLARE Cadena_Vacia			CHAR(1);		-- Constante cadena vacia ''
	DECLARE Entero_Cero				INT(1);			-- Constante Entero cero 0
	DECLARE Fecha_Vacia				DATE;
	DECLARE SalidaSi				CHAR(1);

	SET Entero_Cero					:= 0;
	SET Cadena_Vacia				:= 'S';
	SET Fecha_Vacia					:= '1900-01-01';
	SET SalidaSi					:= 'S';

	ManejoErrores:BEGIN

		IF(Par_NumDias < 5) THEN
			SELECT DATE_ADD(Par_FechaInicio, INTERVAL Par_NumDias DAY) AS FEHCA
			ELSE 
			SET Par_ErrMen='El numero de dias es mayor a 5'
		END IF;
	END ManejoErrores;
END TerminaStore$$
