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
  precio_total NUMBER(12,4) DEFAULT 0,
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
  valor NUMBER(1,4),
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