CREATE TABLE correosTX.dbo.TIPO_ENVIO (
    idTipoEnvio INT PRIMARY KEY,
    descripcion NVARCHAR(45)
);

CREATE TABLE correosTX.dbo.PROVINCIA (
    idProvincia INT PRIMARY KEY,
    nombre NVARCHAR(45)
);

CREATE TABLE correosTX.dbo.CANTONES (
    idCanton INT PRIMARY KEY,
    nombreCanton NVARCHAR(45),
    idProvincia INT,
    FOREIGN KEY (idProvincia) REFERENCES PROVINCIA(idProvincia)
);

CREATE TABLE correosTX.dbo.DISTRITOS (
    idDistrito INT PRIMARY KEY,
    nombreDistrito NVARCHAR(45),
    idCanton INT,
    FOREIGN KEY (idCanton) REFERENCES CANTONES(idCanton)
);

CREATE TABLE correosTX.dbo.OFICINA (
    idOficina INT PRIMARY KEY,
    nombre NVARCHAR(20),
    direccionExacta NVARCHAR(255),
    idDistrito INT,
    FOREIGN KEY (idDistrito) REFERENCES DISTRITOS(idDistrito)
);

CREATE TABLE correosTX.dbo.EMPLEADO (
    idEmpleado INT PRIMARY KEY,
    cedula NVARCHAR(9),
    primerNombre NVARCHAR(20),
    segundoNombre NVARCHAR(20),
    primerApellido NVARCHAR(20),
    segundoApellido NVARCHAR(20),
    fechaNacimiento DATE,
    nombreUsuario NVARCHAR(50),
    telefonoEmpleado NVARCHAR(20),
    correoEmpleado NVARCHAR(100),
    direccionExacta NVARCHAR(255),
    estadoEmpleado NVARCHAR(50),
    idDistrito INT,
    idOficina INT,
    FOREIGN KEY (idDistrito) REFERENCES DISTRITOS(idDistrito),
    FOREIGN KEY (idOficina) REFERENCES OFICINA(idOficina)
);

CREATE TABLE correosTX.dbo.CLIENTE (
    idCliente INT PRIMARY KEY,
    cedula NVARCHAR(9),
    primerNombre NVARCHAR(20),
    segundoNombre NVARCHAR(20),
    primerApellido NVARCHAR(20),
    segundoApellido NVARCHAR(20),
    fechaNacimiento DATETIME2(7),
    nombreUsuario NVARCHAR(50),
    correoCliente NVARCHAR(100),
    telefonoCliente NVARCHAR(20),
    direccionExacta NVARCHAR(255),
    tipoCliente NVARCHAR(45),
    estadoCliente NVARCHAR(45),
    idDistrito INT,
    FOREIGN KEY (idDistrito) REFERENCES DISTRITOS(idDistrito)
);

CREATE TABLE correosTX.dbo.PAQUETERIA (
    idPaquete INT PRIMARY KEY,
    descripcion NVARCHAR(255),
    fechaRegistro DATETIME2(7),
    fechaEntrega DATETIME2(7),
    fechaUltimaModificacion DATETIME2(7),
    idOficina INT,
    idEmpleado INT,
    idCliente INT,
    idTipoEnvio INT,
    FOREIGN KEY (idOficina) REFERENCES OFICINA(idOficina),
    FOREIGN KEY (idEmpleado) REFERENCES EMPLEADO(idEmpleado),
    FOREIGN KEY (idCliente) REFERENCES CLIENTE(idCliente),
    FOREIGN KEY (idTipoEnvio) REFERENCES TIPO_ENVIO(idTipoEnvio)
);

CREATE TABLE correosTX.dbo.FACTURACION (
    idFactura INT PRIMARY KEY,
    fechaRegistro DATETIME2(7),
    costoFlete DECIMAL(10,2),
    totalSinIVA DECIMAL(10,2),
    costoIVA DECIMAL(10,2),
    totalFactura DECIMAL(10,2),
    idCliente INT,
    FOREIGN KEY (idCliente) REFERENCES CLIENTE(idCliente)
);

CREATE TABLE correosTX.dbo.DETALLE_FACTURACION (
    linea INT,
    idFactura INT,
    descripcion NVARCHAR(255),
    totalLinea DECIMAL(10,2),
    idPaquete INT,
    PRIMARY KEY (linea, idFactura),
    FOREIGN KEY (idPaquete) REFERENCES PAQUETERIA(idPaquete),
    FOREIGN KEY (idFactura) REFERENCES FACTURACION(idFactura)
);

CREATE TABLE correosTX.dbo.ESTADOS (
    idEstado INT PRIMARY KEY,
    descripcion NVARCHAR(255)
);

CREATE TABLE correosTX.dbo.HISTORIA_ESTADOS (
    idEstado INT,
    idPaquete INT,
    fechaEstado DATETIME2(7),
    PRIMARY KEY (idEstado, idPaquete),
    FOREIGN KEY (idEstado) REFERENCES ESTADOS(idEstado),
    FOREIGN KEY (idPaquete) REFERENCES PAQUETERIA(idPaquete)
);
