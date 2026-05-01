CREATE OR REPLACE FUNCTION PRECIO_TOTAL(
    id_busqueda NUMBER
) 
RETURN NUMBER AS
    interes_local NUMBER;
    impuestos_servicios NUMBER;
    base_precio NUMBER;

BEGIN 
    
    SELECT precio_base
    INTO base_precio
    FROM EXPERIENCIA e
    WHERE id_experiencia = id_busqueda; 

    --Para actualizar el impuesto por paíz
    SELECT base_precio * ( 1 + SUM(pa.iva) + SUM(c.impuesto_local) ) 
    INTO interes_local
    FROM pais pa 
    INNER JOIN ciudad ci ON ci.id_pais = pa.id_pais
    INNER JOIN estadio e ON e.id_ciudad = ci.id_ciudad
    INNER JOIN partido p ON p.id_estadio = e.id_estadio
    WHERE p.id_experiencia = id_busqueda;

    --Para actualizar el impuesto por los servicios
    SELECT SUM(s.costo_adicional * sxi.cantidad * i.valor) 
    INTO interes_servicio
    FROM impuesto i
    INNER JOIN servicio s ON s.id_impuesto = i.id_impuesto
    INNER JOIN ServicioXExperiencia sxi ON sxi.id_servicio = s.id_servicio
    WHERE sxi.id_experiencia = id_busqueda;
    
    RETURN interes_local + interes_servicio;

END PRECIO_TOTAL;
/

SELECT PRECIO_TOTAL(1)
FROM DUAL;

