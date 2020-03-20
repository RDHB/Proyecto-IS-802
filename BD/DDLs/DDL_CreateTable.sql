-- -----------------------------------------------------
-- Table Persona
-- -----------------------------------------------------
CREATE TABLE Genero (
	idGenero INT NOT NULL,
	descripcion VARCHAR(45),
	PRIMARY KEY (idGenero)
)


-- <=== Create Table ===>
-- -----------------------------------------------------
-- Table Persona
-- -----------------------------------------------------
CREATE TABLE Persona (
	idPersona INT NOT NULL,
	primerNombre VARCHAR(50) NULL,
	segundoNombre VARCHAR(50) NULL,
	primerApellido VARCHAR(45) NULL,
	segundoApellido VARCHAR(45) NULL,
	correoElectronico VARCHAR(45) NULL,
	direccion VARCHAR(45) NULL,
	numeroIdentidad VARCHAR(45) NOT NULL,
	fechaIngreso DATE NULL,
	Genero_idGenero INT NOT NULL,
	PRIMARY KEY (idPersona)
)


-- -----------------------------------------------------
-- Table Aspirante
-- -----------------------------------------------------
CREATE TABLE Aspirante (
	idAspirante INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	fechaEntrevista DATETIME NULL,
	Persona_idPersona INT NOT NULL,
	PRIMARY KEY (idAspirante)
)

-- -----------------------------------------------------
-- Table Curriculum
-- -----------------------------------------------------
CREATE TABLE Curriculum (
	idCurriculum INT NOT NULL,
	nombreArchivo VARCHAR(45) NULL,
	Aspirante_idAspirante INT NOT NULL,
	PRIMARY KEY (idCurriculum)
)

-- -----------------------------------------------------
-- Table Cliente
-- -----------------------------------------------------
CREATE TABLE Cliente (
	idCliente INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	Persona_idPersona INT NOT NULL,
	PRIMARY KEY (idCliente)
)

-- -----------------------------------------------------
-- Table Cargo
-- -----------------------------------------------------
CREATE TABLE Cargo (
	idCargo INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	PRIMARY KEY (idCargo)
)


-- -----------------------------------------------------
-- Table AreaTrabajo
-- -----------------------------------------------------
CREATE TABLE AreaTrabajo (
	idAreaTrabajo INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	PRIMARY KEY (idAreaTrabajo)
)


-- -----------------------------------------------------
-- Table Marca
-- -----------------------------------------------------
CREATE TABLE Marca (
	idMarca INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	PRIMARY KEY (idMarca)
)


-- -----------------------------------------------------
-- Table Modelo
-- -----------------------------------------------------
CREATE TABLE Modelo (
	idModelo INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	Marca_idMarca INT NOT NULL,
	PRIMARY KEY (idModelo)
)


-- -----------------------------------------------------
-- Table Vehiculos
-- -----------------------------------------------------
CREATE TABLE Vehiculos (
	idVehiculos INT NOT NULL,
	vin VARCHAR(45) NULL,
	color VARCHAR(45) NULL,
	placa VARCHAR(45) NULL,
	numeroMotor VARCHAR(45) NULL,
	caja_de_cambios VARCHAR(45) NULL,
	Modelo_idModelo INT NOT NULL,
	PRIMARY KEY (idVehiculos)
)

-- -----------------------------------------------------
-- Table Inventario
-- -----------------------------------------------------
CREATE TABLE Inventario (
	idInventario INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	cantidad INT NULL,
	PRIMARY KEY (idInventario)
)


-- -----------------------------------------------------
-- Table Servicios
-- -----------------------------------------------------
CREATE TABLE Servicios (
	idServicios INT NOT NULL,
	nombre VARCHAR(45) NULL,
	precioCosto DECIMAL NULL,
	duracion TIME NULL,
	PRIMARY KEY (idServicios)
)


-- -----------------------------------------------------
-- Table Cotizacion
-- -----------------------------------------------------
CREATE TABLE Cotizacion (
	idCotizacion INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	fecha DATE NULL,
	PRIMARY KEY (idCotizacion)
)


