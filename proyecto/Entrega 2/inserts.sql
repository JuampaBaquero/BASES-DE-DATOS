--PAIS
    --América

INSERT INTO PAIS VALUES('PERU',201, 0.8);
INSERT INTO PAIS VALUES('COLOMBÍA', 202, 0.8);
INSERT INTO PAIS VALUES('MEXICO',203, 0.8); 
INSERT INTO PAIS VALUES('BRASIL',204, 0.10);
INSERT INTO PAIS VALUES('ARGENTINA',205, 0.10); 
    --Oceania 
INSERT INTO PAIS VALUES('AUSTRALIA',206, 0.101);
    --Europa
INSERT INTO PAIS VALUES('PORTUGAL',207, 0.14); 
INSERT INTO PAIS VALUES('ESPAÑA',208, 0.13);
INSERT INTO PAIS VALUES('ALEMANIA',209, 0.14); 
INSERT INTO PAIS VALUES('FRANCIA',210, 0.15);
    -- Asía 
INSERT INTO PAIS VALUES('JAPÓN',211, 0.10); 
INSERT INTO PAIS VALUES('COREA DEL SUR',212, 0.10); 
INSERT INTO PAIS VALUES('ARABIA SAUDITA',213, 0.15); 


--CIUDAD
    --america
INSERT INTO CIUDAD VALUES('Lima', 201, 301, 0.2);
INSERT INTO CIUDAD VALUES('Bogota', 202, 302, 0.3);
INSERT INTO CIUDAD VALUES('Ciudad de Mexico', 203, 303, 0.4);
INSERT INTO CIUDAD VALUES('Sao Paulo', 204, 304, 0.5);
INSERT INTO CIUDAD VALUES('Buenos Aires', 205, 305, 0.4);
    --Oceania
INSERT INTO CIUDAD VALUES('Canberra', 206, 306, 0.6);    
    --Europa
INSERT INTO CIUDAD VALUES('Lisboa', 207, 307, 0.7);
INSERT INTO CIUDAD VALUES('Madrid', 208, 308, 0.10);
INSERT INTO CIUDAD VALUES('Berlín', 209, 309, 0.8);
INSERT INTO CIUDAD VALUES('París', 210, 310, 0.9);    
    --Asía
INSERT INTO CIUDAD VALUES('Tokío', 211, 311, 0.8);
INSERT INTO CIUDAD VALUES('Seúl', 212, 312, 0.8);
INSERT INTO CIUDAD VALUES('Riad', 213, 313, 0.12);


--ESTADIO
    --America
INSERT INTO ESTADIO VALUES('Estadio Nacional de Lima', 50000, 201, 101);
INSERT INTO ESTADIO VALUES('Estadio El Campín', 45000, 202, 102);
INSERT INTO ESTADIO VALUES('Estadio Azteca', 87000, 203, 103);
INSERT INTO ESTADIO VALUES('Arena Corinthians', 49000, 204, 104);
INSERT INTO ESTADIO VALUES('Estadio Monumental', 84000, 205, 105);
    --Oceania
INSERT INTO ESTADIO VALUES('Stadium Australia', 83500, 206, 106);
    --Europa
INSERT INTO ESTADIO VALUES('Estadio da Luz', 64000, 207, 107);
INSERT INTO ESTADIO VALUES('Estadio Santiago Bernabeu', 81000, 208, 108);
INSERT INTO ESTADIO VALUES('Olympiastadion Berlin', 74000, 209, 109);
INSERT INTO ESTADIO VALUES('Parc des Princes', 48000, 210, 1010);
    --Asia
INSERT INTO ESTADIO VALUES('Japan National Stadium', 68000, 211, 1011);
INSERT INTO ESTADIO VALUES('Seoul World Cup Stadium', 66000, 212, 1012);
INSERT INTO ESTADIO VALUES('King Fahd Stadium', 68000, 213, 1013);


--CONFEDERACION
INSERT INTO CONFEDERACION VALUES ('CONMEBOL', 1);
INSERT INTO CONFEDERACION VALUES('FIFA', 2);
INSERT INTO CONFEDERACION VALUES('KFC', 3);
INSERT INTO CONFEDERACION VALUES('AFC', 4);

