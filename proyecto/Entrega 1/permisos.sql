--cambio de prueba

--Soph
GRANT ALL ON CIUDAD         TO is331511;
GRANT ALL ON CONFEDERACION  TO is331511;
GRANT ALL ON ESTADIO        TO is331511;
GRANT ALL ON PAIS           TO is331511;
GRANT ALL ON PARTIDO        TO is331511;
GRANT ALL ON SELECCION      TO is331511;
GRANT ALL ON DATOS          TO is331511;

--Fabi
GRANT ALL ON CIUDAD         TO is331516;
GRANT ALL ON CONFEDERACION  TO is331516;
GRANT ALL ON ESTADIO        TO is331516;
GRANT ALL ON PAIS           TO is331516;
GRANT ALL ON PARTIDO        TO is331516;
GRANT ALL ON SELECCION      TO is331516;
GRANT ALL ON DATOS          TO is331516;

--Mi UserName: is331501

--COMANDOS ÚTILES

--SINÓNIMO: Crea un nombre temporal de la tabla de mi server en su esquema 
    CREATE SYNONYM CIUDAD FOR is331501.CIUDAD; --Y así con el resto. . .

--SET SCHEMA: Copia todas las tablas de ese otro user durante esa sesión 
    --Está como vacano xd
    ALTER SESSION SET CURRENT_SCHEMA = is331501; 