-- -----------------------------------------------------
-- Table Permisos
-- -----------------------------------------------------
CREATE TABLE Permisos (
	idPermisos INT NOT NULL,
	motivo VARCHAR(45) NULL,
	fecha DATE NULL,
	PRIMARY KEY (idPermisos)
)


-- -----------------------------------------------------
-- Table Vacaciones
-- -----------------------------------------------------
CREATE TABLE Vacaciones (
	idVacaciones INT NOT NULL,
	cantidadDias INT NULL,
	fechaInicio DATE NULL,
	fechaFin DATE NULL,
	fechaRetorno DATE NULL,
	PRIMARY KEY (idVacaciones)
)


-- -----------------------------------------------------
-- Table Empleado
-- -----------------------------------------------------
CREATE TABLE Empleado (
	idEmpleado INT NOT NULL,
	codigoEmpleado VARCHAR(45) NOT NULL,
	descripcion VARCHAR(45) NULL,
	jefeInmediato INT NULL,
	Persona_idPersona INT NOT NULL,
	Cargo_idCargo INT NOT NULL,
	AreaTrabajo_idAreaTrabajo INT NOT NULL,
	PRIMARY KEY (idEmpleado)
)

-- -----------------------------------------------------
-- Table Solicitudes
-- -----------------------------------------------------
CREATE TABLE Solicitudes (
	idSolicitudes INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	Permisos_idPermisos INT NULL,
	Vacaciones_idVacaciones INT NULL,
	Empleado_idEmpleado INT NOT NULL,
	PRIMARY KEY (idSolicitudes)
)

-- -----------------------------------------------------
-- Table Reservacion
-- -----------------------------------------------------
CREATE TABLE Reservacion (
	idReservacion INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	cita DATETIME NULL,
	Empleado_idEmpleado INT NOT NULL,
	Cliente_idCliente INT NOT NULL,
	PRIMARY KEY (idReservacion)
)

-- -----------------------------------------------------
-- Table ListaMyR
-- -----------------------------------------------------
CREATE TABLE ListaMyR (
	idListaMyR INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	PRIMARY KEY (idListaMyR)
)


-- -----------------------------------------------------
-- Table FormaPago
-- -----------------------------------------------------
CREATE TABLE FormaPago (
	idFormaPago INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	PRIMARY KEY (idFormaPago)
)


-- -----------------------------------------------------
-- Table EstadoOT
-- -----------------------------------------------------
CREATE TABLE EstadoOT (
	idEstadoOT INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	PRIMARY KEY (idEstadoOT)
)


-- -----------------------------------------------------
-- Table OrdenTrabajo
-- -----------------------------------------------------
CREATE TABLE OrdenTrabajo (
	idOrdenTrabajo INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	estado_del_vehiculo VARCHAR(45) NULL,
	objetosPersonales VARCHAR(45) NULL,
	fechaInicio DATE NULL,
	fechaFin DATE NULL,
	reparacionesEfectuadas VARCHAR(45) NULL,
	reparacionesNoEfectuadas VARCHAR(45) NULL,
	comentarios VARCHAR(45) NULL,
	Cotizacion_idCotizacion INT NOT NULL,
	Cliente_idCliente INT NOT NULL,
	ListaMyR_idListaMyR INT NOT NULL,
	EstadoOT_idEstadoOT INT NOT NULL,
	Vehiculos_idVehiculos INT NOT NULL,
	PRIMARY KEY (idOrdenTrabajo)
)

-- -----------------------------------------------------
-- Table Promociones
-- -----------------------------------------------------
CREATE TABLE Promociones (
	idPromociones INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	fechaInicio DATE NULL,
	fechaFin DATE NULL,
	PRIMARY KEY (idPromociones)
)


-- -----------------------------------------------------
-- Table Descuento
-- -----------------------------------------------------
CREATE TABLE Descuento (
	idDescuento INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	porcentaje DECIMAL NULL,
	fecha_de_validez DATE NULL,
	PRIMARY KEY (idDescuento)
)


