-- MySQL Script generated by MySQL Workbench
-- lun 26 ago 2024 14:23:35
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema 5to_RiotGames
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS 5to_RiotGames ;

-- -----------------------------------------------------
-- Schema 5to_RiotGames
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS 5to_RiotGames DEFAULT CHARACTER SET utf8 ;
USE 5to_RiotGames ;

-- -----------------------------------------------------
-- Table 5to_RiotGames.Servidor
-- -----------------------------------------------------
DROP TABLE IF EXISTS 5to_RiotGames.Servidor ;

CREATE TABLE IF NOT EXISTS 5to_RiotGames.Servidor (
  idServidor TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(45) NULL,
  Abreviado CHAR(4) NULL,
  PRIMARY KEY (idServidor),
  UNIQUE INDEX idServidor_UNIQUE (idServidor ASC) VISIBLE,
  UNIQUE INDEX Abreviado_UNIQUE (Abreviado ASC) VISIBLE,
  UNIQUE INDEX Nombre_UNIQUE (Nombre ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table 5to_RiotGames.Cuenta
-- -----------------------------------------------------
DROP TABLE IF EXISTS 5to_RiotGames.Cuenta ;

CREATE TABLE IF NOT EXISTS 5to_RiotGames.Cuenta (
  idCuenta INT UNSIGNED NOT NULL AUTO_INCREMENT,
  idServidor TINYINT UNSIGNED NOT NULL,
  Nombre VARCHAR(45) NOT NULL,
  Contrasena CHAR(64) NOT NULL,
  eMail VARCHAR(45) NULL,
  PRIMARY KEY (idCuenta),
  UNIQUE INDEX idServidor_UNIQUE (idCuenta ASC) VISIBLE,
  INDEX fk_Cuenta_Servidor1_idx (idServidor ASC) VISIBLE,
  UNIQUE INDEX uq_CuentaNombre (idServidor ASC, Nombre ASC) VISIBLE,
  UNIQUE INDEX uq_CuentaEmail (eMail ASC, idServidor ASC) VISIBLE,
  CONSTRAINT fk_Cuenta_Servidor1
    FOREIGN KEY (idServidor)
    REFERENCES 5to_RiotGames.Servidor (idServidor)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `5to_RiotGames`.RangoLol
-- -----------------------------------------------------
DROP TABLE IF EXISTS `5to_RiotGames`.RangoLol ;

CREATE TABLE IF NOT EXISTS `5to_RiotGames`.RangoLol (
  idRango TINYINT UNSIGNED  NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(45) NOT NULL,
  PuntosLigaNecesario MEDIUMINT NOT NULL,
  Numero TINYINT UNSIGNED NULL,
  PRIMARY KEY (idRango))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `5to_RiotGames`.CuentaLol
-- -----------------------------------------------------

DROP TABLE IF EXISTS `5to_RiotGames`.CuentaLol;

CREATE TABLE IF NOT EXISTS `5to_RiotGames`.CuentaLol (
  idCuenta INT UNSIGNED NOT NULL,
  Nombre VARCHAR(45) NOT NULL,
  Nivel INT UNSIGNED NOT NULL DEFAULT 0,
  EsenciaAzul INT UNSIGNED NULL DEFAULT 0,
  PuntosRiot INT UNSIGNED NULL DEFAULT 0,
  PuntosLiga MEDIUMINT NULL DEFAULT 0,
  idRango TINYINT UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (idCuenta),
  INDEX fk_Cuenta_de_lol_rango_idx (idRango ASC) VISIBLE,
  UNIQUE INDEX idCuenta_UNIQUE (idCuenta ASC) VISIBLE,
  CONSTRAINT fk_Cuenta_de_lol_rango
    FOREIGN KEY (idRango)
    REFERENCES `5to_RiotGames`.RangoLol (idRango)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table 5to_RiotGames.TipoObjeto
-- -----------------------------------------------------
DROP TABLE IF EXISTS 5to_RiotGames.TipoObjeto ;

CREATE TABLE IF NOT EXISTS 5to_RiotGames.TipoObjeto (
  idTipoObjeto TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (idTipoObjeto),
  UNIQUE INDEX idTipoObjeto_UNIQUE (idTipoObjeto ASC) VISIBLE,
  UNIQUE INDEX nombre_UNIQUE (nombre ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table 5to_RiotGames.Objeto
-- -----------------------------------------------------
DROP TABLE IF EXISTS 5to_RiotGames.Objeto ;

CREATE TABLE IF NOT EXISTS 5to_RiotGames.Objeto (
  idObjeto SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(45) NOT NULL,
  PrecioEA INT UNSIGNED NULL,
  PrecioRP INT UNSIGNED NULL,
  Venta INT UNSIGNED NULL,
  idTipoObjeto TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (idObjeto),
  UNIQUE INDEX Objeto_UNIQUE (idObjeto ASC) VISIBLE,
  UNIQUE INDEX Nombre_UNIQUE (Nombre ASC) VISIBLE,
  INDEX fk_Objeto_TipoObjeto1_idx (idTipoObjeto ASC) VISIBLE,
  CONSTRAINT fk_Objeto_TipoObjeto1
    FOREIGN KEY (idTipoObjeto)
    REFERENCES 5to_RiotGames.TipoObjeto (idTipoObjeto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table 5to_RiotGames.Inventario
-- -----------------------------------------------------
DROP TABLE IF EXISTS 5to_RiotGames.Inventario ;

CREATE TABLE IF NOT EXISTS 5to_RiotGames.Inventario (
  idCuenta INT UNSIGNED NOT NULL,
  idObjeto SMALLINT UNSIGNED NOT NULL,
  Cantidad INT NULL,
  PRIMARY KEY (idCuenta, idObjeto),
  UNIQUE INDEX idCuenta_UNIQUE (idCuenta ASC) VISIBLE,
  UNIQUE INDEX IdObjeto_UNIQUE (idObjeto ASC) VISIBLE,
  CONSTRAINT fk_Inventario_Objeto1
    FOREIGN KEY (idObjeto)
    REFERENCES 5to_RiotGames.Objeto (idObjeto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Inventario_CuentaLol1
    FOREIGN KEY (idCuenta)
    REFERENCES 5to_RiotGames.CuentaLol (idCuenta)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table 5to_RiotGames.RangoValorant
-- -----------------------------------------------------
DROP TABLE IF EXISTS 5to_RiotGames.RangoValorant ;

CREATE TABLE IF NOT EXISTS 5to_RiotGames.RangoValorant (
  idRango SMALLINT UNSIGNED  NOT NULL AUTO_INCREMENT,
  Nombre VARCHAR(45) NULL,
  Numero SMALLINT UNSIGNED NULL,
  PuntosNecesarios MEDIUMINT NOT NULL,
  PRIMARY KEY (idRango),
  UNIQUE INDEX idRango_UNIQUE (idRango ASC) VISIBLE,
  UNIQUE INDEX PuntosNecesarios_UNIQUE (PuntosNecesarios ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table 5to_RiotGames.CuentaValorant
-- -----------------------------------------------------
DROP TABLE IF EXISTS 5to_RiotGames.CuentaValorant ;

CREATE TABLE IF NOT EXISTS 5to_RiotGames.CuentaValorant (
  idCuenta INT UNSIGNED NOT NULL,
  Nombre VARCHAR(45) NULL,
  Nivel INT UNSIGNED NOT NULL DEFAULT 0,
  Experiecia INT UNSIGNED NOT NULL DEFAULT 0,
  PuntosCompetitivo MEDIUMINT NOT NULL DEFAULT 0,
  idRango SMALLINT UNSIGNED NULL DEFAULT 0,
  INDEX fk_Cuenta_de_valorant_Rango_valorant1_idx (idRango ASC) VISIBLE,
  PRIMARY KEY (idCuenta),
  UNIQUE INDEX idCuenta_UNIQUE (idCuenta ASC) VISIBLE,
  CONSTRAINT fk_Cuenta_de_valorant_Rango_valorant1
    FOREIGN KEY (idRango)
    REFERENCES 5to_RiotGames.RangoValorant (idRango)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_CuentaValorant_Cuenta1
    FOREIGN KEY (idCuenta)
    REFERENCES 5to_RiotGames.Cuenta (idCuenta)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE 5to_RiotGames ;

-- -----------------------------------------------------
-- procedure InsertServidor
-- -----------------------------------------------------


USE 5to_RiotGames;
DROP procedure IF EXISTS 5to_RiotGames.InsertServidor;

DELIMITER $$
USE 5to_RiotGames$$
CREATE PROCEDURE InsertServidor (in UnidServidor tinyint UNSIGNED,
								 in UnNombre varchar(45),
								 in UnAbreviado char(4))
BEGIN
    INSERT INTO Servidor (idServidor,Nombre,Abreviado) 
    VALUES (UnidServidor,UnNombre,UnAbreviado);
END$$

DELIMITER ;

DELIMITER $$
USE 5to_RiotGames$$

CREATE PROCEDURE DeleteObjeto(IN UnidObjeto SMALLINT UNSIGNED)
BEGIN
    DELETE FROM Objeto WHERE idObjeto = UnidObjeto;
END$$

DELIMITER ;

USE 5to_RiotGames;
DROP procedure IF EXISTS 5to_RiotGames.InsertCuenta;

DELIMITER $$
USE 5to_RiotGames$$
CREATE PROCEDURE InsertCuenta (in UnidCuenta int,
							   in UnidServidor TINYINT UNSIGNED,
							   in UnNombre varchar(45),
							   in Uncontrasena char(64),
							   in UneMail Varchar(45))
BEGIN
    INSERT INTO Cuenta (idCuenta,idServidor,Nombre,Contrasena,eMail)
    VALUES (UnidCuenta,UnidServidor,UnNombre,Uncontrasena,UneMail);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure InsertCuentaValorant
-- -----------------------------------------------------

USE 5to_RiotGames;
DROP procedure IF EXISTS 5to_RiotGames.InsertCuentaValorant;


DELIMITER $$
USE 5to_RiotGames$$
CREATE PROCEDURE InsertCuentaValorant (in UnidCuenta int,
									   in UnNombre varchar(45))
BEGIN
    INSERT INTO CuentaValorant (idCuenta, Nombre) 
    VALUES (UnidCuenta, UnNombre);
END$$

DELIMITER ;

USE 5to_RiotGames;
DROP procedure IF EXISTS 5to_RiotGames.InsertCuentaLol;
DELIMITER $$
USE 5to_RiotGames$$
CREATE PROCEDURE InsertCuentaLol(
    IN `UnidCuenta` INT UNSIGNED,
    IN `UnNombre` VARCHAR(45),
    IN `UnNivel` INT UNSIGNED,
    IN `UnEsenciaAzul` INT UNSIGNED,
    IN `UnPuntosRiot` INT UNSIGNED,
    IN `UnPuntosLiga` MEDIUMINT,
    IN `UnidRango` TINYINT UNSIGNED
)
BEGIN
    INSERT INTO `5to_RiotGames`.CuentaLol (
        idCuenta, Nombre, Nivel, EsenciaAzul, PuntosRiot, PuntosLiga, idRango
    )
    VALUES (
        UnidCuenta, UnNombre, UnNivel, UnEsenciaAzul, UnPuntosRiot, UnPuntosLiga, UnidRango
    );
END $$

DELIMITER ;

-- -----------------------------------------------------
-- procedure InsertRangoValorant
-- -----------------------------------------------------

DELIMITER $$

DROP PROCEDURE IF EXISTS 5to_RiotGames.InsertRangoValorant $$
CREATE PROCEDURE InsertRangoValorant (
    OUT UnidRango SMALLINT UNSIGNED,
    IN UnNombre VARCHAR(45),
    IN UnNumero SMALLINT UNSIGNED,
    IN UnPuntosNecesarios MEDIUMINT
)
BEGIN
    INSERT INTO RangoValorant ( Nombre, Numero, PuntosNecesarios)
      VALUES ( UnNombre, UnNumero, UnPuntosNecesarios);
    SET UnIdRango = LAST_INSERT_ID(); 
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure InsertRangoLol
-- -----------------------------------------------------

USE 5to_RiotGames;
DROP procedure IF EXISTS 5to_RiotGames.InsertRangoLol;

DELIMITER $$
USE 5to_RiotGames$$
SELECT('aca esta');
CREATE PROCEDURE InsertRangoLol (
                    out UnidRango tinyint ,
									  in UnNombre varchar(45),
									  in UnPuntosLigaNecesario mediumint,
                    in UnNumero int)
BEGIN
   INSERT INTO RangoLol  ( Nombre, PuntosLigaNecesario, Numero)
   VALUES (UnNombre, UnPuntosLigaNecesario, UnNumero);
   SET UnidRango = LAST_INSERT_ID();
END $$
-- hierro
-- 	1:0
-- 	2:15
-- 	3:30

-- bronce
-- 	1:40
-- 	2:80
-- 	3:120

-- plata
-- 	1:120
-- 	2:140
-- 	3:160

-- oro
-- 	1:180
-- 	2:200
-- 	3:220

-- platino
-- 	1:240
-- 	2:260
-- 	3:280

-- diamante
-- 	1:300
-- 	2:320
-- 	3:330$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE DeleteCuentaLol(IN IdCuenta INT)
BEGIN
    DELETE FROM CuentaLol WHERE idCuenta = IdCuenta;
END$$

DELIMITER ;
DELIMITER $$

CREATE PROCEDURE DeleteCuenta(IN IdCuenta INT)
BEGIN
    DELETE FROM Cuenta WHERE idCuenta = IdCuenta;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE DeleteCuentaValorant(IN IdCuenta INT)
BEGIN
    DELETE FROM CuentaValorant WHERE idCuenta = IdCuenta;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE BajaServidor(IN p_unidServidor INT)
BEGIN
    DELETE FROM Servidor WHERE idServidor = p_unidServidor;
    DELETE FROM `Cuenta` WHERE `idServidor` = p_unidServidor;
END $$

DELIMITER ;





-- -----------------------------------------------------
-- function CalcularTotalPuntosLiga
-- -----------------------------------------------------

USE 5to_RiotGames;
DROP function IF EXISTS 5to_RiotGames.CalcularTotalPuntosLiga;

DELIMITER $$
USE 5to_RiotGames$$
CREATE FUNCTION CalcularTotalPuntosLiga (UnidCuenta INT)RETURNS INT
										             READS SQL DATA
BEGIN
    DECLARE TotalPuntos INT;
    
    SELECT SUM(PuntosLiga) INTO TotalPuntos
    FROM CuentaLol
    WHERE UnidCuenta = idCuenta;
    
    RETURN TotalPuntos;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function ObtenerNivelValorant
-- -----------------------------------------------------

USE 5to_RiotGames;
DROP function IF EXISTS 5to_RiotGames.ObtenerNivelValorant;

DELIMITER $$
USE 5to_RiotGames$$
CREATE FUNCTION ObtenerNivelValorant (UnidCuenta INT)
RETURNS INT READS SQL DATA
BEGIN
    DECLARE Nivel INT;
    
    SELECT Nivel INTO Nivel
    FROM CuentaValorant
    WHERE UnidCuenta = idCuenta;
    
    RETURN Nivel;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function ObtenerNombreObjeto
-- -----------------------------------------------------

USE 5to_RiotGames;
DROP function IF EXISTS 5to_RiotGames.ObtenerNombreObjeto;

DELIMITER $$
USE 5to_RiotGames$$
CREATE FUNCTION ObtenerNombreObjeto (UnidObjeto INT)
RETURNS VARCHAR(45) READS SQL DATA
BEGIN
    DECLARE NombreObjeto VARCHAR(45);
    
    SELECT Nombre INTO NombreObjeto
    FROM Objeto
    WHERE UnidObjeto = idObjeto;
    
    RETURN NombreObjeto;
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure InsertTipoObjeto
-- -----------------------------------------------------

USE 5to_RiotGames;
DROP procedure IF EXISTS 5to_RiotGames.InsertTipoObjeto;

DELIMITER $$
USE 5to_RiotGames$$
CREATE PROCEDURE  InsertTipoObjeto (in UnidTipoObjeto TINYint,
									  in UnNombre varchar(45))
									
BEGIN
   INSERT INTO TipoObjeto (idTipoObjeto, Nombre)
   VALUES (UnidTipoObjeto, UnNombre);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure InserObjeto
-- -----------------------------------------------------

USE 5to_RiotGames;
DROP procedure IF EXISTS 5to_RiotGames.InsertObjeto;

DELIMITER $$
USE 5to_RiotGames$$
CREATE PROCEDURE  InserObjeto (in UnidObjeto smallint,
									  in UnNombre varchar(45),
                                      UnPrecioEA INT,
                                      UnPrecioRP INT,
                                      UnVenta INT,
                                      UnidTipoObjeto tinyint)
									
BEGIN
   INSERT INTO Objeto (idObjeto, Nombre, PrecioEA, PrecioRP, Venta, idTipoObjeto)
   VALUES (UnidObjeto, UnNombre, UnPrecioEA, UnPrecioRP, UnVenta, UnidTipoObjeto);

END$$

DELIMITER ;




-- -----------------------------------------------------
-- procedure altaProductoInventario
-- -----------------------------------------------------





USE 5to_RiotGames;
DROP procedure IF EXISTS 5to_RiotGames.altaProductoInventario;

DELIMITER $$
USE 5to_RiotGames$$
CREATE PROCEDURE altaProductoInventario (in UnidUsuario int,
								 in UnidObjeto smallint,
								 in UnaCantidad int)
BEGIN
    INSERT INTO Inventario (idUsuario, idObjeto, Cantidad) 
    VALUES (UnidUsuario, UnidObjeto, UnaCantidad);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure anadirValorLol
-- -----------------------------------------------------

USE 5to_RiotGames;
DROP procedure IF EXISTS 5to_RiotGames.anadirValorLol;

DELIMITER $$
USE 5to_RiotGames$$
CREATE PROCEDURE anadirValorLol (in UnidCuenta int,
									  in UnNivel int,
                                      in UnEsenciaAzul int,
                                      in unPuntosRiot int,
                                      in unPuntosLiga mediumint)
                                       
BEGIN
   update CuentaLol
   set Nivel = Nivel + UnNivel, EsenciaAzul = EsenciaAzul+ UnEsenciaAzul, PuntosRiot = PuntosRiot + UnPuntosRiot, PuntosLiga = PuntosLiga + UnPuntosLiga
   where UnidCuenta = idCuenta;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure anadirValorVal
-- -----------------------------------------------------

USE 5to_RiotGames;
DROP procedure IF EXISTS 5to_RiotGames.anadirValorVal;

DELIMITER $$
USE 5to_RiotGames$$
CREATE PROCEDURE anadirValorVal (in UnidCuenta int,
									  in UnNivel int,
                                      in UnExperiencia int,
                                      in unPuntosRiot int,
                                      in unPuntosCompetitivo mediumint)
                                       
BEGIN
   update CuentaLol
   set Nivel = Nivel + UnNivel, Experiencia = Experiencia+ UnExperiencia, PuntosCompetitivo = PuntosCompetitivo + unPuntosCompetitivo
   where UnidCuenta = idCuenta;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Inserts
-- -----------------------------------------------------

USE 5to_RiotGames;
DROP procedure IF EXISTS 5to_RiotGames.Inserts;

  DELIMITER $$
  USE 5to_RiotGames$$
  CREATE PROCEDURE Inserts()
  BEGIN
      call InsertTipoObjeto(1,'Skins');
      call InsertServidor (1, 'Norteamérica', 'NA'); 
      call InsertServidor (2, 'Europa Occidental', 'EUW'); 
      call InsertServidor (3, 'Brasil', 'BR'); 
      call InsertServidor (4, 'Corea', 'KR'); 
      call InsertServidor (5, 'Oceanía', 'OC;'); 
      call InsertServidor (6, 'Japón', 'JP'); 
      call InsertServidor (7, 'América Latin Norte', 'LAN'); 
      call InsertServidor (8, 'América Latin Sur', 'LAS'); 
      call InsertServidor (9, 'Turquía', 'TR,'); 
      call InsertServidor (10, 'Rusia', 'RU'); 
      call InsertServidor (11, 'Asia Pacífico', 'AP');

      call InsertTipoObjeto(2,'Centinelas');
      call InsertTipoObjeto(3,'Campeones');
      call InsertTipoObjeto(4,'FragmentosSkin');
      call InsertTipoObjeto(5,'FragmentosCentinelas');
      call InsertTipoObjeto(6,'Gestos');
      call InsertTipoObjeto(7,'Accesorios');
      
      
      call InsertRangoLol(@hierroUno,'Hierro',10,1);
      call InsertRangoLol(@hierroDos,'Hierro',15,2);
      call InsertRangoLol(@hierroTres,'Hierro',30,3);
      call InsertRangoLol(@BronceUno,'Bronce',40,1);
      call InsertRangoLol(@BronceDos,'Bronce',80,2);
      call InsertRangoLol(@BronceTres,'Bronce',120,3);
      call InsertRangoLol(@PlataUno,'Palta',130,1);
      call InsertRangoLol(@PlataDos,'Palta',140,2);
      call InsertRangoLol(@PlataTres,'Palta',160,3);
      call InsertRangoLol(@OroUno,'Oro',180,1);
      call InsertRangoLol(@OroDos,'Oro',200,2);
      call InsertRangoLol(@OroTres,'Oro',220,3);
      call InsertRangoLol(@PlatinoUno,'Platino',240,1);
      call InsertRangoLol(@PlatinoDos,'Platino',260,2);
      call InsertRangoLol(@PlatinoTres,'Platino',280,3);
      call InsertRangoLol(@DiamanteUno,'Diamante',300,1);
      call InsertRangoLol(@DiamanteDos,'Diamante',320,2);
      call InsertRangoLol(@DiamanteTres,'Diamante',330,3);
      
      call InsertRangoValorant(@hierroUno,'Hierro',1,10);
      call InsertRangoValorant(@hierroDos,'Hierro',2,20);
      call InsertRangoValorant(@hierroTres,'Hierro',3,30);
      call InsertRangoValorant(@BronceUno,'Bronce',1,40);
      call InsertRangoValorant(@BronceDos,'Bronce',2,50);
      call InsertRangoValorant(@BronceTres,'Bronce',3,60);
      call InsertRangoValorant(@PlataUno,'Palta',1,80);
      call InsertRangoValorant(@PlataDos,'Palta',2,90);
      call InsertRangoValorant(@PlataTres,'Palta',3,100);
      call InsertRangoValorant(@OroUno,'Oro',1,110);
      call InsertRangoValorant(@OroDos,'Oro',2,120);
      call InsertRangoValorant(@OroTres,'Oro',3,130);
      call InsertRangoValorant(@PlatinoUno,'Platino',1,140);
      call InsertRangoValorant(@PlatinoDos,'Platino',2,150);
      call InsertRangoValorant(@PlatinoTres,'Platino',3,160);
      call InsertRangoValorant(@DiamanteUno,'Diamante',1,170);
      call InsertRangoValorant(@DiamanteDos,'Diamante',2,180);
      call InsertRangoValorant(@DiamanteTres,'Diamante',3,190);
      

  END$$

  DELIMITER ;

  

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
USE 5to_RiotGames;

DELIMITER $$

USE 5to_RiotGames$$
DROP TRIGGER IF EXISTS 5to_RiotGames.Cuenta_BEFORE_INSERT $$
USE 5to_RiotGames$$
CREATE TRIGGER 5to_RiotGames.Cuenta_BEFORE_INSERT 
BEFORE INSERT ON Cuenta FOR EACH ROW
BEGIN
	SET NEW.contrasena = SHA2(NEW.contrasena, 256);
END$$


USE 5to_RiotGames$$
DROP TRIGGER IF EXISTS 5to_RiotGames.Cuenta_AFTER_DELETE $$
USE 5to_RiotGames$$
CREATE TRIGGER 5to_RiotGames.Cuenta_AFTER_DELETE AFTER DELETE ON Cuenta FOR EACH ROW
BEGIN
    DELETE FROM CuentaValorant 
	WHERE idCuenta = OLD.idCuenta;
    DELETE FROM CuentaLol
	WHERE idCuenta = OLD.idCuenta;
	DELETE FROM Inventario
    WHERE idCuenta = OLD.idCuenta;
-- este trigger hace que al eliminar la cuenta elimina todo el historial
END$$


DELIMITER ;

SELECT 'Voy a invocar inserts' Estado;
call Inserts();

DELIMITER $$

CREATE PROCEDURE InsertObjeto (
    IN UnidObjeto SMALLINT,
    IN UnNombre VARCHAR(45),
    IN UnPrecioEA INT,
    IN UnPrecioRP INT,
    IN UnVenta INT,
    IN UnidTipoObjeto TINYINT
)
BEGIN
    INSERT INTO Objeto (idObjeto, Nombre, PrecioEA, PrecioRP, Venta, idTipoObjeto)
    VALUES (UnidObjeto, UnNombre, UnPrecioEA, UnPrecioRP, UnVenta, UnidTipoObjeto);
END$$

DELIMITER ;
