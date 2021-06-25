-- ---------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- ---------------------------------------------------------------------------------
-- PIZCLIENTESCON
DELIMITER ;
DROP PROCEDURE IF EXISTS `PIZCLIENTESCON`;
DELIMITER $$

CREATE PROCEDURE `PIZCLIENTESCON`(
/* SP para realizar consulta de clientes*/

	Par_ClienteID               INT(11),        -- ID del Cliente
	Par_NumCon					TINYINT UNSIGNED,

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
	DECLARE Cadena_Vacia		CHAR(1);		-- Constante cadena vacia ''
	DECLARE Entero_Cero			INT(1);			-- Constante Entero cero 0
	DECLARE Cons_NO					CHAR(1);
	DECLARE Cons_Principal			INT(11);

	SET Entero_Cero					:= 0;
	SET Cadena_Vacia				:= 'S';
	SET Cons_NO						:= 'S';
	SET Cons_Principal				:= 1;

 	IF(Par_NumCon = Cons_Principal) THEN
		SELECT
			ClienteID,		NombreCompleto,			RFC,			Direccion,			Telefono
			FROM PIZCLIENTES
				WHERE
				ClienteID = Par_ClienteID;
	END IF;
END TerminaStore$$