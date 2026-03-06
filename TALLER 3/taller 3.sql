drop table titulares CASCADE CONSTRAINTS;
drop table cuentas CASCADE CONSTRAINTS;
drop table oficinas CASCADE CONSTRAINTS;
drop table clientes CASCADE CONSTRAINTS;

create table clientes(
    codigo number(3,0) not null,
    nombre varchar2(60) not null,
    apellido varchar2(60) not null,
    fecha_nacimiento date not null,
    email varchar(60),
    primary key(codigo)
);

create table oficinas(
    codigo number(3,0) not null,
    nombre varchar2(60) not null,
    barrio varchar(60) not null,
    primary key(codigo)
);

create table cuentas(
    numero number(3,0),
    tipo char(1) constraint tipo check(tipo='C' or tipo='A'),
    saldo_number number(10,2),
    codigo_oficina number(3,0),
    primary key(numero),
    foreign key (codigo_oficina) references oficinas
);

create table titulares(
    codigo_cliente number(3,0),
    numero_cuenta number(3,0),
    foreign key (codigo_cliente) references clientes,
    foreign key (numero_cuenta) references cuentas,
    primary key(codigo_cliente, numero_cuenta)
);

INSERT INTO clientes VALUES (101, 'Carlos', 'Ramírez',  DATE '1990-03-15', 'carlos.ramirez@email.com');
INSERT INTO clientes VALUES (102, 'María',  'Gómez',    DATE '1988-07-22', 'maria.gomez@email.com');
INSERT INTO clientes VALUES (103, 'Luis',   'Martínez', DATE '1995-01-10', 'luis.martinez@email.com');
INSERT INTO clientes VALUES (104, 'Ana',    'López',    DATE '1992-11-05', 'ana.lopez@email.com');
INSERT INTO clientes VALUES (105, 'Jorge',  'Castro',   DATE '1985-09-18', 'jorge.castro@email.com');
INSERT INTO clientes VALUES (106, 'Lucía',  'Fernández',DATE '1998-06-30', 'lucia.fernandez@email.com');
INSERT INTO clientes VALUES (107, 'Pedro',  'Sánchez',  DATE '1991-12-12', 'pedro.sanchez@email.com');
INSERT INTO clientes VALUES (108, 'Laura',  'Torres',   DATE '1993-04-27', 'laura.torres@email.com');
INSERT INTO clientes VALUES (109, 'Diego',  'Morales',  DATE '1987-02-14', 'diego.morales@email.com');
INSERT INTO clientes VALUES (110, 'Sofía',  'Rojas',    DATE '1996-08-09', 'sofia.rojas@email.com');
INSERT INTO clientes VALUES (111, 'Andrés', 'Vega',     DATE '1994-10-01', 'andres.vega@email.com');
INSERT INTO clientes VALUES (112, 'Camila', 'Herrera',  DATE '1989-05-20', 'camila.herrera@email.com');
INSERT INTO clientes VALUES (113, 'Miguel', 'Díaz',     DATE '1997-03-03', 'miguel.diaz@email.com');
INSERT INTO clientes VALUES (114, 'Valeria','Navarro',  DATE '1990-07-17', 'valeria.navarro@email.com');
INSERT INTO clientes VALUES (115, 'Fernando','Ortega',  DATE '1986-12-25', 'fernando.ortega@email.com');

INSERT INTO oficinas VALUES (201, 'Oficina Centro',      'Centro');
INSERT INTO oficinas VALUES (202, 'Oficina Norte',       'Norte');
INSERT INTO oficinas VALUES (203, 'Oficina Sur',         'Sur');
INSERT INTO oficinas VALUES (204, 'Oficina Este',        'Este');
INSERT INTO oficinas VALUES (205, 'Oficina Oeste',       'Oeste');
INSERT INTO oficinas VALUES (206, 'Oficina Central Park','Central');
INSERT INTO oficinas VALUES (207, 'Oficina Primavera',   'Primavera');
INSERT INTO oficinas VALUES (208, 'Oficina Alameda',     'Alameda');
INSERT INTO oficinas VALUES (209, 'Oficina Colinas',     'Colinas');
INSERT INTO oficinas VALUES (210, 'Oficina Jardines',    'Jardines');
INSERT INTO oficinas VALUES (211, 'Oficina Las Palmas',  'Las Palmas');
INSERT INTO oficinas VALUES (212, 'Oficina Kennedy',     'Kennedy');
INSERT INTO oficinas VALUES (213, 'Oficina San José',    'San José');
INSERT INTO oficinas VALUES (214, 'Oficina Bolívar',     'Bolívar');
INSERT INTO oficinas VALUES (215, 'Oficina Central Sur', 'Centro Sur');

INSERT INTO cuentas VALUES (301, 'A', 1500.50, 201);
INSERT INTO cuentas VALUES (302, 'C', 3200.00, 202);
INSERT INTO cuentas VALUES (303, 'A', 7850.75, 203);
INSERT INTO cuentas VALUES (304, 'C', 1200.00, 204);
INSERT INTO cuentas VALUES (305, 'A', 5600.40, 205);
INSERT INTO cuentas VALUES (306, 'C', 980.00,  206);
INSERT INTO cuentas VALUES (307, 'A', 4300.20, 207);
INSERT INTO cuentas VALUES (308, 'C', 2100.00, 208);
INSERT INTO cuentas VALUES (309, 'A', 6700.60, 209);
INSERT INTO cuentas VALUES (310, 'C', 150.00,  210);
INSERT INTO cuentas VALUES (311, 'A', 9999.99, 211);
INSERT INTO cuentas VALUES (312, 'C', 450.75,  212);
INSERT INTO cuentas VALUES (313, 'A', 800.00,  213);
INSERT INTO cuentas VALUES (314, 'C', 2300.00, 214);
INSERT INTO cuentas VALUES (315, 'A', 12000.00,215);

INSERT INTO titulares VALUES (101, 301);
INSERT INTO titulares VALUES (102, 302);
INSERT INTO titulares VALUES (103, 303);
INSERT INTO titulares VALUES (104, 304);
INSERT INTO titulares VALUES (105, 305);
INSERT INTO titulares VALUES (106, 306);
INSERT INTO titulares VALUES (107, 307);
INSERT INTO titulares VALUES (108, 308);
INSERT INTO titulares VALUES (109, 309);
INSERT INTO titulares VALUES (110, 310);
INSERT INTO titulares VALUES (111, 311);
INSERT INTO titulares VALUES (112, 312);
INSERT INTO titulares VALUES (113, 313);
INSERT INTO titulares VALUES (114, 314);
INSERT INTO titulares VALUES (115, 315);

COMMIT;

SELECT * , COUNT(codigo_cliente)
FROM CUENTAS;