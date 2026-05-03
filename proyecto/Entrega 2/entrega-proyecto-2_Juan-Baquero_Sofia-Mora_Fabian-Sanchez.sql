-- ════════════════════════════════════════════════════════════════
--
-- Proyecto : Bases de Datos
-- Motor : Oracle SQL
--
-- Autores : Juan Pablo Baquero Velandia, Sofia Mora Calderón, Fabián Eduardo Sánchez Borda
--
-- Fecha : 2026-05-03
--
-- Descripción : Script principal del proyecto de BD
--
-- ════════════════════════════════════════════════════════════════

--DROPS

DROP TABLE pais CASCADE CONSTRAINTS;
DROP TABLE ciudad CASCADE CONSTRAINTS;
DROP TABLE confederacion CASCADE CONSTRAINTS;
DROP TABLE estadio CASCADE CONSTRAINTS;
DROP TABLE seleccion CASCADE CONSTRAINTS;
DROP TABLE partido CASCADE CONSTRAINTS;
DROP TABLE experiencia CASCADE CONSTRAINTS;
DROP TABLE guia CASCADE CONSTRAINTS;
DROP TABLE nivel CASCADE CONSTRAINTS;
DROP TABLE servicio CASCADE CONSTRAINTS;
DROP TABLE impuestoxservicio CASCADE CONSTRAINTS;
DROP TABLE impuesto CASCADE CONSTRAINTS;
DROP TABLE inscripcion CASCADE CONSTRAINTS;
DROP TABLE pagos CASCADE CONSTRAINTS;
DROP TABLE transaccion CASCADE CONSTRAINTS;
DROP TABLE cliente CASCADE CONSTRAINTS;
DROP TABLE serviciosxinscripcion CASCADE CONSTRAINTS;

-- CREATES

CREATE TABLE pais (
  nombre_pais VARCHAR2(70) NOT NULL,
  id_pais NUMBER(10,0) GENERATED AS IDENTITY PRIMARY KEY
);

CREATE TABLE ciudad (
  nombre_ciudad VARCHAR2(70) NOT NULL,
  id_pais NUMBER(10,0) DEFAULT 0 NOT NULL,
  id_ciudad NUMBER(10,0) GENERATED AS IDENTITY PRIMARY KEY
);

CREATE TABLE confederacion (
  nombre_confederacion VARCHAR2(70) NOT NULL,
  id_confederacion NUMBER(10,0) GENERATED AS IDENTITY PRIMARY KEY
);

CREATE TABLE estadio (
  nombre_estadio VARCHAR2(70) NOT NULL,
  capacidad INTEGER DEFAULT 0 NOT NULL,
  id_ciudad NUMBER(10,0) DEFAULT 0 NOT NULL,
  id_estadio NUMBER(10,0) GENERATED AS IDENTITY PRIMARY KEY
);

CREATE TABLE seleccion (
  nombre_seleccion VARCHAR2(70) NOT NULL,
  id_confederacion NUMBER(10,0) DEFAULT 0 NOT NULL,
  id_seleccion NUMBER(10,0) GENERATED AS IDENTITY PRIMARY KEY
);

CREATE TABLE partido (
  id_estadio NUMBER(10,0) DEFAULT 0 NOT NULL,
  fecha TIMESTAMP DEFAULT SYSDATE NOT NULL,
  fase VARCHAR2(10) NOT NULL,
  id_seleccion_local NUMBER(10,0) DEFAULT 0 NOT NULL,
  id_seleccion_visitante NUMBER(10,0) DEFAULT 0 NOT NULL,
  goles_local INTEGER DEFAULT 0 NOT NULL,
  goles_visitante INTEGER DEFAULT 0 NOT NULL,
  id_partido NUMBER(10,0) GENERATED AS IDENTITY PRIMARY KEY,
  id_experiencia NUMBER(10,0)
);

CREATE TABLE experiencia (
  id_experiencia NUMBER(10,0) GENERATED AS IDENTITY PRIMARY KEY,
  cupos integer,
  descripcion VARCHAR2(1000),
  estado VARCHAR2(15),
  precio_base NUMBER(12,4),
  id_guia NUMBER(10,0) NOT NULL,
  horas_trabajadas INTEGER
);

CREATE TABLE guia (
  id_guia NUMBER(10,0) GENERATED AS IDENTITY PRIMARY KEY,
  nombre VARCHAR2(20),
  guia_jefe NUMBER(10,0),
  id_nivel VARCHAR2(10)
);

CREATE TABLE nivel (
  id_nivel VARCHAR2(10) PRIMARY KEY,
  valorxhora NUMBER(10,2)
);

CREATE TABLE serviciosxinscripcion (
  id_servicio NUMBER(10,0),
  id_experiencia NUMBER(10,0),
  cantidad integer,
  PRIMARY KEY (id_servicio, id_experiencia)
);

CREATE TABLE servicio (
  id_servicio NUMBER(10,0) GENERATED AS IDENTITY PRIMARY KEY,
  nombre VARCHAR2(50),
  descripcion VARCHAR2(1000),
  costo_adicional NUMBER(12,4)
);

CREATE TABLE impuesto (
  id_impuesto NUMBER(10,0) PRIMARY KEY,
  valor NUMBER(5,2),
  tipo_impuesto VARCHAR2(20)
);

CREATE TABLE impuestoxservicio (
  id_impuesto NUMBER(10,0),
  id_servicio NUMBER(10,0),
  PRIMARY KEY (id_impuesto, id_servicio)
);

CREATE TABLE cliente (
  nombre VARCHAR2(30),
  apellido VARCHAR2(30),
  tipo_documento VARCHAR2(2),
  id_cliente NUMBER(10,0) GENERATED AS IDENTITY PRIMARY KEY,
  numero_telefono NUMBER(10,0),
  email VARCHAR2(50)
);

CREATE TABLE transaccion (
  id_transaccion NUMBER(10,0) PRIMARY KEY,
  valor NUMBER(12,4),
  tipo_pago VARCHAR2(50),
  referencia NUMBER(10,0),
  fecha_pago TIMESTAMP
);

CREATE TABLE inscripcion (
  id_experiencia NUMBER(10,0),
  id_cliente NUMBER(10,0),
  PRIMARY KEY (id_experiencia, id_cliente)
);

CREATE TABLE pagos (
  id_cliente NUMBER(10,0),
  id_experiencia NUMBER(10,0),
  id_transaccion NUMBER(10,0),
  PRIMARY KEY (id_cliente, id_experiencia, id_transaccion)
);

ALTER TABLE ciudad ADD FOREIGN KEY (id_pais) REFERENCES pais (id_pais) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE estadio ADD FOREIGN KEY (id_ciudad) REFERENCES ciudad (id_ciudad) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE seleccion ADD FOREIGN KEY (id_confederacion) REFERENCES confederacion (id_confederacion) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE partido ADD FOREIGN KEY (id_estadio) REFERENCES estadio (id_estadio) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE partido ADD FOREIGN KEY (id_seleccion_local) REFERENCES seleccion (id_seleccion) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE partido ADD FOREIGN KEY (id_seleccion_visitante) REFERENCES seleccion (id_seleccion) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE partido ADD FOREIGN KEY (id_experiencia) REFERENCES experiencia (id_experiencia) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE experiencia ADD FOREIGN KEY (id_guia) REFERENCES guia (id_guia) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE guia ADD FOREIGN KEY (guia_jefe) REFERENCES guia (id_guia) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE guia ADD FOREIGN KEY (id_nivel) REFERENCES nivel (id_nivel) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE serviciosxinscripcion ADD FOREIGN KEY (id_servicio) REFERENCES servicio (id_servicio) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE serviciosxinscripcion ADD FOREIGN KEY (id_experiencia) REFERENCES experiencia (id_experiencia) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE impuestoxservicio ADD FOREIGN KEY (id_impuesto) REFERENCES impuesto (id_impuesto) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE impuestoxservicio ADD FOREIGN KEY (id_servicio) REFERENCES servicio (id_servicio) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE inscripcion ADD FOREIGN KEY (id_experiencia) REFERENCES experiencia (id_experiencia) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE inscripcion ADD FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE pagos ADD FOREIGN KEY (id_cliente, id_experiencia) REFERENCES inscripcion (id_cliente, id_experiencia) DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE pagos ADD FOREIGN KEY (id_transaccion) REFERENCES transaccion (id_transaccion) DEFERRABLE INITIALLY IMMEDIATE;

