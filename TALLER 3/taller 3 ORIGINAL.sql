DROP TABLE titulares CASCADE CONSTRAINTS;
DROP TABLE cuentas CASCADE CONSTRAINTS;
DROP TABLE oficinas CASCADE CONSTRAINTS;
DROP TABLE clientes CASCADE CONSTRAINTS;

DROP VIEW CuentasXCliente;


CREATE TABLE clientes(
    codigo number(3,0) not null,
    nombre varchar2(60) not null,
    apellido varchar2(60) not null,
    fecha_nacimiento date not null,
    email varchar(60),
    PRIMARY KEY(codigo)
);

CREATE TABLE oficinas(
    codigo number(3,0) not null,
    nombre varchar2(60) not null,
    barrio varchar(60) not null,
    PRIMARY KEY(codigo)
);

CREATE TABLE cuentas(
    numero number(3,0),
    saldo number(10,2),
    codigo_oficina number(3,0),
    tipo CHAR(1),
    PRIMARY KEY(numero),
    FOREIGN KEY (codigo_oficina) REFERENCES oficinas
);

CREATE TABLE titulares(
    codigo_cliente number(3,0),
    numero_cuenta number(3,0),
    PRIMARY KEY(codigo_cliente, numero_cuenta)
);


CREATE VIEW CuentasXCliente AS
    SELECT Ci.codigo, 
            Ci.nombre || ' ' || Ci.apellido nombre_completo, 
            COUNT(T.numero_cuenta) cantidad_cuentas
    FROM clientes Ci
        INNER JOIN titulares T 
            ON Ci.codigo = T.codigo_cliente
    GROUP BY Ci.codigo, Ci.nombre, Ci.apellido;    


--Requerimientos 


-- 1: 
ALTER TABLE titulares 
ADD CONSTRAINT FK_titular_clientes
    FOREIGN KEY (codigo_cliente) references clientes ON DELETE CASCADE;

ALTER TABLE titulares 
ADD CONSTRAINT FK_titular_cuenta 
    FOREIGN KEY (numero_cuenta) references cuentas ON DELETE CASCADE;

-- 2:
ALTER TABLE cuentas
ADD CONSTRAINT CHK_CUENTA_TIPO
    CHECK(tipo = 'C' OR tipo = 'A');

-- 3:
-- ese grand es para dar el permiso de lectura
GRANT SELECT ON CuentasXClientes TO PUBLIC;

--4:
UPDATE cuentas
set saldo = 
CASE 
    WHEN tipo = 'A' AND saldo < 1000 THEN SALDO + 50 
    WHEN tipo = 'A' AND saldo >= 1000 THEN SALDO + 100 
    WHEN tipo = 'C' AND saldo < 500 THEN SALDO - 25 
    WHEN tipo = 'C' AND saldo >= 500 THEN SALDO 
END;

        -- INSERTS APOYADOS POR OPEN AI (ChatGPT) -- 

