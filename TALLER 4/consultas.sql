--Query 1
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