--Desarrollado por:
--Juan Pablo Baquero Velandia
--Sofia Mora Calderon
--Fabian Eduardo Sanchez Borda


--Drops
DROP TABLE CLIENTES CASCADE CONSTRAINTS;
DROP TABLE CUENTAS CASCADE CONSTRAINTS;
DROP TABLE MOVIMIENTOS CASCADE CONSTRAINTS;
DROP TABLE OFICINAS CASCADE CONSTRAINTS;
DROP TABLE TITULARES CASCADE CONSTRAINTS;


--Creación de tablas
CREATE TABLE CLIENTES
(
    codigo_cliente number(3,0),
    nombre varchar2(60),
    apellido varchar2(60),
    fecha_nacimiento date,
    fecha_vinculacion date,
    email varchar2(60),
    genero char(1),
    PRIMARY KEY (codigo_cliente)
);

CREATE TABLE OFICINAS
(
    codigo_oficina number (3,0),
    nombre varchar2(60),
    PRIMARY KEY(codigo_oficina)
);


CREATE TABLE CUENTAS
(
    numero_cuenta number(3,0),
    tipo char(1),
    codigo_oficina  number (3,0),
    valor_apertura number(12,2),
    CONSTRAINT ch_tipo CHECK (
        tipo = 'C' OR 
        tipo = 'A'
        ),
    FOREIGN KEY (codigo_oficina) REFERENCES OFICINAS,
    PRIMARY KEY (numero_cuenta)
);


CREATE TABLE TITULARES
(
    codigo_cliente number(3,0),
    numero_cuenta number(3,0), 
    porcentaje_titularidad number(3,0),
    FOREIGN KEY (codigo_cliente) REFERENCES CLIENTES,
    FOREIGN KEY (numero_cuenta) REFERENCES CUENTAS,
    PRIMARY KEY (codigo_cliente, numero_cuenta)
);

CREATE TABLE MOVIMIENTOS
(
    numero_cuenta number(3,0),
    numero number(3,0),
    tipo char(1),  --Los posibles valores son D, C,I,R .DONDE D SON DÉBITOS, C SON CRÉDITOS, I SON IMPUESTOS, R RENDIMIENTOS
    valor number(10,2),
    fecha_movimiento date,
    CONSTRAINT ch_tipo_movimiento CHECK(
        tipo = 'D' OR -- débitos
        tipo = 'C' OR -- créditos
        tipo = 'I' OR -- impuestos
        tipo = 'R'    -- rendimientos
    ),
    FOREIGN KEY (numero_cuenta) REFERENCES CUENTAS,
    PRIMARY KEY (numero_cuenta, numero)
);

--Chavales el taller dice que toca hacer unos ingresos bien específicos, así que toca
--como nos dijo Sofía. . . A manito. . .


--Clientes
INSERT INTO CLIENTES VALUES (1, 'Pedro', 'Perez',       TO_DATE('18-01-1980', 'DD-MM-YYYY'), TO_DATE('18-01-1990', 'DD-MM-YYYY'), NULL, 'M');
INSERT INTO CLIENTES VALUES (2, 'María', 'Restrepo',    TO_DATE('18-02-1970', 'DD-MM-YYYY'), TO_DATE('18-02-1990', 'DD-MM-YYYY'), NULL, 'F');
INSERT INTO CLIENTES VALUES (3, 'Juana', 'Arias',       TO_DATE('18-03-1990', 'DD-MM-YYYY'), TO_DATE('18-03-1990', 'DD-MM-YYYY'), NULL, 'F');
INSERT INTO CLIENTES VALUES (4, 'Carlos', 'Lozano',     TO_DATE('18-04-2000', 'DD-MM-YYYY'), TO_DATE('18-04-2000', 'DD-MM-YYYY'), NULL, 'M');
INSERT INTO CLIENTES VALUES (5, 'Esteban', 'Gonzalez',  TO_DATE('18-02-2001', 'DD-MM-YYYY'), TO_DATE('18-02-2001', 'DD-MM-YYYY'), NULL, 'M');
INSERT INTO CLIENTES VALUES (6, 'John', 'Hurtado',      TO_DATE('20-02-1970', 'DD-MM-YYYY'), TO_DATE('20-02-1990', 'DD-MM-YYYY'), NULL, 'M');
INSERT INTO CLIENTES VALUES (7, 'Juana', 'Perez',       TO_DATE('08-08-1950', 'DD-MM-YYYY'), TO_DATE('08-08-1990', 'DD-MM-YYYY'), NULL, 'F');