--SELECCION
    --CONMEBOL
INSERT INTO SELECCION (ID, NOMBRE_SELECCION, ID_CONFEDERACION) 
VALUES (204, 'BRASIL', 1); 
INSERT INTO SELECCION (ID, NOMBRE_SELECCION, ID_CONFEDERACION) 
VALUES (205, 'ARGENTINA', 1); 
INSERT INTO SELECCION (ID, NOMBRE_SELECCION, ID_CONFEDERACION) 
VALUES (203, 'MEXICO', 1);
INSERT INTO SELECCION (ID, NOMBRE_SELECCION, ID_CONFEDERACION) 
VALUES (202, 'COLOMBIA', 1);
INSERT INTO SELECCION (ID, NOMBRE_SELECCION, ID_CONFEDERACION) 
VALUES (201, 'PERU', 1);

    --FIFA
INSERT INTO SELECCION (ID, NOMBRE_SELECCION, ID_CONFEDERACION) 
VALUES (206, 'AUSTRALIA', 2);

    --KFC
INSERT INTO SELECCION (ID, NOMBRE_SELECCION, ID_CONFEDERACION) 
VALUES (207, 'PORTUGAL', 3);
INSERT INTO SELECCION (ID, NOMBRE_SELECCION, ID_CONFEDERACION) 
VALUES (208, 'ESPAÑA', 3);
INSERT INTO SELECCION (ID, NOMBRE_SELECCION, ID_CONFEDERACION) 
VALUES (209, 'ALEMANIA', 3);
INSERT INTO SELECCION (ID, NOMBRE_SELECCION, ID_CONFEDERACION) 
VALUES (210, 'FRANCIA', 3);

    --AFC
INSERT INTO SELECCION (ID, NOMBRE_SELECCION, ID_CONFEDERACION) 
VALUES (211, 'JAPON', 3);
INSERT INTO SELECCION (ID, NOMBRE_SELECCION, ID_CONFEDERACION) 
VALUES (212, 'COREA DEL SUR', 3);
INSERT INTO SELECCION (ID, NOMBRE_SELECCION, ID_CONFEDERACION) 
VALUES (213, 'ARABIA SAUDITA', 3);

--PARTIDO

--IMPUESTO
INSERT INTO impuesto VALUES (1001, 0.19, 'IVA');
INSERT INTO impuesto VALUES (1002, 0.006, 'ICA');
INSERT INTO impuesto VALUES (1003, 0.08, 'CONSUMO');
INSERT INTO impuesto VALUES (1004, 0.3, 'BEB_ENERGETICAS');
INSERT INTO impuesto VALUES (1005, 0.1, 'PLÁSTICO');

--SERVICIO
INSERT INTO SERVICIO VALUES(2001, 'Aire acondicionado', 'No se we, es un aire xd', 8000, 1002);
INSERT INTO SERVICIO VALUES(2002, 'Desayuno colombiano', 'Huevos revueltos, pan, chocolate y arepa', 20000, 1003);
INSERT INTO SERVICIO VALUES(2003, 'Transporte', 'Te llevamos y traemos del estadio. ¡¡Te esperamos!!', 50000, 1001);
INSERT INTO SERVICIO VALUES(2004, 'Habitaciones de Lujo', 'Nada como descansar despues de ver un buen partido', 180000);
INSERT INTO SERVICIO VALUES(2005, 'Coca cola', 'Barra libre de Coca Cola. (es infinita!!)', 25000, 1004);
INSERT INTO SERVICIO VALUES(2006, 'Foto Mundilista', 'Tomate fotos en tus estadios favoritos, y con algunos jugadores', 950000);

---NIVELES
INSERT INTO NIVEL VALUES('BASICO', 35000);
INSERT INTO NIVEL VALUES('INTERMEDIO', 70000);
INSERT INTO NIVEL VALUES('EXPERTO',100000);