--Constraints para unique
ALTER TABLE pais ADD CONSTRAINT uq_nombre_pais UNIQUE (nombre_pais);
ALTER TABLE ciudad ADD CONSTRAINT uq_nombre_ciudad UNIQUE (nombre_ciudad);
ALTER TABLE confederacion ADD CONSTRAINT uq_nombre_confederacion UNIQUE (nombre_confederacion);
ALTER TABLE estadio ADD CONSTRAINT uq_nombre_estadio UNIQUE (nombre_estadio);
ALTER TABLE seleccion ADD CONSTRAINT uq_nombre_seleccion UNIQUE (nombre_seleccion);
ALTER TABLE transaccion ADD CONSTRAINT uq_referencia UNIQUE (referencia);

--Constraints para check
ALTER TABLE ciudad ADD CONSTRAINT chk_id_pais CHECK (id_pais >= 0);
ALTER TABLE estadio ADD CONSTRAINT chk_capacidad CHECK (capacidad >= 0);
ALTER TABLE estadio ADD CONSTRAINT chk_id_ciudad CHECK (id_ciudad >= 0);
ALTER TABLE seleccion ADD CONSTRAINT chk_id_confederacion CHECK (id_confederacion >= 0);
ALTER TABLE experiencia ADD CONSTRAINT chk_estado CHECK (estado IN ('disponible', 'agotada', 'cancelada'));
ALTER TABLE impuesto ADD CONSTRAINT chk_tipo CHECK (tipo_impuesto IN ('IVA', 'TURISTICO', 'LOCAL', 'OTRO')); 

-- partido
ALTER TABLE partido ADD CONSTRAINT chk_id_estadio CHECK (id_estadio >= 0);
ALTER TABLE partido ADD CONSTRAINT chk_id_sel_local CHECK (id_seleccion_local >= 0);
ALTER TABLE partido ADD CONSTRAINT chk_id_sel_vis CHECK (id_seleccion_visitante >= 0);
ALTER TABLE partido ADD CONSTRAINT chk_goles_local CHECK (goles_local >= 0);
ALTER TABLE partido ADD CONSTRAINT chk_goles_vis CHECK (goles_visitante >= 0);
ALTER TABLE partido ADD CONSTRAINT chk_fase CHECK (fase IN ('GRUPOS', 'OCTAVOS', 'CUARTOS', 'SEMIFINAL', 'FINAL'));
ALTER TABLE partido ADD CONSTRAINT chk_jugar CHECK (id_seleccion_local != id_seleccion_visitante);

--Trigger para mirar si un cliente se va a meter en una experiencia sin cupos

CREATE OR REPLACE TRIGGER LIMITE_CUPOS
BEFORE INSERT ON inscripcion
FOR EACH ROW
DECLARE
    cupos_experiencia       NUMBER;
    inscripciones_experiencia NUMBER;
BEGIN
    SELECT cupos
    INTO cupos_experiencia
    FROM experiencia
    WHERE id_experiencia = :NEW.id_experiencia;

    SELECT COUNT(*)
    INTO inscripciones_experiencia
    FROM inscripcion
    WHERE id_experiencia = :NEW.id_experiencia;

    IF inscripciones_experiencia >= cupos_experiencia THEN
        DBMS_OUTPUT.PUT_LINE('No hay cupos disponibles para esa experiencia.');
        RAISE_APPLICATION_ERROR(-20001, 'No hay cupos disponibles para esa experiencia.');
    END IF;
END;
/

--INSERTS

-- =================================================================================================
--  INSERTS COMPLETOS - ORACLE SQL - VERSION FINAL - ASISITIDOS CON INTELIGENCIA ARTIFIAL GENERATIVA
-- =================================================================================================

-- 1. PAIS
INSERT INTO pais (nombre_pais) VALUES ('PERU');
INSERT INTO pais (nombre_pais) VALUES ('COLOMBIA');
INSERT INTO pais (nombre_pais) VALUES ('MEXICO');
INSERT INTO pais (nombre_pais) VALUES ('BRASIL');
INSERT INTO pais (nombre_pais) VALUES ('ARGENTINA');
INSERT INTO pais (nombre_pais) VALUES ('AUSTRALIA');
INSERT INTO pais (nombre_pais) VALUES ('PORTUGAL');
INSERT INTO pais (nombre_pais) VALUES ('ESPANA');
INSERT INTO pais (nombre_pais) VALUES ('ALEMANIA');
INSERT INTO pais (nombre_pais) VALUES ('FRANCIA');
INSERT INTO pais (nombre_pais) VALUES ('JAPON');
INSERT INTO pais (nombre_pais) VALUES ('COREA DEL SUR');
INSERT INTO pais (nombre_pais) VALUES ('ARABIA SAUDITA');
INSERT INTO pais (nombre_pais) VALUES ('ESTADOS UNIDOS');
INSERT INTO pais (nombre_pais) VALUES ('CANADA');

-- 2. CIUDAD
INSERT INTO ciudad (nombre_ciudad, id_pais) VALUES ('Lima',             (SELECT id_pais FROM pais WHERE nombre_pais = 'PERU'));
INSERT INTO ciudad (nombre_ciudad, id_pais) VALUES ('Bogota',           (SELECT id_pais FROM pais WHERE nombre_pais = 'COLOMBIA'));
INSERT INTO ciudad (nombre_ciudad, id_pais) VALUES ('Ciudad de Mexico', (SELECT id_pais FROM pais WHERE nombre_pais = 'MEXICO'));
INSERT INTO ciudad (nombre_ciudad, id_pais) VALUES ('Sao Paulo',        (SELECT id_pais FROM pais WHERE nombre_pais = 'BRASIL'));
INSERT INTO ciudad (nombre_ciudad, id_pais) VALUES ('Buenos Aires',     (SELECT id_pais FROM pais WHERE nombre_pais = 'ARGENTINA'));
INSERT INTO ciudad (nombre_ciudad, id_pais) VALUES ('Canberra',         (SELECT id_pais FROM pais WHERE nombre_pais = 'AUSTRALIA'));
INSERT INTO ciudad (nombre_ciudad, id_pais) VALUES ('Lisboa',           (SELECT id_pais FROM pais WHERE nombre_pais = 'PORTUGAL'));
INSERT INTO ciudad (nombre_ciudad, id_pais) VALUES ('Madrid',           (SELECT id_pais FROM pais WHERE nombre_pais = 'ESPANA'));
INSERT INTO ciudad (nombre_ciudad, id_pais) VALUES ('Berlin',           (SELECT id_pais FROM pais WHERE nombre_pais = 'ALEMANIA'));
INSERT INTO ciudad (nombre_ciudad, id_pais) VALUES ('Paris',            (SELECT id_pais FROM pais WHERE nombre_pais = 'FRANCIA'));
INSERT INTO ciudad (nombre_ciudad, id_pais) VALUES ('Tokio',            (SELECT id_pais FROM pais WHERE nombre_pais = 'JAPON'));
INSERT INTO ciudad (nombre_ciudad, id_pais) VALUES ('Seul',             (SELECT id_pais FROM pais WHERE nombre_pais = 'COREA DEL SUR'));
INSERT INTO ciudad (nombre_ciudad, id_pais) VALUES ('Riad',             (SELECT id_pais FROM pais WHERE nombre_pais = 'ARABIA SAUDITA'));
INSERT INTO ciudad (nombre_ciudad, id_pais) VALUES ('Nueva York',       (SELECT id_pais FROM pais WHERE nombre_pais = 'ESTADOS UNIDOS'));
INSERT INTO ciudad (nombre_ciudad, id_pais) VALUES ('Toronto',          (SELECT id_pais FROM pais WHERE nombre_pais = 'CANADA'));