--Oficinas
INSERT INTO OFICINAS VALUES(10, 'Javeriana');
INSERT INTO OFICINAS VALUES(20, 'Galerias');
INSERT INTO OFICINAS VALUES(30, 'Portal 80');
INSERT INTO OFICINAS VALUES(40, 'Teusaquillo');

--Cuentas
INSERT INTO CUENTAS VALUES(100, 'A', 10, 0);
INSERT INTO CUENTAS VALUES(200, 'A', 20, 100);
INSERT INTO CUENTAS VALUES(300, 'C', 10, 500);
INSERT INTO CUENTAS VALUES(400, 'C', 10, 1000);
INSERT INTO CUENTAS VALUES(500, 'A', 10, 100);
INSERT INTO CUENTAS VALUES(600, 'A', 20, 50);

--Movimientos
INSERT INTO MOVIMIENTOS VALUES(100, 1, 'D', 10000,  TO_DATE('01-01-2000 10:00:23', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTOS VALUES(100, 2, 'D', 25000,  TO_DATE('01-02-2000 10:05:23', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTOS VALUES(100, 3, 'C', 5000,   TO_DATE('01-02-2000 10:10:23', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTOS VALUES(400, 1, 'D', 58000,  TO_DATE('01-02-2000 10:15:23', 'DD-MM-YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTOS VALUES(400, 2, 'I', 2500,   TO_DATE('01-01-2000 10:16:23', 'DD-MM-YYYY HH24:MI:SS'));

--Titulares
INSERT INTO TITULARES VALUES(1, 100, 60);
INSERT INTO TITULARES VALUES(1, 200, 40);
INSERT INTO TITULARES VALUES(2, 100, 40);
INSERT INTO TITULARES VALUES(2, 200, 60);
INSERT INTO TITULARES VALUES(3, 300, 100);
INSERT INTO TITULARES VALUES(4, 400, 100);
INSERT INTO TITULARES VALUES(5, 500, 100);
INSERT INTO TITULARES VALUES(6, 600, 100);

COMMIT;

--Query 1
/*El saldo de cada cuenta es calculado debe ser calculado así: Sume los débitos y rendimientos financieros
y reste los créditos y los impuestos. A este valor súmele el valor de apertura. Muestre un listado de la
siguiente forma. Las oficinas sin cuentas deben salir en las respuestas.*/
SELECT 
    cu.numero_cuenta "NUMERO CUENTA",

    NVL(
        (SELECT SUM(valor)
         FROM MOVIMIENTOS m
         WHERE m.numero_cuenta = cu.numero_cuenta
         AND m.tipo IN ('R','D')
        ),0)
    -
    NVL(
        (SELECT SUM(valor)
         FROM MOVIMIENTOS m
         WHERE m.numero_cuenta = cu.numero_cuenta
         AND m.tipo IN ('I','C')
        ),0) SALDO,
    (
        SELECT COUNT(*)
        FROM TITULARES t
        WHERE t.numero_cuenta = cu.numero_cuenta
    ) "CANTIDAD TITULARES",
    o.nombre OFICINA

FROM CUENTAS cu
    INNER JOIN OFICINAS o
        ON o.codigo_oficina = cu.codigo_oficina
ORDER BY cu.numero_cuenta;

--Query 2
/*Muestre un listado de la forma. Deben salir todas las oficinas independiente que no tengan datos: (No se
fije en los datos) . Utilice sintaxis de Join, es decir no debe tener comas (,) en sus sentencias from.*/

WITH DATOS AS (
    SELECT 
        o.codigo_oficina,
        o.nombre nombre_oficina,
        m.tipo,
        m.valor,
        m.numero,
        m.fecha_movimiento,
        c.genero,
        c.codigo_cliente
    FROM OFICINAS o

        LEFT JOIN CUENTAS cu
            ON cu.codigo_oficina = o.codigo_oficina

        LEFT JOIN MOVIMIENTOS m
            ON m.numero_cuenta = cu.numero_cuenta

        LEFT JOIN TITULARES t
            ON t.numero_cuenta = cu.numero_cuenta

        LEFT JOIN CLIENTES c
            ON c.codigo_cliente = t.codigo_cliente
)

SELECT
    o.nombre "OFICINA",

    (
        SELECT COUNT(DISTINCT d.codigo_cliente)
        FROM DATOS d
        WHERE d.codigo_oficina = o.codigo_oficina
        AND d.genero = 'M'
    ) "NÚMERO DE CLIENTES HOMBRES",

    (
        SELECT COUNT(DISTINCT d.codigo_cliente)
        FROM DATOS d
        WHERE d.codigo_oficina = o.codigo_oficina
        AND d.genero = 'F'
    ) "NÚMERO DE CLIENTES MUJERES",
    NVL(
    (
        SELECT AVG(
            (SELECT SUM(d1.valor)
             FROM DATOS d1
             WHERE d1.codigo_oficina = o.codigo_oficina
             AND d1.genero='F'
             AND d1.tipo IN ('R','D'))
            -
            (SELECT SUM(d2.valor)
             FROM DATOS d2
             WHERE d2.codigo_oficina = o.codigo_oficina
             AND d2.genero='F'
             AND d2.tipo IN ('I','C'))
        )
        FROM DATOS
    ), 0) "PROMEDIO SALDOS MUJERES",

    NVL(
    (
        SELECT AVG(
            (SELECT SUM(d1.valor)
             FROM DATOS d1
             WHERE d1.codigo_oficina = o.codigo_oficina
             AND d1.genero='M'
             AND d1.tipo IN ('R','D'))
            -
            (SELECT SUM(d2.valor)
             FROM DATOS d2
             WHERE d2.codigo_oficina = o.codigo_oficina
             AND d2.genero='M'
             AND d2.tipo IN ('I','C'))
        )
        FROM DATOS
    ), 0) "PROMEDIO SALDOS HOMBRES",

    (
        SELECT MAX(d.fecha_movimiento)
        FROM DATOS d
        WHERE d.codigo_oficina = o.codigo_oficina
    ) "FECHA ÚLTIMO MOVIMIENTO",

    (
        SELECT MIN(d.fecha_movimiento)
        FROM DATOS d
        WHERE d.codigo_oficina = o.codigo_oficina
    ) "FECHA PRIMER MOVIMIENTO",

    (
        SELECT COUNT(DISTINCT d.numero)
        FROM DATOS d
    ) "CANTIDAD HISTÓRICA DE MOVIMIENTOS"

FROM OFICINAS o

ORDER BY o.nombre;
    
--query 3
/*Muestre un listado de la forma. Utilice sintaxis de Join, es decir no debe tener comas (,) en sus sentencias
from*/
SELECT 
    ci.NOMBRE || ' ' || ci.APELLIDO "CLIENTE",
    --cuentas con 100
    (SELECT COUNT(DISTINCT t.PORCENTAJE_TITULARIDAD)
    FROM TITULARES t
    WHERE t.PORCENTAJE_TITULARIDAD = 100 
        AND
        t.CODIGO_CLIENTE = ci.CODIGO_CLIENTE) 
    "Numero de Cuentas con un porcentaje del 100",
    (SELECT COUNT(DISTINCT t.PORCENTAJE_TITULARIDAD)
    FROM TITULARES t
    WHERE t.PORCENTAJE_TITULARIDAD != 100 
        AND
        t.CODIGO_CLIENTE = ci.CODIGO_CLIENTE)  "Numero de Cuentas con un porcentaje diferente al 100",
    TO_CHAR((
        SELECT MIN(m.FECHA_MOVIMIENTO)
        FROM MOVIMIENTOS m
        JOIN TITULARES t ON t.NUMERO_CUENTA = m.NUMERO_CUENTA
        WHERE t.CODIGO_CLIENTE = ci.CODIGO_CLIENTE), 'DD/MM/YYYY HH24:MI:SS') "Fecha Primer Movimiento",--min porque en las fechas debe ser la primera, tonces el menor
    NVL((
        SELECT COUNT(m.NUMERO)
        FROM MOVIMIENTOS m
        JOIN TITULARES t ON t.NUMERO_CUENTA = m.NUMERO_CUENTA
        WHERE t.CODIGO_CLIENTE = ci.CODIGO_CLIENTE
    ), 0) "Cantidad Movimientos",
    NVL((
        SELECT SUM(m.VALOR)
        FROM MOVIMIENTOS m
        JOIN TITULARES t ON t.NUMERO_CUENTA = m.NUMERO_CUENTA
        WHERE t.CODIGO_CLIENTE = ci.CODIGO_CLIENTE 
        AND m.tipo = 'D'
    ), 0) "Valor Movimientos Débitos de todas las cuentas",--Debito
    NVL((
        SELECT SUM(m.VALOR)
        FROM MOVIMIENTOS m
        JOIN TITULARES t ON t.NUMERO_CUENTA = m.NUMERO_CUENTA
        WHERE t.CODIGO_CLIENTE = ci.CODIGO_CLIENTE 
        AND m.tipo = 'C'
    ), 0) "Valor Movimienrtos Créditos de todas las cuentas",--Credito
    NVL((
        SELECT SUM(m.VALOR)
        FROM MOVIMIENTOS m
        JOIN TITULARES t ON t.NUMERO_CUENTA = m.NUMERO_CUENTA
        WHERE t.CODIGO_CLIENTE = ci.CODIGO_CLIENTE 
        AND m.tipo = 'I'
    ), 0) "Valor Movimientos Tipo Impuesto de todas las cuentas", --Impuesto
    NVL((
        SELECT SUM(m.VALOR)
        FROM MOVIMIENTOS m
        JOIN TITULARES t ON t.NUMERO_CUENTA = m.NUMERO_CUENTA
        WHERE t.CODIGO_CLIENTE = ci.CODIGO_CLIENTE 
        AND m.tipo = 'R'
    ), 0) "Valor movimientos tipo rendimientos de todas las cuentas" --Rendimiento
FROM CLIENTES ci
ORDER BY ci.CODIGO_CLIENTE;

--Query 4
/*Con una sentencia alter agregue un campo llamado saldo en la tabla cuenta y posteriormente mediante una
única sentencia actualice el campo saldo de la tabla cuentas de acuerdo a los movimientos de esa cuenta,
sume los débitos y rendimientos financieros y reste los créditos y los impuestos. A este valor súmele el valor de
apertura. Si no tiene movimientos debe quedar en cero.*/
ALTER TABLE CUENTAS ADD saldo number(12,2);
UPDATE CUENTAS cu
SET cu.saldo = NVL(
    (SELECT SUM(valor)
     FROM MOVIMIENTOS m
     WHERE m.numero_cuenta = cu.numero_cuenta
     AND m.tipo IN ('R','D')
    ),0)
    -
    NVL( 
    (SELECT SUM(valor)
     FROM MOVIMIENTOS m
     WHERE m.numero_cuenta = cu.numero_cuenta
     AND m.tipo IN ('I','C')
    ),0)
    + cu.valor_apertura; 
