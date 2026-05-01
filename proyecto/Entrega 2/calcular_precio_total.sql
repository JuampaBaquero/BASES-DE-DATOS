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

    RETURN base_precio + total_servicios;

END PRECIO_TOTAL;
/

SELECT PRECIO_TOTAL(1)
FROM DUAL;

