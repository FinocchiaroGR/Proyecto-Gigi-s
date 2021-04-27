CREATE TABLE `ciclos` 
(
    `idCiclo` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `fechaInicial` DATE NOT NULL , 
    `fechaFinal` DATE NOT NULL
)
ENGINE = InnoDB;

CREATE TABLE `programas` 
( 
    `idPrograma` INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    `nombrePrograma` VARCHAR(50) NOT NULL , 
    `puntajeMaximo` INT NOT NULL , 
    `dirImagen` VARCHAR(100) NULL
) 
ENGINE = InnoDB;

CREATE TABLE `niveles` 
(
    `idNivel` INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    `nombreNivel` VARCHAR(50) NOT NULL , 
    `idPrograma` INT NOT NULL
) 
ENGINE = InnoDB;

CREATE TABLE `objetivos` ( 
    `idNivel` INT NOT NULL , 
    `idObjetivo` INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    `descripcion` VARCHAR(400) NOT NULL ,
    `fechaRegistroObj` DATE NOT NULL DEFAULT CURRENT_TIMESTAMP 
    ) 
ENGINE = InnoDB;


CREATE TABLE `funciones` 
( 
    `idFuncion` INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    `requisitoFuncional` VARCHAR(50) NOT NULL
) 
ENGINE = InnoDB;

CREATE TABLE `roles` 
( 
    `idRol` INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    `nombre` VARCHAR(30) NOT NULL
) 
ENGINE = InnoDB;

CREATE TABLE `usuarios` 
( 
    `login` VARCHAR(50) NOT NULL PRIMARY KEY, 
    `password` VARCHAR(250) NOT NULL , 
    `nombreUsuario` VARCHAR(50) NULL , 
    `apellidoPaterno` VARCHAR(50) NULL , 
    `apellidoMaterno` VARCHAR(50) NULL
) 
ENGINE = InnoDB;

CREATE TABLE `terapeutas` 
( 
    `login` VARCHAR(50) NOT NULL PRIMARY KEY, 
    `titulo` VARCHAR(50) NULL , 
    `cv` VARCHAR(50) NULL , 
    `estatus` CHAR(1) NOT NULL
) 
ENGINE = InnoDB;

CREATE TABLE `participantes` 
( 
    `login` VARCHAR(50) NOT NULL PRIMARY KEY, 
    `estatus` CHAR(1) NOT NULL DEFAULT 'A',
    `sexo` CHAR(1) NOT NULL , 
    `fechaNacimiento` DATE NOT NULL , 
    `telefonoPadre` VARCHAR(12) NULL
) 
ENGINE = InnoDB;

CREATE TABLE `grupos` 
(
    `idGrupo` INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    `numeroGrupo` INT NOT NULL , 
    `idPrograma` INT NOT NULL , 
    `idCiclo` INT NOT NULL
) 
ENGINE = InnoDB;

CREATE TABLE `roles_funciones` 
( 
    `idRol` INT NOT NULL , 
    `idfuncion` INT NOT NULL , 
    `fechaRF` DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY  (`idRol`, `idfuncion`)
) 
ENGINE = InnoDB;

CREATE TABLE `usuarios_roles`  
( 
    `login` VARCHAR(50) NOT NULL , 
    `idRol` INT NOT NULL , 
    `fechaUR` DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY  (`login`, `idRol`)
) 
ENGINE = InnoDB;

CREATE TABLE `grupos_terapeutas` 
( 
    `idGrupo` INT NOT NULL , 
    `login` VARCHAR(50) NOT NULL , 
    `fechaAsignacion` DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`idGrupo`, `login`)
) 
ENGINE = InnoDB;

CREATE TABLE `participantes_grupos_objetivo` 
( 
    `login` VARCHAR(50) NOT NULL , 
    `idGrupo` INT NOT NULL , 
    `idNivel` INT NOT NULL , 
    `idObjetivo` INT NOT NULL , 
    `puntajeInicial` INT NULL , 
    `puntajeFinal` INT NULL,
    PRIMARY KEY  (`login`, `idGrupo`, `idNivel`, `idObjetivo`)
) 

