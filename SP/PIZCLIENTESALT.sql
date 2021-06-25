-- ---------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- ---------------------------------------------------------------------------------
-- PIZCLIENTESALT
DELIMITER ;
DROP PROCEDURE IF EXISTS `PIZCLIENTESALT`;
DELIMITER $$

CREATE PROCEDURE `PIZCLIENTESALT`(
/* SP para realizar alta de clientes*/
	Par_Nombres					VARCHAR(250), 	-- Nombres del Cliente
	Par_Apellidos				VARCHAR(250), 	-- Apellidos del Cliente
	Par_Estatus					CHAR(1),			-- Estatus del Cliente\nA .- Activo\nB .- Bloqueado\nC .- Cancelado o Baja\nI .- Inactivo
	Par_FechaAlta				DATE,			-- Fecha alta cliente 
	Par_RFC						CHAR(13), 	 	-- RFC del Cliente
	Par_Direccion				VARCHAR(200),	-- Direccion Completa del Cliente
	Par_FechaNacimiento			DATE, 		 	-- Fecha de Nacimiento del Cliente
	Par_Telefono				VARCHAR(10), 	-- Telefono Oficial del Cliente
	
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
	-- Declaracion de Variables
	DECLARE Var_Control			VARCHAR(50);
	DECLARE Var_Consecutivo		VARCHAR(200);
	DECLARE Var_ClienteID       INT(11);		-- Numero de Cliente
	DECLARE Var_NombreCompleto	VARCHAR(500);	-- Nombre Completo del Cliente
	
	-- Declaracion de Constantes
	DECLARE Cadena_Vacia		CHAR(1);		-- Constante cadena vacia ''
	DECLARE Entero_Cero			INT(1);			-- Constante Entero cero 0
	DECLARE Fecha_Vacia			DATE;			-- Constante Fecha vacia 1900-01-01
	DECLARE SalidaSi			CHAR(1);
	
	-- Asignacion de constantes
	SET Cadena_Vacia			:= '';
	SET Entero_Cero				:= 0;
	SET Fecha_Vacia				:= '1900-01-01';
	SET SalidaSi				:= 'S';

	ManejoErrores:BEGIN
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
			BEGIN
				SET Par_NumErr := 001;
				SET Par_ErrMen := CONCAT('El SAFI ha tenido un problema al concretar la operacion. ',
									'Disculpe las molestias que esto le ocasiona. Ref: SP-PIZCLIENTESALT');
			END;

			IF(IFNULL(Par_Nombres,Cadena_Vacia)=Cadena_Vacia)THEN
				SET Par_NumErr  	:= 002;
				SET Par_ErrMen  	:= 'El campo de nombrs esta vacio. ';
				SET Var_Control		:= 'nombres';
				SET Var_Consecutivo	:= Cadena_Vacia;
				LEAVE ManejoErrores;
			END IF;

			IF(IFNULL(Par_Apellidos,Cadena_Vacia)=Cadena_Vacia)THEN
				SET Par_NumErr  	:= 003;
				SET Par_ErrMen  	:= 'Los Apellidos estan Vacio. ';
				SET Var_Control		:= 'apellidos';
				SET Var_Consecutivo	:= Cadena_Vacia;
				LEAVE ManejoErrores;
			END IF;

			IF(IFNULL(Par_Estatus,Cadena_Vacia)=Cadena_Vacia)THEN
				SET Par_NumErr  	:= 004;
				SET Par_ErrMen  	:= 'El campo estatus esta vacio. ';
				SET Var_Control		:= 'estatus';
				SET Var_Consecutivo	:= Cadena_Vacia;
				LEAVE ManejoErrores;
			END IF;

			IF(IFNULL(Par_FechaAlta,Fecha_Vacia)=Fecha_Vacia)THEN
				SET Par_NumErr  	:= 005;
				SET Par_ErrMen  	:= 'El campo de fecha esta vacio. ';
				SET Var_Control		:= 'fecha';
				SET Var_Consecutivo	:= Fecha_Vacia;
				LEAVE ManejoErrores;
			END IF;

			IF(IFNULL(Par_RFC,Cadena_Vacia)=Cadena_Vacia)THEN
				SET Par_NumErr  	:= 006;
				SET Par_ErrMen  	:= 'El campo de RFC esta vacio. ';
				SET Var_Control		:= 'RFC';
				SET Var_Consecutivo	:= Cadena_Vacia;
				LEAVE ManejoErrores;
			END IF;

			IF(IFNULL(Par_Direccion,Cadena_Vacia)=Cadena_Vacia)THEN
				SET Par_NumErr  	:= 007;
				SET Par_ErrMen  	:= 'El campo de dirección esta vacio. ';
				SET Var_Control		:= 'direccion';
				SET Var_Consecutivo	:= Cadena_Vacia;
				LEAVE ManejoErrores;
			END IF;

			IF(IFNULL(Par_FechaNacimiento,Fecha_Vacia)=Fecha_Vacia)THEN
				SET Par_NumErr  	:= 008;
				SET Par_ErrMen  	:= 'El campo de fecha de nacimiento esta vacio. ';
				SET Var_Control		:= 'fechaNacimiento';
				SET Var_Consecutivo	:= Fecha_Vacia;
				LEAVE ManejoErrores;
			END IF;

			IF(IFNULL(Par_Telefono,Cadena_Vacia)=Cadena_Vacia)THEN
				SET Par_NumErr  	:= 009;
				SET Par_ErrMen  	:= 'El campo de telefono esta vacio. ';
				SET Var_Control		:= 'telefono';
				SET Var_Consecutivo	:= Cadena_Vacia;
				LEAVE ManejoErrores;
			END IF;

			SET Var_NombreCompleto := CONCAT(Par_Nombres,' ',Par_Apellidos);

			SET Var_ClienteID := (SELECT MAX(ClienteID) FROM PIZCLIENTES);
			SET Var_ClienteID := IFNULL(Var_ClienteID, Entero_Cero) +1;

			INSERT INTO PIZCLIENTES(
				ClienteID,		Nombres,			Apellidos,		NombreCompleto,		Estatus,	
				FechaAlta,		RFC,				Direccion,		FechaNacimiento, 	Telefono,
				EmpresaID,		Usuario,			FechaActual,	DireccionIP,		ProgramaID,
				Sucursal,		NumTransaccion
			)VALUES(
				Var_ClienteID,	Par_Nombres,		Par_Apellidos,	Var_NombreCompleto,	Par_Estatus,
				Par_FechaAlta, 	Par_RFC,			Par_Direccion,	Par_FechaNacimiento,Par_Telefono,
				Aud_EmpresaID,	Aud_Usuario,		Aud_FechaActual,Aud_DireccionIP,	Aud_ProgramaID,
				Aud_Sucursal,	Aud_NumTransaccion);

		SET Par_NumErr		:= 000;
		SET Par_ErrMen		:= 'Cliente Agregado Exitosamente';
		SET Var_Control		:= 'ClienteID';
		SET Var_Consecutivo	:= Var_ClienteID;

	END ManejoErrores;

	IF (Par_Salida=SalidaSi)THEN
		SELECT Par_NumErr AS NumErr, 
		Par_ErrMen AS ErrMen,
		Var_Control AS Control,
		Var_Consecutivo AS Consecutivo;
	END IF;
END TerminaStore$$
