USE Estacionamiento;



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