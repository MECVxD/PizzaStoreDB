-- ---------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- ---------------------------------------------------------------------------------
-- PIZCLIENTESLIS
DELIMITER ;
DROP PROCEDURE IF EXISTS `PIZCLIENTESLIS`;
DELIMITER $$

CREATE PROCEDURE `PIZCLIENTESLIS`(
/* SP para realizar consulta del perfil del clientes*/

	Par_NombreCompleto			VARCHAR(500),   -- ID del Cliente
	Par_NumLis					TINYINT UNSIGNED,

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
	DECLARE Cons_NO				CHAR(1);
	DECLARE Lis_Principal		INT(11);

	SET Entero_Cero					:= 0;
	SET Cadena_Vacia				:= 'S';
	SET Cons_NO						:= 'S';
	SET Lis_Principal				:= 1;

 	IF(Par_NumLis = Lis_Principal) THEN
		SELECT
			ClienteID,		NombreCompleto,			RFC,			Direccion,			Telefono
			FROM PIZCLIENTES
				WHERE
				NombreCompleto LIKE Par_NombreCompleto LIMIT 15;
	END IF;
END TerminaStore$$