INSERT INTO oficinas VALUES (101, 'Oficina Centro', 'La Candelaria');
INSERT INTO oficinas VALUES (102, 'Oficina Norte', 'Usaquén');
INSERT INTO oficinas VALUES (103, 'Oficina Sur', 'Bosa');
INSERT INTO oficinas VALUES (104, 'Oficina Occidente', 'Fontibón');
INSERT INTO oficinas VALUES (105, 'Oficina Chapinero', 'Chapinero');
INSERT INTO oficinas VALUES (106, 'Oficina Medellín Centro', 'Laureles');
INSERT INTO oficinas VALUES (107, 'Oficina Medellín Norte', 'Bello');
INSERT INTO oficinas VALUES (108, 'Oficina Cali Centro', 'San Antonio');
INSERT INTO oficinas VALUES (109, 'Oficina Cali Sur', 'Ciudad Jardín');
INSERT INTO oficinas VALUES (110, 'Oficina Barranquilla', 'El Prado');
INSERT INTO oficinas VALUES (111, 'Oficina Cartagena', 'Bocagrande');
INSERT INTO oficinas VALUES (112, 'Oficina Bucaramanga', 'Cabecera');
INSERT INTO oficinas VALUES (113, 'Oficina Pereira', 'Centro');
INSERT INTO oficinas VALUES (114, 'Oficina Manizales', 'Chipre');
INSERT INTO oficinas VALUES (115, 'Oficina Ibagué', 'Centro');
INSERT INTO oficinas VALUES (116, 'Oficina Pasto', 'Centro');
INSERT INTO oficinas VALUES (117, 'Oficina Villavicencio', 'Centro');
INSERT INTO oficinas VALUES (118, 'Oficina Cúcuta', 'Caobos');
INSERT INTO oficinas VALUES (119, 'Oficina Santa Marta', 'Rodadero');
INSERT INTO oficinas VALUES (120, 'Oficina Montería', 'La Castellana');
INSERT INTO oficinas VALUES (121, 'Oficina Neiva', 'Centro');
INSERT INTO oficinas VALUES (122, 'Oficina Tunja', 'Centro');
INSERT INTO oficinas VALUES (123, 'Oficina Armenia', 'Centro');
INSERT INTO oficinas VALUES (124, 'Oficina Sincelejo', 'Centro');
INSERT INTO oficinas VALUES (125, 'Oficina Valledupar', 'Novalito');
INSERT INTO oficinas VALUES (126, 'Oficina Popayán', 'Centro');
INSERT INTO oficinas VALUES (127, 'Oficina Riohacha', 'Centro');
INSERT INTO oficinas VALUES (128, 'Oficina Quibdó', 'Centro');
INSERT INTO oficinas VALUES (129, 'Oficina Leticia', 'Centro');
INSERT INTO oficinas VALUES (130, 'Oficina San Andrés', 'Centro');
-- Oficinas sin cuentas 
INSERT INTO oficinas VALUES (131, 'Oficina Soacha', 'Centro');
INSERT INTO oficinas VALUES (132, 'Oficina Zipaquirá', 'Centro');
INSERT INTO oficinas VALUES (133, 'Oficina Chía', 'Centro');
INSERT INTO oficinas VALUES (134, 'Oficina Girardot', 'Centro');
INSERT INTO oficinas VALUES (135, 'Oficina Duitama', 'Centro');

INSERT INTO clientes VALUES (1,'Juan','Pérez',DATE '1995-04-12','juan.perez@gmail.com');
INSERT INTO clientes VALUES (2,'María','González',DATE '1992-08-25','maria.g@gmail.com');
INSERT INTO clientes VALUES (3,'Carlos','Rodríguez',DATE '1988-02-10','carlos.r@gmail.com');
INSERT INTO clientes VALUES (4,'Laura','Martínez',DATE '1999-11-03','laura.m@gmail.com');
INSERT INTO clientes VALUES (5,'Andrés','López',DATE '1985-07-19','andres.l@gmail.com');
INSERT INTO clientes VALUES (6,'Camila','Ramírez',DATE '1993-06-14','camila.r@gmail.com');
INSERT INTO clientes VALUES (7,'Sebastián','Torres',DATE '1990-09-09','sebas.t@gmail.com');
INSERT INTO clientes VALUES (8,'Valentina','Moreno',DATE '2000-01-21','vale.m@gmail.com');
INSERT INTO clientes VALUES (9,'Daniel','Castro',DATE '1987-12-05','daniel.c@gmail.com');
INSERT INTO clientes VALUES (10,'Paula','Ortiz',DATE '1996-03-17','paula.o@gmail.com');
INSERT INTO clientes VALUES (11,'Santiago','Vargas',DATE '1991-04-30','santiago.v@gmail.com');
INSERT INTO clientes VALUES (12,'Natalia','Suárez',DATE '1994-05-22','natalia.s@gmail.com');
INSERT INTO clientes VALUES (13,'Felipe','Herrera',DATE '1989-08-08','felipe.h@gmail.com');
INSERT INTO clientes VALUES (14,'Daniela','Mendoza',DATE '1998-10-10','daniela.m@gmail.com');
INSERT INTO clientes VALUES (15,'Julián','Rojas',DATE '1986-02-28','julian.r@gmail.com');
INSERT INTO clientes VALUES (16,'Sara','Castillo',DATE '1997-07-07','sara.c@gmail.com');
INSERT INTO clientes VALUES (17,'Miguel','Guerrero',DATE '1992-12-12','miguel.g@gmail.com');
INSERT INTO clientes VALUES (18,'Luisa','Navarro',DATE '1999-09-19','luisa.n@gmail.com');
INSERT INTO clientes VALUES (19,'Esteban','Córdoba',DATE '1984-11-11','esteban.c@gmail.com');
INSERT INTO clientes VALUES (20,'Manuela','Reyes',DATE '2001-03-03','manuela.r@gmail.com');
INSERT INTO clientes VALUES (21,'Cristian','Arias',DATE '1990-05-05','cristian.a@gmail.com');
INSERT INTO clientes VALUES (22,'Angélica','Peña',DATE '1993-01-15','angelica.p@gmail.com');
INSERT INTO clientes VALUES (23,'Jorge','Silva',DATE '1982-06-06','jorge.s@gmail.com');
INSERT INTO clientes VALUES (24,'Tatiana','Parra',DATE '1995-12-20','tatiana.p@gmail.com');
INSERT INTO clientes VALUES (25,'David','Gómez',DATE '1988-09-01','david.g@gmail.com');
INSERT INTO clientes VALUES (26,'Carolina','Jiménez',DATE '1996-04-04','carolina.j@gmail.com');
INSERT INTO clientes VALUES (27,'Kevin','Pardo',DATE '2000-07-15','kevin.p@gmail.com');
INSERT INTO clientes VALUES (28,'Alejandra','Acosta',DATE '1991-02-02','alejandra.a@gmail.com');
INSERT INTO clientes VALUES (29,'Mateo','León',DATE '1997-08-18','mateo.l@gmail.com');
INSERT INTO clientes VALUES (30,'Isabella','Cárdenas',DATE '2002-10-29','isabella.c@gmail.com');
-- CLIENTES SIN CUENTAS 
INSERT INTO clientes VALUES (31,'Brayan','Quintero',DATE '1998-05-14','brayan.q@gmail.com');
INSERT INTO clientes VALUES (32,'Yuliana','Salazar',DATE '1994-02-09','yuliana.s@gmail.com');
INSERT INTO clientes VALUES (33,'Harold','Mejía',DATE '1987-10-21','harold.m@gmail.com');
INSERT INTO clientes VALUES (34,'Diana','Velasco',DATE '1996-01-30','diana.v@gmail.com');
INSERT INTO clientes VALUES (35,'Mauricio','Bermúdez',DATE '1990-12-18','mauricio.b@gmail.com');

