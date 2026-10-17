USE Estacionamiento;

-- Consulta 1: Lista de clientes que gasta más por edificio (duda dps)
SELECT e.nombre AS edificio, cl.nombre, cl.apellido, SUM(p.monto) AS montoTotal
FROM pago p
JOIN contrato c ON p.idContrato = c.idContrato
JOIN edificio e ON c.idEdificio = e.idEdificio
JOIN cliente cl ON c.idCliente = cl.idCliente
GROUP BY e.idEdificio, e.nombre, cl.idCliente, cl.nombre, cl.apellido
ORDER BY e.nombre, montoTotal DESC;



-- Consulta 2: Modelos de auto menos recurrentes por edificio


-- Consulta 5: Lista de edificios con más lugares disponibles (sin contrato)
SELECT
	e.nombre AS edificio,
    SUM(CASE WHEN lcv.idLugar IS NULL THEN 1 ELSE 0 END) AS LugaresDisponibles
FROM Edificio e
JOIN Lugar l ON e.idEdificio = l.edificio
LEFT JOIN Lugar_CliVeh lcv ON l.idLugar = lcv.idLugar
GROUP BY e.idEdificio, e.nombre
ORDER BY LugaresDisponibles DESC;

-- Consulta 6: Lista de edificios con menos lugares disponibles
SELECT
	e.nombre AS edificio,
    SUM(CASE WHEN lcv.idLugar IS NULL THEN 1 ELSE 0 END) AS LugaresDisponibles
FROM Edificio e
JOIN Lugar l ON e.idEdificio = l.edificio
LEFT JOIN Lugar_CliVeh lcv ON l.idLugar = lcv.idLugar
GROUP BY e.idEdificio, e.nombre
ORDER BY LugaresDisponibles ASC;

-- Consulta 7: Lista de Clientes con más autos por edificio. 
WITH autosPorCliente AS (
    SELECT idEdificio, idCliente, COUNT(DISTINCT idVehiculo) AS cantidadAutos
    FROM Contrato
    GROUP BY idEdificio, idCliente
)
SELECT idEdificio, idCliente, cantidadAutos
FROM autosPorCliente a
WHERE cantidadAutos = (
    SELECT MAX(cantidadAutos) FROM autosPorCliente a2
    WHERE a2.idEdificio = a.idEdificio
);
-- Consulta 8 : Lugar mas usado por edificio
WITH usosPorLugar AS (
    SELECT l.edificio, l.idLugar, COUNT(*) AS cantidadUsos
    FROM Lugar_CliVeh lcv
    JOIN Lugar l ON lcv.idLugar = l.idLugar
    GROUP BY l.edificio, l.idLugar
)
SELECT edificio, idLugar, cantidadUsos
FROM usosPorLugar u
WHERE cantidadUsos = (
    SELECT MAX(cantidadUsos) FROM usosPorLugar u2
    WHERE u2.edificio = u.edificio
);


-- Consulta 9: Edificio con más empleados,indicando el numero de empleados de ese edificio
WITH empleadosPorEdificio AS (
    SELECT e.nombre AS edificio , COUNT(*) AS cantidadEmpleados
    FROM Empleado em
    JOIN Edificio e ON em.idEdificio = e.idEdificio
    GROUP BY e.idEdificio, e.nombre
    
)
SELECT edificio, cantidadEmpleados
FROM empleadosPorEdificio
WHERE cantidadEmpleados = ( SELECT MAX( cantidadEmpleados) FROM empleadosPorEdificio);