-- -----------------------------------------------------
-- Table Factura
-- -----------------------------------------------------
CREATE TABLE Factura (
	idFactura INT NOT NULL,
	fecha DATETIME NULL,
	precio DECIMAL NULL,
	total_a_pagar DECIMAL NULL,
	Cliente_idCliente INT NOT NULL,
	Empleado_idEmpleado INT NOT NULL,
	FormaPago_idFormaPago INT NOT NULL,
	OrdenTrabajo_idOrdenTrabajo INT NOT NULL,
	Promociones_idPromociones INT NOT NULL,
	Descuento_idDescuento INT NOT NULL,
	PRIMARY KEY (idFactura)
)

-- -----------------------------------------------------
-- Table Telefono
-- -----------------------------------------------------
CREATE TABLE Telefono (
	idTelefono INT NOT NULL,
	numeroTelefono VARCHAR(45) NULL,
	Persona_idPersona INT NOT NULL,
	PRIMARY KEY (idTelefono)
)

-- -----------------------------------------------------
-- Table VinculoCyV
-- -----------------------------------------------------
CREATE TABLE VinculoCyV (
	idVinculoCyV INT NOT NULL,
	Cliente_idCliente INT NOT NULL,
	Vehiculos_idVehiculos INT NOT NULL,
	PRIMARY KEY (idVinculoCyV)
)

-- -----------------------------------------------------
-- Table Producto
-- -----------------------------------------------------
CREATE TABLE Producto (
	idProducto INT NOT NULL,
	nombre VARCHAR(45) NULL,
	precioVenta DECIMAL NULL,
	precioCompra DECIMAL NULL,
	fechaIngreso DATE NULL,
	fechaVencimiento DATE NULL,
	Inventario_idInventario INT NOT NULL,
	PRIMARY KEY (idProducto)
)

-- -----------------------------------------------------
-- Table Inventario_has_Lista_MyR
-- -----------------------------------------------------
CREATE TABLE Inventario_has_Lista_MyR (
	idInventario_has_Lista_MyR INT NOT NULL,
	ListaMyR_idListaMyR INT NOT NULL,
	Producto_idProducto INT NOT NULL,
	rebajados_del_inventario BIT NOT NULL,
	PRIMARY KEY (idInventario_has_Lista_MyR)
)

-- -----------------------------------------------------
-- Table Recambios
-- -----------------------------------------------------
CREATE TABLE Recambios (
	idRecambios INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	Producto_idProducto INT NOT NULL,
	PRIMARY KEY (idRecambios)
)

-- -----------------------------------------------------
-- Table Materiales
-- -----------------------------------------------------
CREATE TABLE Materiales (
	idMateriales INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	Producto_idProducto INT NOT NULL,
	PRIMARY KEY (idMateriales)
)

-- -----------------------------------------------------
-- Table Herramientas
-- -----------------------------------------------------
CREATE TABLE Herramientas (
	idHerramientas INT NOT NULL,
	nombre VARCHAR(45) NULL,
	precioCosto DECIMAL NULL,
	fechaIngreso DATE NULL,
	Inventario_idInventario INT NOT NULL,
	PRIMARY KEY (idHerramientas)
)

-- -----------------------------------------------------
-- Table Huella
-- -----------------------------------------------------
CREATE TABLE Huella (
	idHuella INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	horaEntrada TIME NULL,
	horaSalida TIME NULL,
	fecha DATE NULL,
	Empleado_idEmpleado INT NOT NULL,
	PRIMARY KEY (idHuella)
)

-- -----------------------------------------------------
-- Table TipoContrato
-- -----------------------------------------------------
CREATE TABLE TipoContrato (
	idTipoContrato INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	PRIMARY KEY (idTipoContrato)
)

-- -----------------------------------------------------
-- Table ContratoPersonal
-- -----------------------------------------------------
CREATE TABLE ContratoPersonal (
	idContratoPersonal INT NOT NULL,
	fechaContrato DATE NULL,
	sueldo DECIMAL NULL,
	horaEntrada TIME NULL,
	horaSalida TIME NULL,
	TipoContrato_idTipoContrato INT NOT NULL,
	PRIMARY KEY (idContratoPersonal)
)

