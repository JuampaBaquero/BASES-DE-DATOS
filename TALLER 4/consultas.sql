--Query 1:

SELECT cu.numero_cuenta CUENTA, 
        SUM(
            CASE
                WHEN m.tipo IN ('R', 'D') THEN m.valor
                WHEN m.tipo IN ('I', 'C') THEN -m.valor
            END
        ) SALDO,
        COUNT(T.codigo_cliente) "Cantidad titulares",
        o.nombre Oficina

FROM CUENTAS cu
    INNER JOIN MOVIMIENTOS m
        ON m.numero_cuenta = cu.numero_cuenta

    INNER JOIN TITULARES t
        ON t.numero_cuenta = cu.numero_cuenta

    INNER JOIN OFICINAS o
        ON o.codigo_oficina = cu.codigo_oficina

GROUP BY cu.numero_cuenta, o.nombre;
