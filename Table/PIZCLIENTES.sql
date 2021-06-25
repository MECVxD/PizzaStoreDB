-- ---------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- ---------------------------------------------------------------------------------
-- PIZCLIENTES
DELIMITER ;
DROP TABLE IF EXISTS `PIZCLIENTES`;
DELIMITER $$

CREATE TABLE `PIZCLIENTES` (
  ClienteID               INT(11)        NOT NULL      COMMENT 'Numero de Cliente',
  Nombres                 VARCHAR(250)   DEFAULT NULL  COMMENT 'Nombres del Cliente',
  Apellidos               VARCHAR(250)   DEFAULT NULL  COMMENT 'Apellidos del Cliente',
  NombreCompleto          VARCHAR(500)   NOT NULL      COMMENT 'Nombre Completo del\nCliente',
  Estatus                 CHAR(1)        DEFAULT NULL  COMMENT 'Estatus del Cliente\nA .- Activo\nB .- Bloqueado\nC .- Cancelado o Baja\nI .- Inactivo',
  FechaAlta               DATE           DEFAULT NULL  COMMENT 'Fecha Alta del\nCliente',
  RFC                     VARCHAR(13)    DEFAULT ''    COMMENT 'RFC del Cliente',
  Direccion               VARCHAR(200)   DEFAULT NULL  COMMENT 'Direccion Completa del Cliente',
  FechaNacimiento         DATE           DEFAULT NULL  COMMENT 'Fecha de Nacimiento del Cliente',
  Telefono                VARCHAR(10)    NOT NULL      COMMENT 'Telefono del Cliente',

  EmpresaID               INT(11)        DEFAULT NULL  COMMENT 'Campo de Auditoria',
  Usuario                 INT(11)        DEFAULT NULL  COMMENT 'Campo de Auditoria',
  FechaActual             DATETIME       DEFAULT NULL  COMMENT 'Campo de Auditoria',
  DireccionIP             VARCHAR(15)    DEFAULT NULL  COMMENT 'Campo de Auditoria',
  ProgramaID              VARCHAR(50)    DEFAULT NULL  COMMENT 'Campo de Auditoria',
  Sucursal                INT(11)        DEFAULT NULL  COMMENT 'Campo de Auditoria',
  NumTransaccion          INT(15)        DEFAULT NULL  COMMENT 'Campo de Auditoria',

  PRIMARY KEY (`ClienteID`),
  KEY `IDX_PIZCLIENTES_1` (`ClienteID`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla de Cliente del Sistema'$$