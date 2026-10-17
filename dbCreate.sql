drop database if exists  Estacionamiento;
create database Estacionamiento;
use Estacionamiento;

create table if not exists Modelo(
	idModelo smallint auto_increment primary key,
	nombre varchar(50)
);

create table if not exists Sueldo(
	idSueldo smallint auto_increment primary key,
    sueldoBase int,
    montoHorasExtras int,
    montoTotal int
);

create table if not exists Comuna(
	nombreComuna varchar(50) primary key
);

create table if not exists Edificio(
	idEdificio smallint primary key,
	nombre varchar(50),
	calle varchar(50) not null,
	numero int not null,
	comuna varchar(50),


	constraint fk_comuna_ed
		foreign key (comuna)
		references Comuna(nombreComuna)
);

create table if not exists Empleado(
	idEmpleado smallint auto_increment primary key,
    nombre varchar(50),
    apellido varchar(50),
    tipoEmpleado varchar(50),
    
    comuna varchar(50),
    constraint fk_empleado_comuna
		foreign key (comuna)
        references Comuna(nombreComuna),
    
    idSueldo smallint,
    constraint fk_empleado_idSueldo
		foreign key (idSueldo)
		references Sueldo(idSueldo),
    
    idEdificio smallint,
    constraint fk_empleado_edificio
		foreign key (idEdificio)
		references Edificio(idEdificio)
);

create table if not exists Vehiculo(
	idVehiculo smallint auto_increment primary key,
	modelo smallint,


	constraint fk_modelo_vehiculo
		foreign key (modelo)
		references Modelo(idModelo)
);

create table if not exists Cliente(
	idCliente smallint auto_increment primary key,
	nombre varchar(50),
	apellido varchar(50),
    comuna varchar(50),
    
    constraint fk_cliente_comuna
		foreign key (comuna)
		references Comuna(nombreComuna)
);

create table if not exists ClienteVehiculo(
	idCliente smallint not null,
	idVehiculo smallint not null,


	primary key (idCliente, idVehiculo),


	constraint fk_cliente_tiene_vehiculo
		foreign key (idCliente) 
		references Cliente(idCliente),
	constraint fk_tiene_vehiculo
		foreign key (idVehiculo) 
		references Vehiculo(idVehiculo)


);

create table if not exists Contrato(
	idContrato smallint auto_increment primary key,
    fechaInicio date,
    fechaFin date,
    
    idEdificio smallint,
    constraint fk_contrato_edificio
		foreign key (idEdificio)
		references Edificio(idEdificio),
    
    idCliente smallint,
    idVehiculo smallint,
    constraint fk_contrato_cv
		foreign key(idCliente,idVehiculo)
		references ClienteVehiculo(idCliente, idVehiculo)
);

create table if not exists Pago(
	idPago smallint auto_increment primary key,
    monto int not null,
    fechaPago date,
    idContrato smallint,
    constraint fk_pago_contrato
		foreign key (idContrato)
        references Contrato(idContrato)
);

create table if not exists Lugar(
	idLugar varchar(50) primary key,
	edificio smallint ,


	constraint fk_lugar_edificio
		foreign key (edificio)
		references Edificio(idEdificio)
);

create table if not exists Lugar_CliVeh(
	idLCV smallint auto_increment,
	idCliente smallint not null,
	idVehiculo smallint not null,
	idLugar varchar(50),


	primary key (idLCV, idCliente, idVehiculo),
	constraint fk_cliente_tiene
		foreign key (idCliente, idVehiculo) 
		references ClienteVehiculo(idCliente, idVehiculo),
	constraint fk_lugar_cv
		foreign key (idLugar)
		references Lugar(idLugar)
);