--GUIA
INSERT INTO GUIA(id_guia, nombre, id_nivel) VALUES(401,'Diego Maradona','EXPERTO');
INSERT INTO GUIA(id_guia, nombre, id_nivel) VALUES(405,'Jackie Chan','EXPERTO');
INSERT INTO GUIA VALUES(402,'Ibai Llanos',401, 'BASICO');
INSERT INTO GUIA VALUES(403,'Mr. Bean',405, 'BASICO');
INSERT INTO GUIA VALUES(404,'Pibe Valderrama',405,'INTERMEDIO');
INSERT INTO GUIA VALUES(406,'Michael Jackson',401,'INTERMEDIO');


--CLIENTE
INSERT INTO CLIENTE (nombre, apellido, tipo_documento, id_cliente, numero_telefono, email)
VALUES ('Juan', 'Perez', 'CC', 1, 3191122880, 'juan.perez1@gmail.com');
INSERT INTO CLIENTE (nombre, apellido, tipo_documento, id_cliente, numero_telefono, email)
VALUES ('Maria', 'Gomez', 'CC', 2, 3102244556, 'maria.gomez2@gmail.com');
INSERT INTO CLIENTE (nombre, apellido, tipo_documento, id_cliente, numero_telefono, email)
VALUES ('Carlos', 'Ramirez', 'CC', 3, 3114488552, 'carlos.ramirez3@gmail.com');
INSERT INTO CLIENTE (nombre, apellido, tipo_documento, id_cliente, numero_telefono, email)
VALUES ('Laura', 'Martinez', 'TI', 4, 3011234567, 'laura.martinez@gmail.com');
INSERT INTO CLIENTE (nombre, apellido, tipo_documento, id_cliente, numero_telefono, email)
VALUES ('Andres', 'Torres', 'CC', 5, 4561253648, 'andres.torres@gmail.com');
INSERT INTO CLIENTE (nombre, apellido, tipo_documento, id_cliente, numero_telefono, email)
VALUES ('Maria', 'Lopez', 'CC', 6, 3156677889, 'maria.lopez@gmail.com');
INSERT INTO CLIENTE (nombre, apellido, tipo_documento, id_cliente, numero_telefono, email)
VALUES ('Diego', 'Hernandez', 'CC', 7, 3129988776, 'diego.hernandez@gmail.com');
INSERT INTO CLIENTE (nombre, apellido, tipo_documento, id_cliente, numero_telefono, email)
VALUES ('Valentina', 'Castro', 'TI', 8, 3012345678, 'valentina.castro@gmail.com');
INSERT INTO CLIENTE (nombre, apellido, tipo_documento, id_cliente, numero_telefono, email)
VALUES ('Sebastian', 'Morales', 'CC', 9, 3188765432, 'sebastian.morales@gmail.com');
INSERT INTO CLIENTE (nombre, apellido, tipo_documento, id_cliente, numero_telefono, email)
VALUES ('Sofia', 'Mora', 'CC', 10, 31823123, 'sofia.mora@gmail.com');

--EXPERIENCIA 
INSERT INTO EXPERIENCIA (id_experiencia, cupos_disponibles, descripcion, estado, precio_base, id_guia)
VALUES (1, 50, 'DESCRIPCION EXPERIENCIA 1', 'disponible', 100000, 401);
INSERT INTO EXPERIENCIA (id_experiencia, cupos_disponibles, descripcion, estado, precio_base, id_guia)
VALUES (2, 50, 'DESCRIPCION EXPERIENCIA 2', 'agotada', 250000, 402);
INSERT INTO EXPERIENCIA (id_experiencia, cupos_disponibles, descripcion, estado, precio_base, id_guia)
VALUES (3, 50, 'DESCRIPCION EXPERIENCIA 3', 'disponible', 150000, 403);
INSERT INTO EXPERIENCIA (id_experiencia, cupos_disponibles, descripcion, estado, precio_base, id_guia)
VALUES (4, 50, 'DESCRIPCION EXPERIENCIA 4', 'agotada', 199900, 404);
INSERT INTO EXPERIENCIA (id_experiencia, cupos_disponibles, descripcion, estado, precio_base, id_guia)
VALUES (5, 50, 'DESCRIPCION EXPERIENCIA 5', 'disponible', 125000, 405);
INSERT INTO EXPERIENCIA (id_experiencia, cupos_disponibles, descripcion, estado, precio_base, id_guia)
VALUES (6, 50, 'DESCRIPCION EXPERIENCIA 6', 'cancelada', 367000, 406);

