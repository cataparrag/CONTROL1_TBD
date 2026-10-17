USE Estacionamiento;

-- 1. COMUNAS
INSERT INTO Comuna (nombreComuna) VALUES
('Santiago'),
('Providencia'),
('Las Condes'),
('Estación Central'),
('Ñuñoa');

-- 2. MODELOS DE VEHÍCULOS
INSERT INTO Modelo (nombre) VALUES
('Toyota Yaris'),
('Hyundai Accent'),
('Suzuki Swift'),
('Nissan Versa'),
('BMW X5'),
('Chevrolet Sail');

-- 3. SUELDOS
INSERT INTO Sueldo (sueldoBase, montoHorasExtras, montoTotal) VALUES
(500000, 50000, 550000),
(600000, 100000, 700000),
(850000, 0, 850000),
(1200000, 150000, 1350000),
(480000, 20000, 500000),
(900000, 80000, 980000);

-- 4. EDIFICIOS
INSERT INTO Edificio (idEdificio, nombre, calle, numero, comuna) VALUES
(1, 'Edificio Centro Cívico', 'Moneda', 1020, 'Santiago'),
(2, 'Edificio Providencia Plaza', 'Av. Providencia', 1940, 'Providencia'),
(3, 'Edificio Las Condes Tower', 'Av. Apoquindo', 4500, 'Las Condes');

-- 5. EMPLEADOS
INSERT INTO Empleado (nombre, apellido, tipoEmpleado, comuna, idSueldo, idEdificio) VALUES
('Carlos', 'González', 'Guardia', 'Santiago', 1, 1),
('Ana', 'Martínez', 'Administrador', 'Providencia', 4, 1),
('Pedro', 'Soto', 'Operador', 'Estación Central', 2, 1),
('Luis', 'Contreras', 'Guardia', 'Santiago', 5, 1),
('María', 'Pérez', 'Administrador', 'Providencia', 4, 2),
('Jorge', 'Rojas', 'Guardia', 'Ñuñoa', 2, 2),
('Laura', 'Vargas', 'Administrador', 'Las Condes', 3, 3),
('Diego', 'Silva', 'Guardia', 'Santiago', 6, 3);

-- 6. CLIENTES
INSERT INTO Cliente (nombre, apellido, comuna) VALUES
('Matías', 'Rojas', 'Santiago'),
('Fernanda', 'López', 'Santiago'),
('Gonzalo', 'Bravo', 'Providencia'),
('Camila', 'Torres', 'Las Condes'),
('Valentina', 'Muñoz', 'Estación Central'),
('Ignacio', 'Araya', 'Santiago');

-- 7. VEHÍCULOS
INSERT INTO Vehiculo (modelo) VALUES
(1), -- Toyota Yaris (id 1)
(2), -- Hyundai Accent (id 2)
(1), -- Toyota Yaris (id 3)
(3), -- Suzuki Swift (id 4)
(5), -- BMW X5 (id 5)
(4), -- Nissan Versa (id 6)
(6); -- Chevrolet Sail (id 7)

-- 8. CLIENTE VEHÍCULO
INSERT INTO ClienteVehiculo (idCliente, idVehiculo) VALUES
(1, 1), -- Matías - Yaris
(1, 2), -- Matías - Accent
(2, 3), -- Fernanda - Yaris
(3, 4), -- Gonzalo - Swift
(4, 5), -- Camila - BMW X5
(5, 6), -- Valentina - Versa
(6, 7); -- Ignacio - Sail

-- 9. CONTRATOS
INSERT INTO Contrato (fechaInicio, fechaFin, idEdificio, idCliente, idVehiculo) VALUES
('2026-01-01', '2026-12-31', 1, 1, 1), -- Matías en Edificio 1
('2026-02-01', '2026-12-31', 1, 1, 2), -- Matías (segundo auto) en Edificio 1
('2026-01-15', '2026-06-30', 1, 2, 3), -- Fernanda en Edificio 1
('2026-03-01', '2026-12-31', 2, 3, 4), -- Gonzalo en Edificio 2
('2026-01-01', '2026-12-31', 3, 4, 5), -- Camila en Edificio 3
('2026-04-01', '2026-10-31', 2, 5, 6); -- Valentina en Edificio 2

-- 10. PAGOS
INSERT INTO Pago (monto, fechaPago, idContrato) VALUES
(120000, '2026-01-05', 1),
(120000, '2026-02-05', 1),
(150000, '2026-02-05', 2),
(90000,  '2026-01-20', 3), 
(200000, '2026-03-05', 4),
(350000, '2026-01-10', 5),
(100000, '2026-04-05', 6);

-- 11. LUGARES
INSERT INTO Lugar (idLugar, edificio) VALUES
('E1-L01', 1), ('E1-L02', 1), ('E1-L03', 1), ('E1-L04', 1), ('E1-L05', 1),
('E1-L06', 1), ('E1-L07', 1), ('E1-L08', 1), ('E1-L09', 1), ('E1-L10', 1),
('E2-L01', 2), ('E2-L02', 2), ('E2-L03', 2), ('E2-L04', 2), ('E2-L05', 2),
('E3-L01', 3), ('E3-L02', 3);

-- 12. LUGAR CLIENTE VEHÍCULO
INSERT INTO Lugar_CliVeh (idCliente, idVehiculo, idLugar) VALUES
(1, 1, 'E1-L01'),
(1, 2, 'E1-L02'),
(2, 3, 'E1-L03'),
(3, 4, 'E2-L01'),
(5, 6, 'E2-L02'),
(4, 5, 'E3-L01'),
(6, 7, 'E3-L02');