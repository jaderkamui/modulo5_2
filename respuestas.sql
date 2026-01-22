-- Respuesta a la pregunta 1
SELECT * FROM Libros WHERE autor_id = 1;

-- Respuesta a la pregunta 2
SELECT titulo, precio FROM Libros ORDER BY precio DESC;

-- Respuesta a la pregunta 3
SELECT * FROM Libros WHERE genero = 'Novela' AND stock > 5;

-- Respuesta a la pregunta 4
SELECT * FROM Clientes WHERE apellido ILIKE '%a%';

-- Respuesta a la pregunta 5
SELECT COUNT(*) AS total_libros FROM Libros;

-- Respuesta a la pregunta 6
SELECT genero, AVG(precio) AS precio_promedio
FROM Libros
GROUP BY genero
HAVING AVG(precio) > 20000;

-- Respuesta a la pregunta 7
SELECT L.titulo, A.nombre, A.apellido
FROM Libros L
JOIN Autores A ON L.autor_id = A.autor_id;

-- Respuesta a la pregunta 8
SELECT A.nombre, A.apellido, L.titulo
FROM Autores A
LEFT JOIN Libros L ON A.autor_id = L.autor_id;

-- Respuesta a la pregunta 9
SELECT C.nombre, C.apellido, L.titulo, V.fecha_venta
FROM Ventas V
JOIN Clientes C ON V.cliente_id = C.cliente_id
JOIN Libros L ON V.libro_id = L.libro_id;

-- Respuesta a la pregunta 10
SELECT titulo FROM Libros
WHERE libro_id IN (
    SELECT libro_id FROM Ventas
);