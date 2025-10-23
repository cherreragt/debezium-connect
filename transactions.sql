-- ===========================================
-- INSERTS: CATEGORIA
-- ===========================================
INSERT INTO DEBEZIUM.CATEGORIA (nombre, descripcion)
VALUES ('Ciencia Ficción', 'Libros de ciencia ficción y tecnología futurista.');

INSERT INTO DEBEZIUM.CATEGORIA (nombre, descripcion)
VALUES ('Historia', 'Libros sobre hechos históricos y civilizaciones antiguas.');

INSERT INTO DEBEZIUM.CATEGORIA (nombre, descripcion)
VALUES ('Programación', 'Libros sobre lenguajes de programación y desarrollo de software.');

-- ===========================================
-- INSERTS: AUTOR
-- ===========================================
INSERT INTO DEBEZIUM.AUTOR (nombre, apellido, fecha_nacimiento, nacionalidad)
VALUES ('Isaac', 'Asimov', TO_DATE('1920-01-02', 'YYYY-MM-DD'), 'Ruso-Estadounidense');

INSERT INTO DEBEZIUM.AUTOR (nombre, apellido, fecha_nacimiento, nacionalidad)
VALUES ('Yuval Noah', 'Harari', TO_DATE('1976-02-24', 'YYYY-MM-DD'), 'Israelí');

INSERT INTO DEBEZIUM.AUTOR (nombre, apellido, fecha_nacimiento, nacionalidad)
VALUES ('Robert C.', 'Martin', TO_DATE('1952-12-05', 'YYYY-MM-DD'), 'Estadounidense');

-- ===========================================
-- INSERTS: LIBRO (FK aleatorias)
-- ===========================================
INSERT INTO DEBEZIUM.LIBRO (isbn, titulo, ID_AUTOR, ID_CATEGORIA, editorial, fecha_publicacion, edicion, numero_paginas, ubicacion)
VALUES (
           '9780451524935',
           'Yo, Robot',
           (SELECT ID FROM DEBEZIUM.AUTOR ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROWS ONLY),
           (SELECT ID FROM DEBEZIUM.CATEGORIA ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROWS ONLY),
           'Gnome Press',
           TO_DATE('1950-12-02', 'YYYY-MM-DD'),
           1,
           253,
           'Estante A1'
       );

INSERT INTO DEBEZIUM.LIBRO (isbn, titulo, ID_AUTOR, ID_CATEGORIA, editorial, fecha_publicacion, edicion, numero_paginas, ubicacion)
VALUES (
           '9780099590088',
           'Sapiens: De animales a dioses',
           (SELECT ID FROM DEBEZIUM.AUTOR ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROWS ONLY),
           (SELECT ID FROM DEBEZIUM.CATEGORIA ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROWS ONLY),
           'Harvill Secker',
           TO_DATE('2011-06-04', 'YYYY-MM-DD'),
           1,
           498,
           'Estante B2'
       );

INSERT INTO DEBEZIUM.LIBRO (isbn, titulo, ID_AUTOR, ID_CATEGORIA, editorial, fecha_publicacion, edicion, numero_paginas, ubicacion)
VALUES (
           '9780132350884',
           'Clean Code',
           (SELECT ID FROM DEBEZIUM.AUTOR ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROWS ONLY),
           (SELECT ID FROM DEBEZIUM.CATEGORIA ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROWS ONLY),
           'Prentice Hall',
           TO_DATE('2008-08-01', 'YYYY-MM-DD'),
           1,
           464,
           'Estante C3'
       );

-- ===========================================
-- INSERTS: USUARIO
-- ===========================================
INSERT INTO DEBEZIUM.USUARIO (numero_identificacion, nombre, apellido, email, telefono, direccion, tipo_usuario)
VALUES ('1001', 'Ana', 'Gómez', 'ana.gomez@example.com', '555-1234', 'Av. Central 45', 'ESTUDIANTE');

INSERT INTO DEBEZIUM.USUARIO (numero_identificacion, nombre, apellido, email, telefono, direccion, tipo_usuario)
VALUES ('1002', 'Luis', 'Martínez', 'luis.martinez@example.com', '555-5678', 'Calle Norte 12', 'PROFESOR');

INSERT INTO DEBEZIUM.USUARIO (numero_identificacion, nombre, apellido, email, telefono, direccion, tipo_usuario)
VALUES ('1003', 'María', 'Pérez', 'maria.perez@example.com', '555-9876', 'Boulevard Sur 99', 'EMPLEADO');

-- ===========================================
-- INSERTS: PRESTAMO (FK aleatorias)
-- ===========================================
INSERT INTO DEBEZIUM.PRESTAMO (ID_LIBRO, ID_USUARIO, fecha_devolucion_prevista, fecha_prestamo, observaciones)
VALUES (
           (SELECT ID FROM DEBEZIUM.LIBRO ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROWS ONLY),
           (SELECT ID FROM DEBEZIUM.USUARIO ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROWS ONLY),
           SYSDATE + 7,
           SYSDATE + 7,
           'Primer préstamo generado aleatoriamente.'
       );

INSERT INTO DEBEZIUM.PRESTAMO (ID_LIBRO, ID_USUARIO, fecha_devolucion_prevista, fecha_prestamo, observaciones)
VALUES (
           (SELECT ID FROM DEBEZIUM.LIBRO ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROWS ONLY),
           (SELECT ID FROM DEBEZIUM.USUARIO ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROWS ONLY),
           SYSDATE + 10,
           SYSDATE + 7,
           'Préstamo aleatorio 2.'
       );

INSERT INTO DEBEZIUM.PRESTAMO (ID_LIBRO, ID_USUARIO, fecha_devolucion_prevista, fecha_prestamo, observaciones)
VALUES (
           (SELECT ID FROM DEBEZIUM.LIBRO ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROWS ONLY),
           (SELECT ID FROM DEBEZIUM.USUARIO ORDER BY DBMS_RANDOM.VALUE FETCH FIRST 1 ROWS ONLY),
           SYSDATE + 14,
           SYSDATE + 7,
           'Préstamo aleatorio 3.'
       );
COMMIT;