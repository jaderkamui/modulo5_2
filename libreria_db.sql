-- Script para crear y poblar la base de datos de la Librería El Saber
-- Versión para PostgreSQL


-- Limpieza de tablas si existen para permitir la re-ejecución del script
DROP TABLE IF EXISTS Ventas;
DROP TABLE IF EXISTS Libros;
DROP TABLE IF EXISTS Autores;
DROP TABLE IF EXISTS Clientes;


-- Creación de la tabla Autores
CREATE TABLE Autores (
    autor_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    nacionalidad VARCHAR(50)
);


-- Creación de la tabla Libros
CREATE TABLE Libros (
    libro_id SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    genero VARCHAR(100),
    anio_publicacion INT,
    precio DECIMAL(10, 2),
    stock INT,
    autor_id INT,
    FOREIGN KEY (autor_id) REFERENCES Autores(autor_id)
);


-- Creación de la tabla Clientes
CREATE TABLE Clientes (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE
);


-- Creación de la tabla Ventas
CREATE TABLE Ventas (
    venta_id SERIAL PRIMARY KEY,
    libro_id INT,
    cliente_id INT,
    fecha_venta DATE,
    cantidad INT,
    FOREIGN KEY (libro_id) REFERENCES Libros(libro_id),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id)
);


-- Inserción de datos de ejemplo


-- Autores
INSERT INTO Autores (nombre, apellido, nacionalidad) VALUES
('Gabriel', 'García Márquez', 'Colombiana'),
('Isabel', 'Allende', 'Chilena'),
('Jorge Luis', 'Borges', 'Argentina'),
('Julio', 'Cortázar', 'Argentina'),
('Mario', 'Vargas Llosa', 'Peruana'),
('Haruki', 'Murakami', 'Japonesa'); -- Este autor no tendrá libros asociados


-- Libros
INSERT INTO Libros (titulo, genero, anio_publicacion, precio, stock, autor_id) VALUES
('Cien años de soledad', 'Novela', 1967, 25500.00, 10, 1),
('El amor en los tiempos del cólera', 'Novela', 1985, 22000.00, 8, 1),
('La casa de los espíritus', 'Novela', 1982, 19900.00, 12, 2),
('De amor y de sombra', 'Novela', 1984, 18500.00, 4, 2),
('Ficciones', 'Cuento', 1944, 15000.00, 20, 3),
('El Aleph', 'Cuento', 1949, 16200.00, 15, 3),
('Rayuela', 'Novela', 1963, 28000.00, 7, 4),
('La ciudad y los perros', 'Novela', 1963, 21000.00, 3, 5);


-- Clientes
INSERT INTO Clientes (nombre, apellido, email) VALUES
('Ana', 'García', 'ana.garcia@email.com'),
('Juan', 'Pérez', 'juan.perez@email.com'),
('María', 'Rodríguez', 'maria.r@email.com'),
('Carlos', 'Sánchez', 'carlos.sanchez@email.com');


-- Ventas
INSERT INTO Ventas (libro_id, cliente_id, fecha_venta, cantidad) VALUES
(1, 1, '2024-05-10', 1),
(3, 2, '2024-05-12', 1),
(5, 1, '2024-05-15', 2),
(7, 3, '2024-06-01', 1),
(2, 4, '2024-06-05', 1),
(1, 2, '2024-06-10', 1);