INSERT INTO cuentas VALUES (201,1500,101,'A');
INSERT INTO cuentas VALUES (202,800,102,'A');
INSERT INTO cuentas VALUES (203,450,103,'C');
INSERT INTO cuentas VALUES (204,2000,104,'A');
INSERT INTO cuentas VALUES (205,300,105,'C');
INSERT INTO cuentas VALUES (206,1200,106,'A');
INSERT INTO cuentas VALUES (207,700,107,'C');
INSERT INTO cuentas VALUES (208,950,108,'A');
INSERT INTO cuentas VALUES (209,400,109,'C');
INSERT INTO cuentas VALUES (210,5000,110,'A');
INSERT INTO cuentas VALUES (211,600,111,'C');
INSERT INTO cuentas VALUES (212,1800,112,'A');
INSERT INTO cuentas VALUES (213,250,113,'C');
INSERT INTO cuentas VALUES (214,2200,114,'A');
INSERT INTO cuentas VALUES (215,480,115,'C');
INSERT INTO cuentas VALUES (216,3000,116,'A');
INSERT INTO cuentas VALUES (217,350,117,'C');
INSERT INTO cuentas VALUES (218,900,118,'A');
INSERT INTO cuentas VALUES (219,150,119,'C');
INSERT INTO cuentas VALUES (220,4000,120,'A');
INSERT INTO cuentas VALUES (221,620,121,'C');
INSERT INTO cuentas VALUES (222,1100,122,'A');
INSERT INTO cuentas VALUES (223,275,123,'C');
INSERT INTO cuentas VALUES (224,2600,124,'A');
INSERT INTO cuentas VALUES (225,510,125,'C');
INSERT INTO cuentas VALUES (226,1750,126,'A');
INSERT INTO cuentas VALUES (227,390,127,'C');
INSERT INTO cuentas VALUES (228,800,128,'A');
INSERT INTO cuentas VALUES (229,450,129,'C');
INSERT INTO cuentas VALUES (230,6000,130,'A');
-- Cuentas sin titulares
INSERT INTO cuentas VALUES (231, 750, 101, 'A');
INSERT INTO cuentas VALUES (232, 300, 102, 'C');
INSERT INTO cuentas VALUES (233, 5200, 103, 'A');
INSERT INTO cuentas VALUES (234, 410, 104, 'C');
INSERT INTO cuentas VALUES (235, 980, 105, 'A');

