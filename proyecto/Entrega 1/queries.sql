--cambio de prueba

CREATE VIEW DATOS AS (
    SELECT
        P.NOMBRE_PAIS "PAÍS",
        C.NOMBRE_CIUDAD "CIUDAD",
        E.NOMBRE_ESTADIO "ESTADIO",
        PA.FECHA "FECHA",
        PA.FASE "FASE",
        SL.ID "ID_LOCAL",
        SV.ID "ID_VISITANTE",
        PA.GOLES_LOCAL "GOLES L",
        PA.GOLES_VISITANTE "GOLES V"

    FROM PAIS P 
        LEFT OUTER JOIN CIUDAD C 
            ON C.ID_PAIS = P.ID
        
        LEFT OUTER JOIN ESTADIO E 
            ON E.ID_CIUDAD = C.ID
        
        LEFT OUTER JOIN PARTIDO PA
            ON PA.ID_ESTADIO = E.ID

        LEFT OUTER JOIN SELECCION SL
            ON SL.ID = PA.ID_SELECCION_LOCAL
            
        LEFT OUTER JOIN SELECCION SV
            ON SV.ID = PA.ID_SELECCION_VISITANTE
);

--1 QUERY
--1: Listado de partidos según el orden de la tabla

SELECT 
    "PAÍS",
    "CIUDAD",
    "ESTADIO",
    "FECHA",
    "FASE",
    "GOLES L",
    "GOLES V"
FROM DATOS
ORDER BY "PAÍS", "CIUDAD", "ESTADIO", "FECHA";


-- 2 QUERY
-- 2: Cuantos partidos se han jugado en cada estadio por ciudad

SELECT
    C.NOMBRE_CIUDAD CIUDAD,
    E.NOMBRE_ESTADIO ESTADIO,
    COUNT(*) "NÚMERO DE PARTIDOS"

FROM CIUDAD C
    LEFT OUTER JOIN ESTADIO E
    ON C.ID = E.ID_CIUDAD

    LEFT OUTER JOIN PARTIDO P
    ON E.ID = P.ID_ESTADIO

GROUP BY C.NOMBRE_CIUDAD, E.NOMBRE_ESTADIO;

-- 3 QUERY 
-- 3: cuantos goles totales ha anotado cada seleccion en todo el torneo
-- (TENER EN CUENTA GOLES LOCAL Y VISITANTE) HACERLO COMO LA TABLA

WITH A AS
(
    SELECT 
        S.NOMBRE_SELECCION NLOCAL,
        NVL(SUM(P.GOLES_LOCAL), 0) SLOCAL

    FROM SELECCION S
        LEFT OUTER JOIN PARTIDO P
        ON S.ID = P.ID_SELECCION_LOCAL

    GROUP BY S.NOMBRE_SELECCION
),

B AS 
(
    SELECT 
        S.NOMBRE_SELECCION NVISITANTE,
        NVL(SUM(P.GOLES_VISITANTE), 0) SVISITANTE

    FROM SELECCION S
        LEFT OUTER JOIN PARTIDO P
        ON S.ID = P.ID_SELECCION_VISITANTE

    GROUP BY S.NOMBRE_SELECCION
)

(
    SELECT 
        A.NLOCAL "Selección",
        A.SLOCAL + B.SVISITANTE "Total goles"

    FROM A
        INNER JOIN B
        ON A.NLOCAL = B.NVISITANTE
)
    UNION ALL
(
    SELECT 
        'TOTAL',
        NVL(SUM(GOLES_LOCAL + GOLES_VISITANTE), 0)
    FROM PARTIDO
);


-- 4 QUERY 
SELECT p.NOMBRE_PAIS "NOMBRE PAÍS",
    TOTAL.ANIO AS "AÑO",
    TOTAL.MES,
    NVL(TOTAL, 0) AS "TOTAL GOLES"
FROM PAIS p 
    LEFT JOIN CIUDAD c ON c.ID_PAIS = p.ID 
    LEFT JOIN(
        SELECT e.ID_CIUDAD,
            SUM(a.GOLES_LOCAL + a.GOLES_VISITANTE) TOTAL,
            EXTRACT(YEAR FROM a.FECHA) ANIO,
            EXTRACT(MONTH FROM a.FECHA) MES
        FROM ESTADIO e
            JOIN PARTIDO a ON a.ID_ESTADIO = e.ID
        GROUP BY e.ID_CIUDAD,
            EXTRACT(YEAR FROM a.FECHA), 
            EXTRACT(MONTH FROM a.FECHA))
        TOTAL ON TOTAL.ID_CIUDAD = c.ID
    GROUP BY p.NOMBRE_PAIS, TOTAL, ANIO, MES
    ORDER BY p.NOMBRE_PAIS;


-- 5 QUERY
 -- goles totales 

SELECT 
    s.NOMBRE_SELECCION "Selección",
    SUM(l.goles) AS "Goles",
    (
        SELECT SUM(GOLES_VISITANTE + GOLES_LOCAL)
        FROM PARTIDO
    ) AS "Total General",
    TO_CHAR(
        ROUND(
            SUM(l.goles) * 100 / 
                (
                    SELECT SUM(GOLES_VISITANTE + GOLES_VISITANTE)
                    FROM PARTIDO
                ), 2
        )
    ) || '%' AS " % Participación"
FROM
(
    SELECT 
        ID_SELECCION_LOCAL AS id_loc, 
        GOLES_LOCAL AS goles
    FROM PARTIDO

    UNION ALL 

    SELECT 
        ID_SELECCION_VISITANTE, 
        GOLES_VISITANTE AS "goles"
    FROM PARTIDO 
) l
JOIN SELECCION s ON s.ID = l.id_loc
GROUP BY s.NOMBRE_SELECCION
ORDER BY SUM(l.goles) DESC;




-- TODAS LAS QUERIES, MIRA EL DOCS --
--6: que selecciones han jugado en todas las ciudades
--7: Cuantos goles ha anotado cada confederacion
--8: Realice al tabla exacta del DOCS :)