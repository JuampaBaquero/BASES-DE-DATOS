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

--Debería hacer una vista temporal para obtener cosas

WITH GENEROXOFICINA AS(
    SELECT 
        o.nombre NOMBRE_OFICINA,
        c.genero GENERO,
        m.valor VALOR


    FROM OFICINAS o

        LEFT JOIN CUENTAS cu
            ON cu.codigo_oficina = o.codigo_oficina

        INNER JOIN MOVIMIENTOS m
            ON m.numero_cuenta = cu.numero_cuenta
        
        INNER JOIN TITULARES t
            ON t.numero_cuenta = cu.numero_cuenta

        INNER JOIN CLIENTES c
            ON t.codigo_cliente = c.codigo_cliente
    GROUP BY c.genero, m.valor
)
    
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