-- 3. CONFEDERACION
INSERT INTO confederacion (nombre_confederacion) VALUES ('CONMEBOL');
INSERT INTO confederacion (nombre_confederacion) VALUES ('FIFA');
INSERT INTO confederacion (nombre_confederacion) VALUES ('UEFA');
INSERT INTO confederacion (nombre_confederacion) VALUES ('AFC');

-- 4. ESTADIO
INSERT INTO estadio (nombre_estadio, capacidad, id_ciudad) VALUES ('Estadio Nacional de Lima',  50000, (SELECT id_ciudad FROM ciudad WHERE nombre_ciudad = 'Lima'));
INSERT INTO estadio (nombre_estadio, capacidad, id_ciudad) VALUES ('Estadio El Campin',         45000, (SELECT id_ciudad FROM ciudad WHERE nombre_ciudad = 'Bogota'));
INSERT INTO estadio (nombre_estadio, capacidad, id_ciudad) VALUES ('Estadio Azteca',            87000, (SELECT id_ciudad FROM ciudad WHERE nombre_ciudad = 'Ciudad de Mexico'));
INSERT INTO estadio (nombre_estadio, capacidad, id_ciudad) VALUES ('Arena Corinthians',         49000, (SELECT id_ciudad FROM ciudad WHERE nombre_ciudad = 'Sao Paulo'));
INSERT INTO estadio (nombre_estadio, capacidad, id_ciudad) VALUES ('Estadio Monumental',        84000, (SELECT id_ciudad FROM ciudad WHERE nombre_ciudad = 'Buenos Aires'));
INSERT INTO estadio (nombre_estadio, capacidad, id_ciudad) VALUES ('Stadium Australia',         83500, (SELECT id_ciudad FROM ciudad WHERE nombre_ciudad = 'Canberra'));
INSERT INTO estadio (nombre_estadio, capacidad, id_ciudad) VALUES ('Estadio da Luz',            64000, (SELECT id_ciudad FROM ciudad WHERE nombre_ciudad = 'Lisboa'));
INSERT INTO estadio (nombre_estadio, capacidad, id_ciudad) VALUES ('Estadio Santiago Bernabeu', 81000, (SELECT id_ciudad FROM ciudad WHERE nombre_ciudad = 'Madrid'));
INSERT INTO estadio (nombre_estadio, capacidad, id_ciudad) VALUES ('Olympiastadion Berlin',     74000, (SELECT id_ciudad FROM ciudad WHERE nombre_ciudad = 'Berlin'));
INSERT INTO estadio (nombre_estadio, capacidad, id_ciudad) VALUES ('Parc des Princes',          48000, (SELECT id_ciudad FROM ciudad WHERE nombre_ciudad = 'Paris'));
INSERT INTO estadio (nombre_estadio, capacidad, id_ciudad) VALUES ('Japan National Stadium',    68000, (SELECT id_ciudad FROM ciudad WHERE nombre_ciudad = 'Tokio'));
INSERT INTO estadio (nombre_estadio, capacidad, id_ciudad) VALUES ('Seoul World Cup Stadium',   66000, (SELECT id_ciudad FROM ciudad WHERE nombre_ciudad = 'Seul'));
INSERT INTO estadio (nombre_estadio, capacidad, id_ciudad) VALUES ('King Fahd Stadium',         68000, (SELECT id_ciudad FROM ciudad WHERE nombre_ciudad = 'Riad'));
INSERT INTO estadio (nombre_estadio, capacidad, id_ciudad) VALUES ('MetLife Stadium',           82500, (SELECT id_ciudad FROM ciudad WHERE nombre_ciudad = 'Nueva York'));
INSERT INTO estadio (nombre_estadio, capacidad, id_ciudad) VALUES ('BMO Field',                 45000, (SELECT id_ciudad FROM ciudad WHERE nombre_ciudad = 'Toronto'));

-- 5. SELECCION
INSERT INTO seleccion (nombre_seleccion, id_confederacion) VALUES ('BRASIL',        (SELECT id_confederacion FROM confederacion WHERE nombre_confederacion = 'CONMEBOL'));
INSERT INTO seleccion (nombre_seleccion, id_confederacion) VALUES ('ARGENTINA',     (SELECT id_confederacion FROM confederacion WHERE nombre_confederacion = 'CONMEBOL'));
INSERT INTO seleccion (nombre_seleccion, id_confederacion) VALUES ('COLOMBIA',      (SELECT id_confederacion FROM confederacion WHERE nombre_confederacion = 'CONMEBOL'));
INSERT INTO seleccion (nombre_seleccion, id_confederacion) VALUES ('PERU',          (SELECT id_confederacion FROM confederacion WHERE nombre_confederacion = 'CONMEBOL'));
INSERT INTO seleccion (nombre_seleccion, id_confederacion) VALUES ('MEXICO',        (SELECT id_confederacion FROM confederacion WHERE nombre_confederacion = 'CONMEBOL'));
INSERT INTO seleccion (nombre_seleccion, id_confederacion) VALUES ('AUSTRALIA',     (SELECT id_confederacion FROM confederacion WHERE nombre_confederacion = 'FIFA'));
INSERT INTO seleccion (nombre_seleccion, id_confederacion) VALUES ('ESTADOS UNIDOS',(SELECT id_confederacion FROM confederacion WHERE nombre_confederacion = 'FIFA'));
INSERT INTO seleccion (nombre_seleccion, id_confederacion) VALUES ('CANADA',        (SELECT id_confederacion FROM confederacion WHERE nombre_confederacion = 'FIFA'));
INSERT INTO seleccion (nombre_seleccion, id_confederacion) VALUES ('PORTUGAL',      (SELECT id_confederacion FROM confederacion WHERE nombre_confederacion = 'UEFA'));
INSERT INTO seleccion (nombre_seleccion, id_confederacion) VALUES ('ESPANA',        (SELECT id_confederacion FROM confederacion WHERE nombre_confederacion = 'UEFA'));
INSERT INTO seleccion (nombre_seleccion, id_confederacion) VALUES ('ALEMANIA',      (SELECT id_confederacion FROM confederacion WHERE nombre_confederacion = 'UEFA'));
INSERT INTO seleccion (nombre_seleccion, id_confederacion) VALUES ('FRANCIA',       (SELECT id_confederacion FROM confederacion WHERE nombre_confederacion = 'UEFA'));
INSERT INTO seleccion (nombre_seleccion, id_confederacion) VALUES ('JAPON',         (SELECT id_confederacion FROM confederacion WHERE nombre_confederacion = 'AFC'));
INSERT INTO seleccion (nombre_seleccion, id_confederacion) VALUES ('COREA DEL SUR', (SELECT id_confederacion FROM confederacion WHERE nombre_confederacion = 'AFC'));
INSERT INTO seleccion (nombre_seleccion, id_confederacion) VALUES ('ARABIA SAUDITA',(SELECT id_confederacion FROM confederacion WHERE nombre_confederacion = 'AFC'));