-- Clientes & Cuentas que NO TIENEN RELACION 
INSERT INTO clientes VALUES (36,'Kevin','Galindo',DATE '1993-03-11','kevin.g@gmail.com');
INSERT INTO clientes VALUES (37,'Paola','Montoya',DATE '1989-07-22','paola.m@gmail.com');
INSERT INTO clientes VALUES (38,'Cristopher','Luna',DATE '1995-09-05','cristopher.l@gmail.com');
INSERT INTO clientes VALUES (39,'Angie','Cardona',DATE '2001-04-17','angie.c@gmail.com');
INSERT INTO clientes VALUES (40,'Jhonatan','Nieto',DATE '1992-06-28','jhonatan.n@gmail.com');
INSERT INTO cuentas VALUES (236, 1400, 106, 'A');
INSERT INTO cuentas VALUES (237, 260, 107, 'C');
INSERT INTO cuentas VALUES (238, 3300, 108, 'A');
INSERT INTO cuentas VALUES (239, 480, 109, 'C');
INSERT INTO cuentas VALUES (240, 7200, 110, 'A');

INSERT INTO titulares VALUES (1,201);
INSERT INTO titulares VALUES (1,231);
INSERT INTO titulares VALUES (1,235);
INSERT INTO titulares VALUES (2,202);
INSERT INTO titulares VALUES (3,203);
INSERT INTO titulares VALUES (4,204);
INSERT INTO titulares VALUES (5,205);
INSERT INTO titulares VALUES (6,206);
INSERT INTO titulares VALUES (7,207);
INSERT INTO titulares VALUES (8,208);
INSERT INTO titulares VALUES (9,209);
INSERT INTO titulares VALUES (10,210);
INSERT INTO titulares VALUES (11,211);
INSERT INTO titulares VALUES (12,212);
INSERT INTO titulares VALUES (13,213);
INSERT INTO titulares VALUES (14,214);
INSERT INTO titulares VALUES (15,215);
INSERT INTO titulares VALUES (16,216);
INSERT INTO titulares VALUES (17,217);
INSERT INTO titulares VALUES (18,218);
INSERT INTO titulares VALUES (19,219);
INSERT INTO titulares VALUES (20,220);
INSERT INTO titulares VALUES (21,221);
INSERT INTO titulares VALUES (22,222);
INSERT INTO titulares VALUES (23,223);
INSERT INTO titulares VALUES (24,224);
INSERT INTO titulares VALUES (25,225);
INSERT INTO titulares VALUES (26,226);
INSERT INTO titulares VALUES (27,227);
INSERT INTO titulares VALUES (28,228);
INSERT INTO titulares VALUES (29,229);
INSERT INTO titulares VALUES (30,230);

COMMIT; 

