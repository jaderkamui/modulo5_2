-- Tarea 1: Creación de la Tabla Editoriales
CREATE TABLE Editoriales (
    editorial_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    pais_origen VARCHAR(50)
);

-- Tarea 2: Modificación de la Tabla Libros para incluir la Editorial
-- Paso A: Agregar la columna editorial_id
ALTER TABLE Libros
ADD COLUMN editorial_id INTEGER;

-- Paso B: Agregar restricción de llave foránea
ALTER TABLE Libros
ADD CONSTRAINT fk_editorial
FOREIGN KEY (editorial_id)
REFERENCES Editoriales(editorial_id);

-- Tarea 3: Poblando y Actualizando Datos
-- Paso A: Insertar editoriales
INSERT INTO Editoriales (nombre, pais_origen) VALUES 
('Planeta', 'España'),
('Sudamericana', 'Argentina');

-- Paso B: Asignar editoriales a libros
-- NOTA: Asegúrate de que los IDs coincidan según tu tabla Editoriales
-- Usamos subconsultas para obtener los IDs correctamente
UPDATE Libros
SET editorial_id = (SELECT editorial_id FROM Editoriales WHERE nombre = 'Sudamericana')
WHERE titulo = 'Cien años de soledad';

UPDATE Libros
SET editorial_id = (SELECT editorial_id FROM Editoriales WHERE nombre = 'Planeta')
WHERE titulo = 'Rayuela';

-- Tarea 4: Modificando una Restricción
-- Hacemos NOT NULL la columna pais_origen
ALTER TABLE Editoriales
ALTER COLUMN pais_origen SET NOT NULL;

-- Tarea 5: Eliminación y Limpieza de Tablas
-- Crear tabla temporal
CREATE TABLE Promociones_Verano (
    promo_id SERIAL PRIMARY KEY
);

-- Eliminar tabla completamente
DROP TABLE Promociones_Verano;

-- Diferencia entre DROP y TRUNCATE:
-- DROP TABLE elimina completamente la tabla y su estructura de la base de datos.
-- TRUNCATE TABLE borra todos los datos de una tabla, pero mantiene la estructura para seguir usándola.