-- 6. NIVEL
INSERT INTO nivel (id_nivel, valorxhora) VALUES ('BASICO',      35000);
INSERT INTO nivel (id_nivel, valorxhora) VALUES ('INTERMEDIO',  70000);
INSERT INTO nivel (id_nivel, valorxhora) VALUES ('EXPERTO',    100000);

-- 7. GUIA
INSERT INTO guia (nombre, guia_jefe, id_nivel) VALUES ('Diego Maradona', NULL, 'EXPERTO');
INSERT INTO guia (nombre, guia_jefe, id_nivel) VALUES ('Jackie Chan',    NULL, 'EXPERTO');
INSERT INTO guia (nombre, guia_jefe, id_nivel) VALUES ('Ibai Llanos',    (SELECT id_guia FROM guia WHERE nombre = 'Diego Maradona'), 'BASICO');
INSERT INTO guia (nombre, guia_jefe, id_nivel) VALUES ('Mr. Bean',       (SELECT id_guia FROM guia WHERE nombre = 'Jackie Chan'),    'BASICO');
INSERT INTO guia (nombre, guia_jefe, id_nivel) VALUES ('Pibe Valderrama',(SELECT id_guia FROM guia WHERE nombre = 'Jackie Chan'),    'INTERMEDIO');
INSERT INTO guia (nombre, guia_jefe, id_nivel) VALUES ('Michael Jackson',(SELECT id_guia FROM guia WHERE nombre = 'Diego Maradona'), 'INTERMEDIO');

-- 8. EXPERIENCIA
--Experiencias de canadá, méxico y EEUU
INSERT INTO experiencia (cupos, descripcion, estado, precio_base, id_guia, horas_trabajadas)
    VALUES (2, 'Inicio del mundial - mex',
            'disponible', 5000, (SELECT id_guia FROM guia WHERE nombre = 'Mr. Bean'), 8);

INSERT INTO experiencia (cupos, descripcion, estado, precio_base, id_guia, horas_trabajadas)
    VALUES (1, 'Inicio del mundial - can',
            'disponible', 7000, (SELECT id_guia FROM guia WHERE nombre = 'Michael Jackson'), 999);

INSERT INTO experiencia (cupos, descripcion, estado, precio_base, id_guia, horas_trabajadas)
    VALUES (2, 'Inicio del mundial - eeuu',
            'disponible', 15000, (SELECT id_guia FROM guia WHERE nombre = 'Pibe Valderrama'), 2);
------------------------------------------------------------------------------------------------------------

INSERT INTO experiencia (cupos, descripcion, estado, precio_base, id_guia, horas_trabajadas)
    VALUES (50, 'Tour estadios sudamericanos con acceso VIP a camerinos en Lima y Bogota',
            'disponible', 100000, (SELECT id_guia FROM guia WHERE nombre = 'Diego Maradona'), 8);

INSERT INTO experiencia (cupos, descripcion, estado, precio_base, id_guia, horas_trabajadas)
    VALUES (50, 'Experiencia premium Europa: Bernabeu y Parc des Princes con cena incluida',
            'agotada', 250000, (SELECT id_guia FROM guia WHERE nombre = 'Ibai Llanos'), 12);

INSERT INTO experiencia (cupos, descripcion, estado, precio_base, id_guia, horas_trabajadas)
    VALUES (50, 'Aventura Asia: Japan National Stadium y Seoul World Cup Stadium',
            'disponible', 10000, (SELECT id_guia FROM guia WHERE nombre = 'Mr. Bean'), 10);

INSERT INTO experiencia (cupos, descripcion, estado, precio_base, id_guia, horas_trabajadas)
    VALUES (50, 'Ruta del Azteca: historia y magia del estadio mas grande de America',
            'agotada', 199900, (SELECT id_guia FROM guia WHERE nombre = 'Pibe Valderrama'), 6);

INSERT INTO experiencia (cupos, descripcion, estado, precio_base, id_guia, horas_trabajadas)
    VALUES (50, 'Oceania Xperience: Stadium Australia y tour mundialista por Canberra',
            'disponible', 125000, (SELECT id_guia FROM guia WHERE nombre = 'Jackie Chan'), 7);

INSERT INTO experiencia (cupos, descripcion, estado, precio_base, id_guia, horas_trabajadas)
    VALUES (50, 'Grand Tour Mundial: Europa y Asia con acceso a 4 estadios emblematicos',
            'cancelada', 367000, (SELECT id_guia FROM guia WHERE nombre = 'Michael Jackson'), 15);

INSERT INTO experiencia (cupos, descripcion, estado, precio_base, id_guia, horas_trabajadas)
    VALUES (50, 'El Campin Experience: vive en vivo el duelo Colombia vs Portugal',
            'disponible', 175000, (SELECT id_guia FROM guia WHERE nombre = 'Pibe Valderrama'), 9);

-- 9. IMPUESTO
-- NUMBER(1,4) solo permite 0.0001 a 0.0009
-- CHECK: tipo_impuesto IN ('IVA','TURISTICO','LOCAL','OTRO')
INSERT INTO impuesto (id_impuesto, valor, tipo_impuesto) VALUES (100, 0.19, 'IVA');
INSERT INTO impuesto (id_impuesto, valor, tipo_impuesto) VALUES (200, 0.002, 'LOCAL');
INSERT INTO impuesto (id_impuesto, valor, tipo_impuesto) VALUES (300, 0.007, 'TURISTICO');
INSERT INTO impuesto (id_impuesto, valor, tipo_impuesto) VALUES (400, 0.009, 'OTRO');

-- 10. SERVICIO
INSERT INTO servicio (nombre, descripcion, costo_adicional) VALUES ('Aire acondicionado',   'Climatizacion premium en zona VIP durante todo el partido',         8000);
INSERT INTO servicio (nombre, descripcion, costo_adicional) VALUES ('Desayuno colombiano',  'Huevos revueltos, pan, chocolate caliente y arepa boyacense',       20000);
INSERT INTO servicio (nombre, descripcion, costo_adicional) VALUES ('Transporte',           'Te llevamos y traemos del estadio. Servicio puerta a puerta',       50000);
INSERT INTO servicio (nombre, descripcion, costo_adicional) VALUES ('Habitacion de Lujo',   'Suite premium para descansar despues de un gran partido',          180000);
INSERT INTO servicio (nombre, descripcion, costo_adicional) VALUES ('Coca Cola barra libre','Barra libre de Coca Cola durante toda la experiencia',              25000);
INSERT INTO servicio (nombre, descripcion, costo_adicional) VALUES ('Foto Mundialista',     'Tomate fotos en estadios favoritos y con jugadores legendarios',    95000);

-- 11. IMPUESTOXSERVICIO
INSERT INTO impuestoxservicio (id_impuesto, id_servicio) VALUES (100, (SELECT id_servicio FROM servicio WHERE nombre = 'Aire acondicionado'));
INSERT INTO impuestoxservicio (id_impuesto, id_servicio) VALUES (200, (SELECT id_servicio FROM servicio WHERE nombre = 'Desayuno colombiano'));
INSERT INTO impuestoxservicio (id_impuesto, id_servicio) VALUES (300, (SELECT id_servicio FROM servicio WHERE nombre = 'Transporte'));
INSERT INTO impuestoxservicio (id_impuesto, id_servicio) VALUES (400, (SELECT id_servicio FROM servicio WHERE nombre = 'Habitacion de Lujo'));
INSERT INTO impuestoxservicio (id_impuesto, id_servicio) VALUES (100, (SELECT id_servicio FROM servicio WHERE nombre = 'Coca Cola barra libre'));
INSERT INTO impuestoxservicio (id_impuesto, id_servicio) VALUES (200, (SELECT id_servicio FROM servicio WHERE nombre = 'Coca Cola barra libre'));
INSERT INTO impuestoxservicio (id_impuesto, id_servicio) VALUES (300, (SELECT id_servicio FROM servicio WHERE nombre = 'Foto Mundialista'));