-- QUERIES:

    -- Query 1:
    
    SELECT TO_CHAR(NVL(C.codigo, 0)) "Código cliente", 
            NVL(C.nombre, 0) || ' ' || NVL(C.apellido, '') "Nombre completo", 
            TO_CHAR(NVL(CU.numero, 0)) "Número cuenta", 
            NVL(CU.tipo, 0) Tipo, 
            TO_CHAR(NVL(CU.SALDO, 0)) Saldo 

    FROM clientes C 
    -- Es preferible el join sobre el producto cartesiano
        LEFT JOIN titulares T 
            ON C.CODIGO = T.CODIGO_CLIENTE
        LEFT JOIN cuentas CU
            ON CU.NUMERO = T.NUMERO_CUENTA
    
        -- Acá hago un union para que me salga el conteo y un all para que 
        -- salgan todos los registros completos
        UNION ALL 
    
    SELECT 
        'TOTAL',
        --                       || Este cosito es para sumar strings
        COUNT(DISTINCT C.codigo) || ' clientes',
        '-',
        '-',
        TO_CHAR(SUM(CU.saldo))

    FROM clientes C
        LEFT JOIN titulares T 
            ON C.codigo = T.codigo_cliente
        LEFT JOIN cuentas CU
            ON CU.numero = T.numero_cuenta;

    --Query 2:

    SELECT TO_CHAR(NVL(CU.numero, 0)) "Número cuenta", 
            NVL(CU.tipo, 0) "Tipo", 
            NVL(CU.saldo, 0) "Saldo", 
            NVL(C.nombre, 0) || ' ' || NVL(C.apellido, '') "Cliente Titular"
    FROM CUENTAS CU
        LEFT JOIN TITULARES T
            ON CU.numero = T.numero_cuenta
        LEFT JOIN CLIENTES C
            ON C.codigo = T.codigo_cliente

        UNION ALL

    SELECT 'TOTAL',
            '-',
            SUM(CU.saldo),
            COUNT(CU.NUMERO) || ' cuentas'
    FROM CUENTAS CU
        LEFT JOIN TITULARES T
            ON CU.numero = T.numero_cuenta
        LEFT JOIN CLIENTES C
            ON C.codigo = T.codigo_cliente;


    --Query 3:

    SELECT TO_CHAR(NVL(C.codigo, 0)) "Código cliente",
            NVL(C.nombre, 0) || ' ' || NVL(C.apellido, '') "Nombre completo",
            TO_CHAR(NVL(CU.numero, 0)) "Número cuenta",
            NVL(CU.tipo, 0) "Tipo",
            NVL(CU.saldo, 0) "Saldo"
    
    FROM CUENTAS CU
        FULL JOIN TITULARES T
            ON CU.NUMERO = T.NUMERO_CUENTA
        FULL JOIN CLIENTES C
            ON C.CODIGO = T.CODIGO_CLIENTE
    
        UNION ALL
    
    SELECT 'Total',
            COUNT(C.codigo) || ' clientes',
            COUNT(CU.numero) || ' cuentas',
            '-',
            SUM(CU.saldo)

    FROM CUENTAS CU
        FULL JOIN TITULARES T
            ON CU.NUMERO = T.NUMERO_CUENTA
        FULL JOIN CLIENTES C
            ON C.CODIGO = T.CODIGO_CLIENTE;


    --Query 4:

    SELECT TO_CHAR(NVL(O.codigo, 0)) "Código oficina", 
            NVL(O.nombre, 0) "Nombre oficina", 
            NVL(O.barrio, 0) "Barrio oficina", 
            TO_CHAR(NVL(Cu.numero, 0)) "Número cuenta", 
            TO_CHAR(NVL(Cu.saldo, 0)) "Saldo cuenta"

    FROM cuentas Cu
        RIGHT JOIN oficinas O 
            ON O.codigo = Cu.codigo_oficina

    UNION ALL

    SELECT 'TOTAL', 
            TO_CHAR(COUNT(DISTINCT o.codigo) || ' oficinas'), 
            '-', 
            '-', 
            TO_CHAR(SUM(Cu.saldo))

    FROM cuentas Cu
        RIGHT JOIN oficinas O 
            ON O.codigo = Cu.codigo_oficina;

    --Query 5:

    SELECT TO_CHAR(NVL(Ci.codigo, 0)) "Codigo cliente", 
            Ci.nombre || ' ' || Ci.apellido "Nombre completo", 
            TO_CHAR(NVL(Cu.numero, 0)) "Numero de cuenta", 
            NVL(Cu.tipo, 0) "Tipo de cuenta"
    FROM clientes Ci
        FULL JOIN titulares T 
            ON Ci.codigo = T.codigo_cliente
        FULL JOIN cuentas Cu 
            ON Cu.numero = T.numero_cuenta

    UNION ALL

    SELECT 'TOTAL', 
            COUNT(DISTINCT T.codigo_cliente) || ' ' || 'clientes', 
            COUNT(DISTINCT T.numero_cuenta) || ' ' || 'cuentas', 
            '-'
    FROM clientes Ci
        FULL JOIN titulares T 
            ON Ci.codigo = T.codigo_cliente
        FULL JOIN cuentas Cu 
            ON Cu.numero = T.numero_cuenta;


    -- Query 6:
    --La view está arribita

    SELECT TO_CHAR(codigo) "Codigo Cliente", nombre_completo "Nombre completo", TO_CHAR(cantidad_cuentas) "Cantidad de cuentas"
    FROM CuentasXCliente

    UNION ALL

    SELECT 'TOTAL', COUNT(codigo) || ' ' || 'clientes', SUM(cantidad_cuentas) || ' ' || 'cuentas'
    FROM CuentasXCliente;

COMMIT;