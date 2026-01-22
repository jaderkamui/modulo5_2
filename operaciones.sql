-- Tarea 1: Ingresando un nuevo autor y su libro

INSERT INTO Autores (nombre, apellido, nacionalidad)
VALUES ('Stephen', 'King', 'Estadounidense');

-- Verificamos el ID del autor insertado (ajústalo si cambia, por ejemplo: 5)
-- Suponiendo autor_id = 5

INSERT INTO Libros (titulo, genero, anio_publicacion, precio, stock, autor_id)
VALUES ('It', 'Terror', 1986, 23500.00, 11, 5);


-- Tarea 2: Actualizando información

-- 1) El libro "Rayuela" ha subido de precio
UPDATE Libros
SET precio = 29500.00
WHERE titulo = 'Rayuela';

-- 2) Aumentar en 5 el stock de todos los libros del género 'Cuento'
UPDATE Libros
SET stock = stock + 5
WHERE genero = 'Cuento';


-- Tarea 3: Borrando información (Devolución de Juan Pérez)

-- Eliminar la venta de 'La casa de los espíritus' por 'Juan Pérez'
DELETE FROM Ventas
WHERE cliente_id = (
  SELECT cliente_id FROM Clientes
  WHERE nombre = 'Juan' AND apellido = 'Pérez'
)
AND libro_id = (
  SELECT libro_id FROM Libros
  WHERE titulo = 'La casa de los espíritus'
);


-- Tarea 4: Integridad Referencial en Acción

-- Intento de eliminar a Gabriel García Márquez
DELETE FROM Autores
WHERE nombre = 'Gabriel' AND apellido = 'García Márquez';

-- Este DELETE fallará con un error de clave foránea (foreign key) porque:
-- PostgreSQL impide eliminar un autor si aún existen libros en la tabla Libros que lo referencian por su autor_id.
-- Esto se debe a la integridad referencial: no se puede dejar un registro "huérfano" apuntando a un autor que ya no existe.


-- Tarea 5: Transacción Exitosa (COMMIT)

BEGIN;

-- 1) Disminuir el stock del libro 'El Aleph'
UPDATE Libros
SET stock = stock - 1
WHERE titulo = 'El Aleph';

-- 2) Insertar venta para cliente_id = 4
INSERT INTO Ventas (cliente_id, libro_id, fecha_venta)
VALUES (
  4,
  (SELECT libro_id FROM Libros WHERE titulo = 'El Aleph'),
  CURRENT_DATE
);

COMMIT;


-- Tarea 6: Transacción Fallida (ROLLBACK)

BEGIN;

-- 1) Disminuir el stock del libro 'La ciudad y los perros'
UPDATE Libros
SET stock = stock - 1
WHERE titulo = 'La ciudad y los perros';

-- 2) Problema con el pago... deshacemos todo
ROLLBACK;
-- Después del ROLLBACK, el stock de 'La ciudad y los perros' permanece sin cambios.