-- 12. SERVICIOSXINSCRIPCION
-- Exp 1 (sudamericanos)
INSERT INTO serviciosxinscripcion (id_servicio, id_experiencia, cantidad) VALUES ((SELECT id_servicio FROM servicio WHERE nombre = 'Aire acondicionado'),  (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%sudamericanos%'), 2);
INSERT INTO serviciosxinscripcion (id_servicio, id_experiencia, cantidad) VALUES ((SELECT id_servicio FROM servicio WHERE nombre = 'Desayuno colombiano'), (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%sudamericanos%'), 2);
INSERT INTO serviciosxinscripcion (id_servicio, id_experiencia, cantidad) VALUES ((SELECT id_servicio FROM servicio WHERE nombre = 'Transporte'),          (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%sudamericanos%'), 3);
-- Exp 2 (Bernabeu)
INSERT INTO serviciosxinscripcion (id_servicio, id_experiencia, cantidad) VALUES ((SELECT id_servicio FROM servicio WHERE nombre = 'Desayuno colombiano'), (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Bernabeu%'), 2);
INSERT INTO serviciosxinscripcion (id_servicio, id_experiencia, cantidad) VALUES ((SELECT id_servicio FROM servicio WHERE nombre = 'Habitacion de Lujo'),  (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Bernabeu%'), 3);
INSERT INTO serviciosxinscripcion (id_servicio, id_experiencia, cantidad) VALUES ((SELECT id_servicio FROM servicio WHERE nombre = 'Foto Mundialista'),    (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Bernabeu%'), 4);
-- Exp 3 (Japan National)
INSERT INTO serviciosxinscripcion (id_servicio, id_experiencia, cantidad) VALUES ((SELECT id_servicio FROM servicio WHERE nombre = 'Aire acondicionado'),  (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Japan National%'), 2);
INSERT INTO serviciosxinscripcion (id_servicio, id_experiencia, cantidad) VALUES ((SELECT id_servicio FROM servicio WHERE nombre = 'Desayuno colombiano'), (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Japan National%'), 3);
INSERT INTO serviciosxinscripcion (id_servicio, id_experiencia, cantidad) VALUES ((SELECT id_servicio FROM servicio WHERE nombre = 'Transporte'),          (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Japan National%'), 4);
-- Exp 4 (Azteca)
INSERT INTO serviciosxinscripcion (id_servicio, id_experiencia, cantidad) VALUES ((SELECT id_servicio FROM servicio WHERE nombre = 'Coca Cola barra libre'),(SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Azteca%'), 2);
INSERT INTO serviciosxinscripcion (id_servicio, id_experiencia, cantidad) VALUES ((SELECT id_servicio FROM servicio WHERE nombre = 'Foto Mundialista'),    (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Azteca%'), 3);
INSERT INTO serviciosxinscripcion (id_servicio, id_experiencia, cantidad) VALUES ((SELECT id_servicio FROM servicio WHERE nombre = 'Desayuno colombiano'), (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Azteca%'), 4);
-- Exp 5 (Oceania)
INSERT INTO serviciosxinscripcion (id_servicio, id_experiencia, cantidad) VALUES ((SELECT id_servicio FROM servicio WHERE nombre = 'Habitacion de Lujo'),  (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Oceania%'), 2);
INSERT INTO serviciosxinscripcion (id_servicio, id_experiencia, cantidad) VALUES ((SELECT id_servicio FROM servicio WHERE nombre = 'Coca Cola barra libre'),(SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Oceania%'), 3);
INSERT INTO serviciosxinscripcion (id_servicio, id_experiencia, cantidad) VALUES ((SELECT id_servicio FROM servicio WHERE nombre = 'Aire acondicionado'),  (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Oceania%'), 4);
-- Exp 6 (Grand Tour)
INSERT INTO serviciosxinscripcion (id_servicio, id_experiencia, cantidad) VALUES ((SELECT id_servicio FROM servicio WHERE nombre = 'Transporte'),          (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Grand Tour%'), 2);
INSERT INTO serviciosxinscripcion (id_servicio, id_experiencia, cantidad) VALUES ((SELECT id_servicio FROM servicio WHERE nombre = 'Foto Mundialista'),    (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Grand Tour%'), 3);
INSERT INTO serviciosxinscripcion (id_servicio, id_experiencia, cantidad) VALUES ((SELECT id_servicio FROM servicio WHERE nombre = 'Aire acondicionado'),  (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Grand Tour%'), 4);

-- 13. PARTIDO
-- fecha es TIMESTAMP en el schema pero acepta TO_DATE sin problema en Oracle
-- GRUPOS
INSERT INTO partido (id_estadio, fecha, fase, id_seleccion_local, id_seleccion_visitante, goles_local, goles_visitante, id_experiencia)
    VALUES ((SELECT id_estadio FROM estadio WHERE nombre_estadio = 'Estadio Nacional de Lima'),
            TO_DATE('10/06/2026','DD/MM/YYYY'), 'GRUPOS',
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'PERU'),
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'COLOMBIA'),
            2, 1, (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%sudamericanos%'));

INSERT INTO partido (id_estadio, fecha, fase, id_seleccion_local, id_seleccion_visitante, goles_local, goles_visitante, id_experiencia)
    VALUES ((SELECT id_estadio FROM estadio WHERE nombre_estadio = 'Estadio Azteca'),
            TO_DATE('11/06/2026','DD/MM/YYYY'), 'GRUPOS',
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'MEXICO'),
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'BRASIL'),
            3, 0, (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%- mex%'));

INSERT INTO partido (id_estadio, fecha, fase, id_seleccion_local, id_seleccion_visitante, goles_local, goles_visitante, id_experiencia)
    VALUES ((SELECT id_estadio FROM estadio WHERE nombre_estadio = 'Estadio Santiago Bernabeu'),
            TO_DATE('12/06/2026','DD/MM/YYYY'), 'GRUPOS',
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'ESPANA'),
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'PORTUGAL'),
            1, 1, (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Bernabeu%'));

INSERT INTO partido (id_estadio, fecha, fase, id_seleccion_local, id_seleccion_visitante, goles_local, goles_visitante, id_experiencia)
    VALUES ((SELECT id_estadio FROM estadio WHERE nombre_estadio = 'Parc des Princes'),
            TO_DATE('13/06/2026','DD/MM/YYYY'), 'GRUPOS',
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'FRANCIA'),
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'ALEMANIA'),
            2, 2, NULL);

INSERT INTO partido (id_estadio, fecha, fase, id_seleccion_local, id_seleccion_visitante, goles_local, goles_visitante, id_experiencia)
    VALUES ((SELECT id_estadio FROM estadio WHERE nombre_estadio = 'Japan National Stadium'),
            TO_DATE('14/06/2026','DD/MM/YYYY'), 'GRUPOS',
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'JAPON'),
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'COREA DEL SUR'),
            1, 0, (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Japan National%'));

-- Partido EUA (query 6)
INSERT INTO partido (id_estadio, fecha, fase, id_seleccion_local, id_seleccion_visitante, goles_local, goles_visitante, id_experiencia)
    VALUES ((SELECT id_estadio FROM estadio WHERE nombre_estadio = 'MetLife Stadium'),
            TO_DATE('15/06/2026','DD/MM/YYYY'), 'GRUPOS',
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'ESTADOS UNIDOS'),
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'CANADA'),
            1, 0, (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%- eeuu%'));

-- Partido Canada (query 6)
INSERT INTO partido (id_estadio, fecha, fase, id_seleccion_local, id_seleccion_visitante, goles_local, goles_visitante, id_experiencia)
    VALUES ((SELECT id_estadio FROM estadio WHERE nombre_estadio = 'BMO Field'),
            TO_DATE('16/06/2026','DD/MM/YYYY'), 'GRUPOS',
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'CANADA'),
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'AUSTRALIA'),
            2, 1, (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%- can%'));

-- Partido Colombia vs Portugal (query 7)
INSERT INTO partido (id_estadio, fecha, fase, id_seleccion_local, id_seleccion_visitante, goles_local, goles_visitante, id_experiencia)
    VALUES ((SELECT id_estadio FROM estadio WHERE nombre_estadio = 'Estadio El Campin'),
            TO_DATE('17/06/2026','DD/MM/YYYY'), 'GRUPOS',
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'COLOMBIA'),
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'PORTUGAL'),
            1, 2, (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%El Campin%'));

-- OCTAVOS
INSERT INTO partido (id_estadio, fecha, fase, id_seleccion_local, id_seleccion_visitante, goles_local, goles_visitante, id_experiencia)
    VALUES ((SELECT id_estadio FROM estadio WHERE nombre_estadio = 'Estadio Monumental'),
            TO_DATE('25/06/2026','DD/MM/YYYY'), 'OCTAVOS',
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'ARGENTINA'),
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'AUSTRALIA'),
            4, 0, NULL);

INSERT INTO partido (id_estadio, fecha, fase, id_seleccion_local, id_seleccion_visitante, goles_local, goles_visitante, id_experiencia)
    VALUES ((SELECT id_estadio FROM estadio WHERE nombre_estadio = 'Estadio da Luz'),
            TO_DATE('26/06/2026','DD/MM/YYYY'), 'OCTAVOS',
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'PORTUGAL'),
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'FRANCIA'),
            2, 3, (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Azteca%'));

-- CUARTOS
INSERT INTO partido (id_estadio, fecha, fase, id_seleccion_local, id_seleccion_visitante, goles_local, goles_visitante, id_experiencia)
    VALUES ((SELECT id_estadio FROM estadio WHERE nombre_estadio = 'Stadium Australia'),
            TO_DATE('03/07/2026','DD/MM/YYYY'), 'CUARTOS',
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'BRASIL'),
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'FRANCIA'),
            1, 2, (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Oceania%'));

-- SEMIFINAL
INSERT INTO partido (id_estadio, fecha, fase, id_seleccion_local, id_seleccion_visitante, goles_local, goles_visitante, id_experiencia)
    VALUES ((SELECT id_estadio FROM estadio WHERE nombre_estadio = 'Estadio Santiago Bernabeu'),
            TO_DATE('10/07/2026','DD/MM/YYYY'), 'SEMIFINAL',
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'ARGENTINA'),
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'FRANCIA'),
            3, 1, NULL);

-- FINAL
INSERT INTO partido (id_estadio, fecha, fase, id_seleccion_local, id_seleccion_visitante, goles_local, goles_visitante, id_experiencia)
    VALUES ((SELECT id_estadio FROM estadio WHERE nombre_estadio = 'Estadio Monumental'),
            TO_DATE('19/07/2026','DD/MM/YYYY'), 'FINAL',
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'ARGENTINA'),
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'ESPANA'),
            2, 1, (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Grand Tour%'));

-- GrupOS
INSERT INTO partido (id_estadio, fecha, fase, id_seleccion_local, id_seleccion_visitante, goles_local, goles_visitante, id_experiencia)
    VALUES ((SELECT id_estadio FROM estadio WHERE nombre_estadio = 'Estadio Azteca'),
            TO_DATE('10/06/2027','DD/MM/YYYY'), 'GRUPOS',
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'MEXICO'),
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'COLOMBIA'),
            2, 1, (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%- mex%'));

INSERT INTO partido (id_estadio, fecha, fase, id_seleccion_local, id_seleccion_visitante, goles_local, goles_visitante, id_experiencia)
    VALUES ((SELECT id_estadio FROM estadio WHERE nombre_estadio = 'BMO Field'),
            TO_DATE('11/06/2027','DD/MM/YYYY'), 'GRUPOS',
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'CANADA'),
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'COLOMBIA'),
            3, 1, (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%- can%'));

INSERT INTO partido (id_estadio, fecha, fase, id_seleccion_local, id_seleccion_visitante, goles_local, goles_visitante, id_experiencia)
    VALUES ((SELECT id_estadio FROM estadio WHERE nombre_estadio = 'MetLife Stadium'),
            TO_DATE('12/06/2027','DD/MM/YYYY'), 'GRUPOS',
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'ESTADOS UNIDOS'),
            (SELECT id_seleccion FROM seleccion WHERE nombre_seleccion = 'COLOMBIA'),
            1, 1, (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%- eeuu%'));
-- 14. CLIENTE
INSERT INTO cliente (nombre, apellido, tipo_documento, numero_telefono, email) VALUES ('Juan',      'Perez',     'CC', 3191122880, 'juan.perez@gmail.com');
INSERT INTO cliente (nombre, apellido, tipo_documento, numero_telefono, email) VALUES ('Maria',     'Gomez',     'CC', 3102244556, 'maria.gomez@gmail.com');
INSERT INTO cliente (nombre, apellido, tipo_documento, numero_telefono, email) VALUES ('Carlos',    'Ramirez',   'CC', 3114488552, 'carlos.ramirez@gmail.com');
INSERT INTO cliente (nombre, apellido, tipo_documento, numero_telefono, email) VALUES ('Laura',     'Martinez',  'TI', 3011234567, 'laura.martinez@gmail.com');
INSERT INTO cliente (nombre, apellido, tipo_documento, numero_telefono, email) VALUES ('Andres',    'Torres',    'CC', 3156677889, 'andres.torres@gmail.com');
INSERT INTO cliente (nombre, apellido, tipo_documento, numero_telefono, email) VALUES ('Maria',     'Lopez',     'CC', 3129988776, 'maria.lopez@gmail.com');
INSERT INTO cliente (nombre, apellido, tipo_documento, numero_telefono, email) VALUES ('Diego',     'Hernandez', 'CC', 3012345678, 'diego.hernandez@gmail.com');
INSERT INTO cliente (nombre, apellido, tipo_documento, numero_telefono, email) VALUES ('Valentina', 'Castro',    'TI', 3188765432, 'valentina.castro@gmail.com');
INSERT INTO cliente (nombre, apellido, tipo_documento, numero_telefono, email) VALUES ('Sebastian', 'Morales',   'CC', 3001112233, 'sebastian.morales@gmail.com');
INSERT INTO cliente (nombre, apellido, tipo_documento, numero_telefono, email) VALUES ('Sofia',     'Mora',      'CC', 3182312300, 'sofia.mora@gmail.com');

-- 15. TRANSACCION
INSERT INTO transaccion (id_transaccion, valor, tipo_pago, referencia, fecha_pago) VALUES (5001, 100000, 'TARJETA_CREDITO', 90011001, TO_DATE('01/05/2026','DD/MM/YYYY'));
INSERT INTO transaccion (id_transaccion, valor, tipo_pago, referencia, fecha_pago) VALUES (5002, 250000, 'TRANSFERENCIA',   90011002, TO_DATE('02/05/2026','DD/MM/YYYY'));
INSERT INTO transaccion (id_transaccion, valor, tipo_pago, referencia, fecha_pago) VALUES (5003, 150000, 'TARJETA_DEBITO',  90011003, TO_DATE('03/05/2026','DD/MM/YYYY'));
INSERT INTO transaccion (id_transaccion, valor, tipo_pago, referencia, fecha_pago) VALUES (5004, 199900, 'EFECTIVO',        90011004, TO_DATE('04/05/2026','DD/MM/YYYY'));
INSERT INTO transaccion (id_transaccion, valor, tipo_pago, referencia, fecha_pago) VALUES (5005, 125000, 'TARJETA_CREDITO', 90011005, TO_DATE('05/05/2026','DD/MM/YYYY'));
INSERT INTO transaccion (id_transaccion, valor, tipo_pago, referencia, fecha_pago) VALUES (5006, 367000, 'TRANSFERENCIA',   90011006, TO_DATE('06/05/2026','DD/MM/YYYY'));
INSERT INTO transaccion (id_transaccion, valor, tipo_pago, referencia, fecha_pago) VALUES (5007, 100000, 'TARJETA_DEBITO',  90011007, TO_DATE('07/05/2026','DD/MM/YYYY'));
INSERT INTO transaccion (id_transaccion, valor, tipo_pago, referencia, fecha_pago) VALUES (5008, 250000, 'TARJETA_CREDITO', 90011008, TO_DATE('08/05/2026','DD/MM/YYYY'));

-- 16. INSCRIPCION
INSERT INTO inscripcion (id_experiencia, id_cliente) VALUES ((SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%sudamericanos%'), (SELECT id_cliente FROM cliente WHERE email = 'juan.perez@gmail.com'));
INSERT INTO inscripcion (id_experiencia, id_cliente) VALUES ((SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%sudamericanos%'), (SELECT id_cliente FROM cliente WHERE email = 'maria.gomez@gmail.com'));
INSERT INTO inscripcion (id_experiencia, id_cliente) VALUES ((SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Bernabeu%'),       (SELECT id_cliente FROM cliente WHERE email = 'carlos.ramirez@gmail.com'));
INSERT INTO inscripcion (id_experiencia, id_cliente) VALUES ((SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Bernabeu%'),       (SELECT id_cliente FROM cliente WHERE email = 'laura.martinez@gmail.com'));
INSERT INTO inscripcion (id_experiencia, id_cliente) VALUES ((SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Japan National%'), (SELECT id_cliente FROM cliente WHERE email = 'andres.torres@gmail.com'));
INSERT INTO inscripcion (id_experiencia, id_cliente) VALUES ((SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Japan National%'), (SELECT id_cliente FROM cliente WHERE email = 'maria.lopez@gmail.com'));
INSERT INTO inscripcion (id_experiencia, id_cliente) VALUES ((SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Azteca%'),         (SELECT id_cliente FROM cliente WHERE email = 'diego.hernandez@gmail.com'));
INSERT INTO inscripcion (id_experiencia, id_cliente) VALUES ((SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Azteca%'),         (SELECT id_cliente FROM cliente WHERE email = 'valentina.castro@gmail.com'));
INSERT INTO inscripcion (id_experiencia, id_cliente) VALUES ((SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Oceania%'),        (SELECT id_cliente FROM cliente WHERE email = 'sebastian.morales@gmail.com'));
INSERT INTO inscripcion (id_experiencia, id_cliente) VALUES ((SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Grand Tour%'),     (SELECT id_cliente FROM cliente WHERE email = 'sofia.mora@gmail.com'));
INSERT INTO inscripcion (id_experiencia, id_cliente) VALUES ((SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%- mex%'),     (SELECT id_cliente FROM cliente WHERE email = 'sofia.mora@gmail.com'));
INSERT INTO inscripcion (id_experiencia, id_cliente) VALUES ((SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%- mex%'),     (SELECT id_cliente FROM cliente WHERE email = 'sebastian.morales@gmail.com'));
INSERT INTO inscripcion (id_experiencia, id_cliente) VALUES ((SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%- mex%'),     (SELECT id_cliente FROM cliente WHERE email = 'laura.martinez@gmail.com'));
INSERT INTO inscripcion (id_experiencia, id_cliente) VALUES ((SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%- can%'),     (SELECT id_cliente FROM cliente WHERE email = 'sofia.mora@gmail.com'));
INSERT INTO inscripcion (id_experiencia, id_cliente) VALUES ((SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%- can%'),     (SELECT id_cliente FROM cliente WHERE email = 'sebastian.morales@gmail.com'));
INSERT INTO inscripcion (id_experiencia, id_cliente) VALUES ((SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%- can%'),     (SELECT id_cliente FROM cliente WHERE email = 'laura.martinez@gmail.com'));
INSERT INTO inscripcion (id_experiencia, id_cliente) VALUES ((SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%- eeuu%'),     (SELECT id_cliente FROM cliente WHERE email = 'sofia.mora@gmail.com'));
INSERT INTO inscripcion (id_experiencia, id_cliente) VALUES ((SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%- eeuu%'),     (SELECT id_cliente FROM cliente WHERE email = 'sebastian.morales@gmail.com'));
INSERT INTO inscripcion (id_experiencia, id_cliente) VALUES ((SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%- eeuu%'),     (SELECT id_cliente FROM cliente WHERE email = 'laura.martinez@gmail.com'));

-- 17. PAGOS
INSERT INTO pagos (id_cliente, id_experiencia, id_transaccion) VALUES ((SELECT id_cliente FROM cliente WHERE email = 'juan.perez@gmail.com'),       (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%sudamericanos%'), 5001);
INSERT INTO pagos (id_cliente, id_experiencia, id_transaccion) VALUES ((SELECT id_cliente FROM cliente WHERE email = 'maria.gomez@gmail.com'),      (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%sudamericanos%'), 5002);
INSERT INTO pagos (id_cliente, id_experiencia, id_transaccion) VALUES ((SELECT id_cliente FROM cliente WHERE email = 'carlos.ramirez@gmail.com'),   (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Bernabeu%'),       5003);
INSERT INTO pagos (id_cliente, id_experiencia, id_transaccion) VALUES ((SELECT id_cliente FROM cliente WHERE email = 'laura.martinez@gmail.com'),   (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Bernabeu%'),       5004);
INSERT INTO pagos (id_cliente, id_experiencia, id_transaccion) VALUES ((SELECT id_cliente FROM cliente WHERE email = 'andres.torres@gmail.com'),    (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Japan National%'), 5005);
INSERT INTO pagos (id_cliente, id_experiencia, id_transaccion) VALUES ((SELECT id_cliente FROM cliente WHERE email = 'maria.lopez@gmail.com'),      (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Japan National%'), 5006);
INSERT INTO pagos (id_cliente, id_experiencia, id_transaccion) VALUES ((SELECT id_cliente FROM cliente WHERE email = 'diego.hernandez@gmail.com'),  (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Azteca%'),         5007);
INSERT INTO pagos (id_cliente, id_experiencia, id_transaccion) VALUES ((SELECT id_cliente FROM cliente WHERE email = 'valentina.castro@gmail.com'), (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Azteca%'),         5008);
INSERT INTO pagos (id_cliente, id_experiencia, id_transaccion) VALUES ((SELECT id_cliente FROM cliente WHERE email = 'sebastian.morales@gmail.com'),(SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Oceania%'),        5005);
INSERT INTO pagos (id_cliente, id_experiencia, id_transaccion) VALUES ((SELECT id_cliente FROM cliente WHERE email = 'sofia.mora@gmail.com'),       (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%Grand Tour%'),     5006);

-- Servicios de El Campin Experience
INSERT INTO serviciosxinscripcion (id_servicio, id_experiencia, cantidad) VALUES ((SELECT id_servicio FROM servicio WHERE nombre = 'Transporte'),         (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%El Campin%'), 2);
INSERT INTO serviciosxinscripcion (id_servicio, id_experiencia, cantidad) VALUES ((SELECT id_servicio FROM servicio WHERE nombre = 'Desayuno colombiano'),(SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%El Campin%'), 3);
INSERT INTO serviciosxinscripcion (id_servicio, id_experiencia, cantidad) VALUES ((SELECT id_servicio FROM servicio WHERE nombre = 'Foto Mundialista'),   (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%El Campin%'), 2);

-- Transacciones El Campin Experience
INSERT INTO transaccion (id_transaccion, valor, tipo_pago, referencia, fecha_pago) VALUES (5009, 175000, 'TARJETA_CREDITO', 90011009, TO_DATE('09/05/2026','DD/MM/YYYY'));
INSERT INTO transaccion (id_transaccion, valor, tipo_pago, referencia, fecha_pago) VALUES (5010, 175000, 'TRANSFERENCIA',   90011010, TO_DATE('10/05/2026','DD/MM/YYYY'));
INSERT INTO transaccion (id_transaccion, valor, tipo_pago, referencia, fecha_pago) VALUES (5011, 175000, 'EFECTIVO',        90011011, TO_DATE('11/05/2026','DD/MM/YYYY'));

-- Inscripciones El Campin Experience
INSERT INTO inscripcion (id_experiencia, id_cliente) VALUES ((SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%El Campin%'), (SELECT id_cliente FROM cliente WHERE email = 'carlos.ramirez@gmail.com'));
INSERT INTO inscripcion (id_experiencia, id_cliente) VALUES ((SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%El Campin%'), (SELECT id_cliente FROM cliente WHERE email = 'sofia.mora@gmail.com'));
INSERT INTO inscripcion (id_experiencia, id_cliente) VALUES ((SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%El Campin%'), (SELECT id_cliente FROM cliente WHERE email = 'andres.torres@gmail.com'));

-- Pagos El Campin Experience
INSERT INTO pagos (id_cliente, id_experiencia, id_transaccion) VALUES ((SELECT id_cliente FROM cliente WHERE email = 'carlos.ramirez@gmail.com'), (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%El Campin%'), 5009);
INSERT INTO pagos (id_cliente, id_experiencia, id_transaccion) VALUES ((SELECT id_cliente FROM cliente WHERE email = 'sofia.mora@gmail.com'),      (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%El Campin%'), 5010);
INSERT INTO pagos (id_cliente, id_experiencia, id_transaccion) VALUES ((SELECT id_cliente FROM cliente WHERE email = 'andres.torres@gmail.com'),   (SELECT id_experiencia FROM experiencia WHERE descripcion LIKE '%El Campin%'), 5011);

COMMIT;

--QUERIES / FUNCIÓN

--1: Mostrar las experiencias disponibles por ciudad, estadio o partido
SELECT 
    p.nombre_pais "País",
    ci.nombre_ciudad "Ciudad",
    e.descripcion "Descripcion",
    e.precio_base "Precio base"
    FROM EXPERIENCIA e
    LEFT OUTER JOIN PARTIDO pa ON pa.ID_EXPERIENCIA = e.ID_EXPERIENCIA
    INNER JOIN ESTADIO e ON e.ID_ESTADIO = pa.ID_ESTADIO
    INNER JOIN CIUDAD ci ON ci.ID_CIUDAD = e.ID_CIUDAD
    INNER JOIN PAIS p ON p.ID_PAIS = ci.ID_PAIS

    ORDER BY "País" DESC, "Ciudad" DESC;

--2: Muestra los clientes con mayor número de inscripciones
SELECT 
    c.nombre "Cliente",
    COUNT(*) "Número de inscripciones"

FROM INSCRIPCION i
INNER JOIN CLIENTE c ON c.id_cliente = i.id_cliente
GROUP BY c.nombre
ORDER BY "Número de inscripciones" DESC;

--3: Muestra los ingresos generados por guía en las experiencias

SELECT  g.nombre, 
SUM(e.horas_trabajadas * n.valorxhora) AS "Ingresos por guía"
FROM GUIA g
INNER JOIN nivel n ON g.ID_NIVEL = n.ID_NIVEL
INNER JOIN EXPERIENCIA e ON g.ID_GUIA = e.ID_EXPERIENCIA
GROUP BY g.ID_GUIA, g.NOMBRE
ORDER BY "Ingresos por guía" DESC; 

--4: Calcula impuestos asociados a las inscripciones
CREATE OR REPLACE FUNCTION PRECIO_TOTAL(id_busqueda NUMBER)
RETURN NUMBER AS
    base_precio NUMBER;
    total_servicios NUMBER := 0;
BEGIN
    -- Precio base de la experiencia
    SELECT precio_base
    INTO base_precio
    FROM experiencia
    WHERE id_experiencia = id_busqueda;

    --Precio total de los servicios
    SELECT SUM(subtotal)
    INTO total_servicios
    FROM (
        SELECT sxi.cantidad * s.costo_adicional * (1 + SUM(i.valor)) subtotal
        FROM serviciosxinscripcion sxi
        INNER JOIN servicio s ON s.id_servicio   = sxi.id_servicio
        INNER JOIN impuestoxservicio ixs ON ixs.id_servicio = s.id_servicio
        INNER JOIN impuesto i ON i.id_impuesto   = ixs.id_impuesto
        WHERE sxi.id_experiencia = id_busqueda
        GROUP BY sxi.id_servicio, sxi.cantidad, s.costo_adicional
    );

    RETURN base_precio + NVL(total_servicios, 0);

END PRECIO_TOTAL;
/

SELECT 
    e.id_experiencia "ID experiencia",
    e.descripcion "Descripción",
    e.PRECIO_BASE "Precio base",
    ROUND(PRECIO_TOTAL(e.id_experiencia), 2) AS "Precio con impuestos"
FROM EXPERIENCIA e
ORDER BY "ID experiencia";


--5: experiencias más demandadas durantre el mundial

 SELECT e.id_experiencia, e.DESCRIPCION,
    COUNT (cx.id_cliente) "Total de ventas"
 FROM EXPERIENCIA e 
 JOIN inscripcion cx ON e.id_experiencia = cx.id_experiencia
 GROUP BY e.id_experiencia, e.descripcion
 ORDER BY "Total de ventas" DESC;
 
--6 total de ingreso por los países sede (México, EEUU y Canadá)

SELECT 
    p.nombre_pais "País sede",
    SUM(NVL(PRECIO_TOTAL(i.id_experiencia), 0)) AS "Ganancias generadas"
FROM pais p
LEFT JOIN ciudad c ON c.id_pais = p.id_pais
LEFT JOIN estadio e ON e.id_ciudad = c.id_ciudad
LEFT JOIN partido pa ON pa.id_estadio = e.id_estadio
LEFT JOIN experiencia ex ON pa.id_experiencia = ex.id_experiencia
LEFT JOIN inscripcion i ON i.id_experiencia = ex.id_experiencia 
WHERE p.nombre_pais IN ('MEXICO', 'CANADA', 'ESTADOS UNIDOS')
GROUP BY p.nombre_pais;


--7: Experiencias vendidas para Colombia - Portugal y ventas

SELECT 
    ex.cupos "Cupos totales",
    COUNT(i.id_cliente) "Vendidas",
    ex.cupos - COUNT(i.id_cliente) AS "Cupos restantes"
FROM experiencia ex
INNER JOIN partido pa ON pa.id_experiencia = ex.id_experiencia
INNER JOIN seleccion sl ON pa.id_seleccion_local = sl.id_seleccion
INNER JOIN seleccion sv ON pa.id_seleccion_visitante = sv.id_seleccion
LEFT JOIN inscripcion i ON i.id_experiencia = ex.id_experiencia
WHERE sl.nombre_seleccion = 'COLOMBIA' 
  AND sv.nombre_seleccion = 'PORTUGAL'
GROUP BY ex.id_experiencia, ex.cupos;
