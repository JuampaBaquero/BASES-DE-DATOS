--QUERIES 

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

    ORDER BY 
        "País" DESC, 
        "Ciudad" DESC;

--2: Muestra los clientes con mayor número de inscripciones
SELECT 
    c.nombre "Cliente",
    COUNT(*) "Número de inscripciones"

FROM INSCRIPCION i
INNER JOIN CLIENTE c ON c.id_cliente = i.id_cliente
GROUP BY c.nombre;

--3: Muestra los ingresos generados por guía en las experiencias

SELECT  g.nombre, 
SUM(e.horas_trabajadas * n.valorxhora) AS "Ingresos por guía"
FROM GUIA g
INNER JOIN nivel n ON g.ID_NIVEL = n.ID_NIVEL
INNER JOIN EXPERIENCIA e ON g.ID_GUIA = e.ID_EXPERIENCIA
GROUP BY g.ID_GUIA, g.NOMBRE
ORDER BY "Ingresos por guía" ASC; 

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
    c.nombre "Nombre",
    i.id_experiencia "ID experiencia",
    ROUND(PRECIO_TOTAL(i.id_experiencia), 2) AS "Precio con impuestos"
FROM CLIENTE c
INNER JOIN inscripcion i ON i.id_cliente = c.id_cliente;

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
    SUM(PRECIO_TOTAL(i.id_experiencia)) AS "Ganancias generadas (con impuestos)"
FROM pais p
INNER JOIN ciudad c ON c.id_pais = p.id_pais
INNER JOIN estadio e ON e.id_ciudad = c.id_ciudad
INNER JOIN partido pa ON pa.id_estadio = e.id_estadio
INNER JOIN experiencia ex ON pa.id_experiencia = ex.id_experiencia
INNER JOIN inscripcion i ON i.id_experiencia = ex.id_experiencia 
WHERE p.nombre_pais IN ('México', 'Canadá', 'EE.UU.')
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
WHERE sl.nombre_seleccion = 'Portugal' 
  AND sv.nombre_seleccion = 'Colombia'
GROUP BY ex.id_experiencia, ex.cupos;