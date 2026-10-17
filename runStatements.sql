USE Estacionamiento;

-- Consulta 1: Lista de clientes que gasta más por edificio 
SELECT e.nombre AS edificio, cl.nombre, cl.apellido, SUM(p.monto) AS montoTotal
FROM pago p
JOIN contrato c ON p.idContrato = c.idContrato
JOIN edificio e ON c.idEdificio = e.idEdificio
JOIN cliente cl ON c.idCliente = cl.idCliente
GROUP BY e.idEdificio, e.nombre, cl.idCliente, cl.nombre, cl.apellido
ORDER BY e.nombre, montoTotal DESC;

-- Consulta 2: Modelos de auto menos recurrentes por edificio
WITH conteo AS (
SELECT c.idEdificio, m.idModelo, m.nombre AS modeloAuto, count(v.idVehiculo) AS cantidad
FROM modelo m
JOIN vehiculo v ON m.idModelo = v.modelo
JOIN contrato c ON v.idVehiculo = c.idVehiculo
GROUP BY c.idEdificio, m.idModelo, m.nombre
),
minimos AS (
SELECT idEdificio, MIN(cantidad) AS CantidadMinima
FROM conteo GROUP BY idEdificio
)
SELECT e.nombre AS edificio, co.modeloAuto, co.cantidad
FROM conteo co
JOIN minimos mini ON co.idEdificio = mini.idEdificio AND co.cantidad = mini.cantidadMinima
JOIN edificio e ON co.idEdificio = e.idEdificio
ORDER BY e.nombre, co.modeloAuto;

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