--Trigger para calcular el total del precio
CREATE OR REPLACE TRIGGER calculo_precio_total
BEFORE INSERT OR UPDATE ON EXPERIENCIA
FOR EACH ROW
DECLARE 
    interes_local NUMBER(12, 4) := 0;
    interes_servicio NUMBER(12, 4) := 0;
BEGIN

    --Para actualizar el impuesto por paíz
    SELECT :NEW.precio_base * ( 1 + SUM(pa.iva) + SUM(c.impuesto_local) ) 
    INTO interes_local
    FROM pais pa 
    INNER JOIN ciudad ci ON ci.id_pais = pa.id_pais
    INNER JOIN estadio e ON e.id_ciudad = ci.id_ciudad
    INNER JOIN partido p ON p.id_estadio = e.id_estadio
    WHERE p.id_experiencia = :NEW.id_experiencia;

    --Para actualizar el impuesto por los servicios
    SELECT SUM(s.costo_adicional * sxi.cantidad * i.valor) 
    INTO interes_servicio
    FROM impuesto i
    INNER JOIN servicio s ON s.id_impuesto = i.id_impuesto
    INNER JOIN ServicioXExperiencia sxi ON sxi.id_servicio = s.id_servicio
    WHERE sxi.id_experiencia = :NEW.id_experiencia;

    :NEW.precio_total := interes_local + interes_servicio; 
END;
/
--SERVICIOXEXPERIENCIA
INSERT INTO SERVICIOXEXPERIENCIA VALUES (2001, 1, 2);
INSERT INTO SERVICIOXEXPERIENCIA VALUES (2003, 1, 3);
INSERT INTO SERVICIOXEXPERIENCIA VALUES (2005, 1, 4);
INSERT INTO SERVICIOXEXPERIENCIA VALUES (2002, 2, 2);
INSERT INTO SERVICIOXEXPERIENCIA VALUES (2004, 2, 3);
INSERT INTO SERVICIOXEXPERIENCIA VALUES (2006, 2, 4);
INSERT INTO SERVICIOXEXPERIENCIA VALUES (2001, 3, 2);
INSERT INTO SERVICIOXEXPERIENCIA VALUES (2002, 3, 3);
INSERT INTO SERVICIOXEXPERIENCIA VALUES (2003, 3, 4);
INSERT INTO SERVICIOXEXPERIENCIA VALUES (2005, 4, 2);
INSERT INTO SERVICIOXEXPERIENCIA VALUES (2006, 4, 3);
INSERT INTO SERVICIOXEXPERIENCIA VALUES (2002, 4, 4);
INSERT INTO SERVICIOXEXPERIENCIA VALUES (2004, 5, 2);
INSERT INTO SERVICIOXEXPERIENCIA VALUES (2005, 5, 3);
INSERT INTO SERVICIOXEXPERIENCIA VALUES (2001, 5, 4);
INSERT INTO SERVICIOXEXPERIENCIA VALUES (2003, 6, 2);
INSERT INTO SERVICIOXEXPERIENCIA VALUES (2006, 6, 3);
INSERT INTO SERVICIOXEXPERIENCIA VALUES (2001, 6, 4);

--CLIENTEXEXPERIENCIA
INSERT INTO CLIENTEXEXPERIENCIA VALUES (1, 1);
INSERT INTO CLIENTEXEXPERIENCIA VALUES (1, 2);
INSERT INTO CLIENTEXEXPERIENCIA VALUES (2, 3);
INSERT INTO CLIENTEXEXPERIENCIA VALUES (2, 4);
INSERT INTO CLIENTEXEXPERIENCIA VALUES (3, 5);
INSERT INTO CLIENTEXEXPERIENCIA VALUES (3, 6);
INSERT INTO CLIENTEXEXPERIENCIA VALUES (4, 7);
INSERT INTO CLIENTEXEXPERIENCIA VALUES (4, 8);
INSERT INTO CLIENTEXEXPERIENCIA VALUES (5, 9);
INSERT INTO CLIENTEXEXPERIENCIA VALUES (6, 10);