ENGINE = InnoDB;

ALTER TABLE `niveles` 
ADD CONSTRAINT `cfniveles_idprograma_programas` 
FOREIGN KEY (`idPrograma`) 
REFERENCES `programas`(`idPrograma`) 
ON DELETE CASCADE 
ON UPDATE CASCADE;

ALTER TABLE `objetivos` 
ADD CONSTRAINT `cfobjetivos_idNivel_niveles` 
FOREIGN KEY (`idNivel`) 
REFERENCES `niveles`(`idNivel`) 
ON DELETE CASCADE 
ON UPDATE CASCADE;

ALTER TABLE `roles_funciones` 
ADD CONSTRAINT `cfroles_funciones_idFuncion_funciones` 
FOREIGN KEY (`idFuncion`) 
REFERENCES `funciones`(`idFuncion`) 
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE `roles_funciones` 
ADD CONSTRAINT `cfroles_funciones_idRol_roles` 
FOREIGN KEY (`idRol`) 
REFERENCES `roles`(`idRol`) 
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE `usuarios_roles` 
ADD CONSTRAINT `cfusuarios_roles_login_usuarios` 
FOREIGN KEY (`login`) 
REFERENCES `usuarios`(`login`) 
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE `usuarios_roles` 
ADD CONSTRAINT `cfusuarios_roles_idRol_roles` 
FOREIGN KEY (`idRol`) 
REFERENCES `roles`(`idRol`) 
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE `terapeutas` 
ADD CONSTRAINT `cfterapeutas_login_usuarios` 
FOREIGN KEY (`login`) 
REFERENCES `usuarios`(`login`) 
ON DELETE RESTRICT 
ON UPDATE RESTRICT;

ALTER TABLE `participantes` 
ADD CONSTRAINT `cfparticipantes_login_usuarios` 
FOREIGN KEY (`login`) 
REFERENCES `usuarios`(`login`) 
ON DELETE RESTRICT
ON UPDATE RESTRICT;

ALTER TABLE `grupos` 
ADD CONSTRAINT `cfgrupos_idprograma_programas` 
FOREIGN KEY (`idPrograma`) 
REFERENCES `programas`(`idPrograma`) 
ON DELETE CASCADE 
ON UPDATE CASCADE;

ALTER TABLE `grupos` 
ADD CONSTRAINT `cfgrupos_idciclo_cicloss` 
FOREIGN KEY (`idCiclo`) 
REFERENCES `ciclos`(`idCiclo`) 
ON DELETE CASCADE 
ON UPDATE CASCADE;

ALTER TABLE `grupos_terapeutas` 
ADD CONSTRAINT `cfgrupos_terapeutas_idGrupo_grupos` 
FOREIGN KEY (`idGrupo`) 
REFERENCES `grupos`(`idGrupo`) 
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE `grupos_terapeutas` 
ADD CONSTRAINT `cfgrupos_terapeutas_login_terapeutas` 
FOREIGN KEY (`login`) 
REFERENCES `terapeutas`(`login`) 
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE `participantes_grupos_objetivo` 
ADD CONSTRAINT `cfpuntajes_login_participantes` 
FOREIGN KEY (`login`) 
REFERENCES `participantes`(`login`) 
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE `participantes_grupos_objetivo` 
ADD CONSTRAINT `cfpuntajes_idGrupo_grupos` 
FOREIGN KEY (`idGrupo`) 
REFERENCES `grupos`(`idGrupo`) 
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE `participantes_grupos_objetivo` 
ADD CONSTRAINT `cfpuntajes_idObjetivo_objetivos` 
FOREIGN KEY (`idNivel`, `idObjetivo`) 
REFERENCES `objetivos`(`idNivel`, `idObjetivo`) 
ON DELETE RESTRICT 
ON UPDATE RESTRICT;

ALTER TABLE `ciclos`
ADD CONSTRAINT `CK_fechaInicial_vs_fechaFinal`
CHECK (fechaInicial < fechaFinal);