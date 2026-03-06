CREATE TABLE CLIENTES
(
    codigo_cliente number(3,0),
    nombre varchar2(60),
    apellido varchar2(60),
    fecha_nacimiento date,
    fecha_vinculacion date,
    email varchar2(60),
    genero char(1),
    PRIMARY KEY (codigo_cliente)
);


CREATE TABLE OFICINAS
(
    codigo_oficina number (3,0),
    nombre varchar2(60),
    PRIMARY KEY(codigo_oficina)
);


CREATE TABLE CUENTAS
(
    numero_cuenta number(3,0),
    tipo char(1),
    codigo_oficina  number (3,0),
    valor_apertura number(12,2),
    CONSTRAINT ch_tipo CHECK (
        tipo = 'C' OR 
        tipo = 'A'
        ),
    FOREIGN KEY (codigo_oficina) REFERENCES OFICINAS,
    PRIMARY KEY (numero_cuenta)
);


CREATE TABLE TITULARES
(
    codigo_cliente number(3,0),
    numero_cuenta number(3,0), 
    porcentaje_titularidad number(3,0),
    FOREIGN KEY (codigo_cliente) REFERENCES CLIENTES,
    FOREIGN KEY (numero_cuenta) REFERENCES CUENTAS,
    PRIMARY KEY (codigo_cliente, numero_cuenta)
);

CREATE TABLE MOVIMIENTOS
(
    numero_cuenta number(3,0),
    numero number(3,0),
    tipo char(1),  --Los posibles valores son D, C,I,R .DONDE D SON DÉBITOS, C SON CRÉDITOS, I SON IMPUESTOS, R RENDIMIENTOS
    valor number(10,2),
    fecha_movimiento date,
    CONSTRAINT ch_tipo_movimiento CHECK(
        tipo = 'D' OR -- débitos
        tipo = 'C' OR -- créditos
        tipo = 'I' OR -- impuestos
        tipo = 'R'    -- rendimientos
    ),
    FOREIGN KEY (numero_cuenta) REFERENCES CUENTAS,
    PRIMARY KEY (numero_cuenta, numero)
);
