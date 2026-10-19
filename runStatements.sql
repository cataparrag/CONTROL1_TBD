USE Estacionamiento;

-- Sentencia 1: Lista de clientes que gasta más por edificio (duda dps)
SELECT e.nombre AS edificio, cl.nombre, cl.apellido, SUM(p.monto) AS montoTotal
FROM pago p
JOIN contrato c ON p.idContrato = c.idContrato
JOIN edificio e ON c.idEdificio = e.idEdificio
JOIN cliente cl ON c.idCliente = cl.idCliente
GROUP BY e.idEdificio, e.nombre, cl.idCliente, cl.nombre, cl.apellido
ORDER BY e.nombre, montoTotal DESC;


-- Sentencia 2: Modelos de auto menos recurrentes por edificio
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

-- Sentencia 3: Empleados con mayor y menor sueldo por edificio.
WITH sueldosEmpleado AS (
select em.idEdificio, em.idEmpleado, em.nombre, em.apellido, s.montoTotal
FROM Empleado em
JOIN Sueldo s ON em.idSueldo = s.idSueldo
)
SELECT idEdificio, nombre, apellido, montoTotal
FROM sueldosEmpleado su
WHERE montoTotal = (
SELECT MAX(montoTotal) FROM sueldosEmpleado su2
WHERE su2.idEdificio = su.idEdificio)
OR montoTotal = (
SELECT MIN(montoTotal) FROM sueldosEmpleado su2
WHERE su2.idEdificio = su.idEdificio)
ORDER BY idEdificio, montoTotal DESC;

-- Sentencia 4: Lista de comunas con la cantidad de clientes que residen en ellas
SELECT
	com.nombreComuna AS Comuna,
    COUNT(c.idCliente) AS CantidadClientes
FROM Comuna com
LEFT JOIN Cliente c ON com.nombreComuna = c.comuna
GROUP BY com.nombreComuna
ORDER BY CantidadClientes DESC, com.nombreComuna ASC;

-- Sentencia 5: Lista de edificios con más lugares disponibles (sin contrato)
SELECT
	e.nombre AS edificio,
    SUM(CASE WHEN lcv.idLugar IS NULL THEN 1 ELSE 0 END) AS LugaresDisponibles
FROM Edificio e
JOIN Lugar l ON e.idEdificio = l.edificio
LEFT JOIN Lugar_CliVeh lcv ON l.idLugar = lcv.idLugar
GROUP BY e.idEdificio, e.nombre
ORDER BY LugaresDisponibles DESC;

-- Sentencia 6: Lista de edificios con menos lugares disponibles
SELECT
	e.nombre AS edificio,
    SUM(CASE WHEN lcv.idLugar IS NULL THEN 1 ELSE 0 END) AS LugaresDisponibles
FROM Edificio e
JOIN Lugar l ON e.idEdificio = l.edificio
LEFT JOIN Lugar_CliVeh lcv ON l.idLugar = lcv.idLugar
GROUP BY e.idEdificio, e.nombre
ORDER BY LugaresDisponibles ASC;

-- Sentencia 7: Lista de Clientes con más autos por edificio. 
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
-- Sentencia 8 : Lugar mas usado por edificio
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


-- Sentencia 9: Edificio con más empleados,indicando el numero de empleados de ese edificio
WITH empleadosPorEdificio AS (
    SELECT e.nombre AS edificio , COUNT(*) AS cantidadEmpleados
    FROM Empleado em
    JOIN Edificio e ON em.idEdificio = e.idEdificio
    GROUP BY e.idEdificio, e.nombre
    
)
SELECT edificio, cantidadEmpleados
FROM empleadosPorEdificio
WHERE cantidadEmpleados = ( SELECT MAX( cantidadEmpleados) FROM empleadosPorEdificio);

-- Sentencia 10: Lista de sueldos por tipo de empleado, por edificio. Destacar la comuna del edificio
SELECT
	e.nombre AS Edificio,
    e.comuna AS ComunaEdificio,
    emp.tipoEmpleado AS Rol,
    COUNT(emp.idEmpleado) AS CantidadTrabajadores,
    SUM(s.montoTotal) AS GastoSueldosTotal, -- Se muestran sueldos totales por tipo de empleado
    AVG(s.montoTotal) AS SueldoPromedio -- Se muestra sueldo promedio por tipo de empleado
FROM Edificio e
JOIN Empleado emp ON e.idEdificio = emp.idEdificio
JOIN Sueldo s ON emp.idSueldo = s.idSueldo
GROUP BY e.idEdificio, e.nombre, e.comuna, emp.tipoEmpleado
ORDER BY e.comuna ASC, e.nombre ASC, GastoSueldosTotal DESC;