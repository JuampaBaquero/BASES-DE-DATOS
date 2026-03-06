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

SELECT 
    



