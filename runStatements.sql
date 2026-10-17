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