-- -----------------------------------------------------
-- Table Historico_Contratos
-- -----------------------------------------------------
CREATE TABLE Historico_Contratos (
	idHistorico_Contratos INT NOT NULL,
	ContratoPersonal_idContratoPersonal INT NOT NULL,
	Empleado_idEmpleado INT NOT NULL,
	PRIMARY KEY (idHistorico_Contratos)
)

-- -----------------------------------------------------
-- Table Horas_extras
-- -----------------------------------------------------
CREATE TABLE Horas_extras (
	idHoras_extras INT NOT NULL,
	horaInicio TIME NULL,
	horaFin TIME NULL,
	fecha DATE NULL,
	PRIMARY KEY (idHoras_extras)
)


-- -----------------------------------------------------
-- Table Historico_HE
-- -----------------------------------------------------
CREATE TABLE Historico_HE (
	idHistorico_HE INT NOT NULL,
	AreaTrabajo_idAreaTrabajo INT NOT NULL,
	Horas_extras_idHoras_extras INT NOT NULL,
	PRIMARY KEY (idHistorico_HE)
)

-- -----------------------------------------------------
-- Table RolPago
-- -----------------------------------------------------
CREATE TABLE RolPago (
	idRolPago INT NOT NULL,
	sueldo DECIMAL NULL,
	fecha DATE NULL,
	deducciones DECIMAL NULL,
	cantidadHT INT NULL,
	cantidadHE INT NULL,
	pagoHT DECIMAL NULL,
	pagoHE DECIMAL NULL,
	comisiones DECIMAL NULL,
	cargo VARCHAR(45) NULL,
	Empleado_idEmpleado INT NOT NULL,
	PRIMARY KEY (idRolPago)
)

-- -----------------------------------------------------
-- Table Cotizacion_has_Producto
-- -----------------------------------------------------
CREATE TABLE Cotizacion_has_Producto (
	idCotizacion_has_Producto INT NOT NULL,
	Cotizacion_idCotizacion INT NOT NULL,
	Producto_idProducto INT NOT NULL,
	aprovados BIT NOT NULL,
	PRIMARY KEY (idCotizacion_has_Producto)
)

-- -----------------------------------------------------
-- Table OrdenTrabajo_has_Servicios
-- -----------------------------------------------------
CREATE TABLE OrdenTrabajo_has_Servicios (
	OrdenTrabajo_idOrdenTrabajo INT NOT NULL,
	Servicios_idServicios INT NOT NULL,
	servicioEfectuado BIT NOT NULL,
	PRIMARY KEY (
		OrdenTrabajo_idOrdenTrabajo,
		Servicios_idServicios
	)
)

-- -----------------------------------------------------
-- Table Estado_Usuario
-- -----------------------------------------------------
CREATE TABLE Estado_Usuario (
	idEstado_Usuario INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	PRIMARY KEY (idEstado_Usuario)
)


-- -----------------------------------------------------
-- Table Usuarios
-- -----------------------------------------------------
CREATE TABLE Usuarios (
	idUsuario INT NOT NULL,
	nombreUsuario VARCHAR(45) NOT NULL,
	contrasenia VARCHAR(45) NOT NULL,
	Empleado_idEmpleado INT NOT NULL,
	Estado_Usuario_idEstado_Usuario INT NOT NULL,
	PRIMARY KEY (idUsuario)
)

-- -----------------------------------------------------
-- Table Accion
-- -----------------------------------------------------
CREATE TABLE Accion (
	idAccion INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	PRIMARY KEY (idAccion)
)


-- -----------------------------------------------------
-- Table Registro_de_Actividad
-- -----------------------------------------------------
CREATE TABLE Registro_de_Actividad (
	idRegistro_de_Actividad INT NOT NULL,
	descripcion VARCHAR(4000) NULL,
	registrosAfectados INT NULL,
	fecha DATETIME NULL,
	Accion_idAccion INT NOT NULL,
	Usuarios_idUsuarios INT NOT NULL,
	PRIMARY KEY (idRegistro_de_Actividad)
)
