create database DEBEZIUM;
USE DEBEZIUM;
create table autor
(
    ID               int    not null
        primary key,
    NOMBRE           text   not null,
    APELLIDO         text   not null,
    FECHA_NACIMIENTO bigint null,
    NACIONALIDAD     text   null,
    FECHA_CREACION   bigint null,
    __deleted        text   null,
    __op             text   null,
    __table          text   null,
    __source_ts_ms   bigint null
);

create table categoria
(
    ID             int    not null
        primary key,
    NOMBRE         text   not null,
    DESCRIPCION    text   null,
    FECHA_CREACION bigint null,
    __deleted      text   null,
    __op           text   null,
    __table        text   null,
    __source_ts_ms bigint null
);

CREATE TABLE `libro` (
                         `ID` INT NOT NULL,
                         `ISBN` TEXT NOT NULL,
                         `TITULO` TEXT NOT NULL,
                         `ID_AUTOR` INT NOT NULL,
                         `ID_CATEGORIA` INT NOT NULL,
                         `EDITORIAL` TEXT NULL,
                         `FECHA_PUBLICACION` BIGINT NULL,
                         `EDICION` INT NULL,
                         `NUMERO_PAGINAS` INT NULL,
                         `ESTADO` TEXT,
                         `UBICACION` TEXT NULL,
                         `FECHA_CREACION` BIGINT NULL,
                         `__deleted` TEXT NULL,
                         `__op` TEXT NULL,
                         `__table` TEXT NULL,
                         `__source_ts_ms` BIGINT NULL,
                         PRIMARY KEY(`ID`));


CREATE TABLE `usuario` (
                           `ID` INT NOT NULL,
                           `NUMERO_IDENTIFICACION` TEXT NOT NULL,
                           `NOMBRE` TEXT NOT NULL,
                           `APELLIDO` TEXT NOT NULL,
                           `EMAIL` TEXT NOT NULL,
                           `TELEFONO` TEXT NULL,
                           `DIRECCION` TEXT NULL,
                           `TIPO_USUARIO` TEXT,
                           `ESTADO` TEXT,
                           `FECHA_REGISTRO` BIGINT NULL,
                           `FECHA_ACTUALIZACION` BIGINT NULL,
                           `__deleted` TEXT NULL,
                           `__op` TEXT NULL,
                           `__table` TEXT NULL,
                           `__source_ts_ms` BIGINT NULL,
                           PRIMARY KEY(`ID`));

CREATE TABLE `prestamo` (
                            `ID` INT NOT NULL,
                            `ID_LIBRO` INT NOT NULL,
                            `ID_USUARIO` INT NOT NULL,
                            `FECHA_PRESTAMO` BIGINT DEFAULT 0,
                            `FECHA_DEVOLUCION_PREVISTA` BIGINT NOT NULL,
                            `FECHA_DEVOLUCION_REAL` BIGINT NULL,
                            `ESTADO` TEXT,
                            `MULTA` DECIMAL(65,2) DEFAULT 0.00,
                            `OBSERVACIONES` TEXT NULL,
                            `FECHA_CREACION` BIGINT NULL,
                            `__deleted` TEXT NULL,
                            `__op` TEXT NULL,
                            `__table` TEXT NULL,
                            `__source_ts_ms` BIGINT NULL,
                            PRIMARY KEY(`ID`));