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
	genero VARCHAR(45) NULL,
	fechaIngreso DATE NULL,
	PRIMARY KEY (idPersona),
	CONSTRAINT numeroIdentidad_UNIQUE UNIQUE (numeroIdentidad)
)
-- Table Persona
ALTER TABLE Persona


-- -----------------------------------------------------
-- Table Aspirante
-- -----------------------------------------------------
CREATE TABLE Aspirante (
	idAspirante INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	Persona_idPersona INT NOT NULL,
	PRIMARY KEY (idAspirante),
	CONSTRAINT fk_Aspirante_Persona1 FOREIGN KEY (Persona_idPersona) REFERENCES Persona (idPersona)
)
-- Table Aspirante
ALTER TABLE Aspirante


-- -----------------------------------------------------
-- Table Curriculum
-- -----------------------------------------------------
CREATE TABLE Curriculum (
	idCurriculum INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	Aspirante_idAspirante INT NOT NULL,
	PRIMARY KEY (idCurriculum),
	CONSTRAINT fk_Curriculum_Aspirante1 FOREIGN KEY (Aspirante_idAspirante) REFERENCES Aspirante (idAspirante)
)
-- Table Curriculum
ALTER TABLE Curriculum


-- -----------------------------------------------------
-- Table Cliente
-- -----------------------------------------------------
CREATE TABLE Cliente (
	idCliente INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	Persona_idPersona INT NOT NULL,
	PRIMARY KEY (idCliente),
	CONSTRAINT fk_Cliente_Persona1 FOREIGN KEY (Persona_idPersona) REFERENCES Persona (idPersona)
)
-- Table Cliente
ALTER TABLE Cliente


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
	Marca_idMarca INT NOT NULL,
	Modelo_idModelo INT NOT NULL,
	PRIMARY KEY (idVehiculos),
	CONSTRAINT fk_Vehiculos_Marca FOREIGN KEY (Marca_idMarca) REFERENCES Marca (idMarca),
	CONSTRAINT fk_Vehiculos_Modelo1 FOREIGN KEY (Modelo_idModelo) REFERENCES Modelo (idModelo)
)
-- Table Vehiculos
ALTER TABLE Vehiculos


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
	PRIMARY KEY (idEmpleado),
	CONSTRAINT Codigo_de_Empleado_UNIQUE UNIQUE(codigoEmpleado),
	CONSTRAINT fk_Empleado_Empleado1 FOREIGN KEY (jefeInmediato) REFERENCES Empleado (idEmpleado),
	CONSTRAINT fk_Empleado_Persona1 FOREIGN KEY (Persona_idPersona) REFERENCES Persona (idPersona),
	CONSTRAINT fk_Empleado_Cargo1 FOREIGN KEY (Cargo_idCargo) REFERENCES Cargo (idCargo),
	CONSTRAINT fk_Empleado_Area_de_Trabajo1 FOREIGN KEY (AreaTrabajo_idAreaTrabajo) REFERENCES AreaTrabajo (idAreaTrabajo)
)
-- Table Empleado
ALTER TABLE Empleado


-- -----------------------------------------------------
-- Table Solicitudes
-- -----------------------------------------------------
CREATE TABLE Solicitudes (
	idSolicitudes INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	Permisos_idPermisos INT NULL,
	Vaciones_idVaciones INT NULL,
	Empleado_idEmpleado INT NOT NULL,
	PRIMARY KEY (idSolicitudes),
	CONSTRAINT fk_Solicitudes_Permisos1 FOREIGN KEY (Permisos_idPermisos) REFERENCES Permisos (idPermisos),
	CONSTRAINT fk_Solicitudes_Vaciones1 FOREIGN KEY (Vaciones_idVaciones) REFERENCES Vacaciones (idVacaciones),
	CONSTRAINT fk_Solicitudes_Empleado1 FOREIGN KEY (Empleado_idEmpleado) REFERENCES Empleado (idEmpleado)
)
-- Table Solicitudes
ALTER TABLE Solicitudes


-- -----------------------------------------------------
-- Table Reservacion
-- -----------------------------------------------------
CREATE TABLE Reservacion (
	idReservacion INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	cita DATETIME NULL,
	Empleado_idEmpleado INT NOT NULL,
	Cliente_idCliente INT NOT NULL,
	PRIMARY KEY (idReservacion),
	CONSTRAINT fk_Reservación_Empleado1 FOREIGN KEY (Empleado_idEmpleado) REFERENCES Empleado (idEmpleado),
	CONSTRAINT fk_Reservación_Cliente1 FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente (idCliente)
)
-- Table Reservacion
ALTER TABLE Reservacion


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
	PRIMARY KEY (idOrdenTrabajo),
	CONSTRAINT fk_Orden_de_Trabajo_Cotizacion1 FOREIGN KEY (Cotizacion_idCotizacion) REFERENCES Cotizacion (idCotizacion),
	CONSTRAINT fk_Orden_de_Trabajo_Cliente1 FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente (idCliente),
	CONSTRAINT fk_Orden_de_Trabajo_Lista_MyR1 FOREIGN KEY (ListaMyR_idListaMyR) REFERENCES ListaMyR (idListaMyR),
	CONSTRAINT fk_Orden_de_Trabajo_EstadoOT1 FOREIGN KEY (EstadoOT_idEstadoOT) REFERENCES EstadoOT (idEstadoOT),
	CONSTRAINT fk_Orden_de_Trabajo_Vehiculos1 FOREIGN KEY (Vehiculos_idVehiculos) REFERENCES Vehiculos (idVehiculos)
)
-- Table OrdenTrabajo
ALTER TABLE OrdenTrabajo


-- -----------------------------------------------------
-- Table Promociones
-- -----------------------------------------------------
CREATE TABLE Promociones (
	idPromociones INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	fechaInicio DATE NULL,
	fechaFin DATE NULL,
	estado VARCHAR(45) NULL,
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
	PRIMARY KEY (idFactura),
	CONSTRAINT fk_Factura_Cliente1 FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente (idCliente),
	CONSTRAINT fk_Factura_Empleado1 FOREIGN KEY (Empleado_idEmpleado) REFERENCES Empleado (idEmpleado),
	CONSTRAINT fk_Factura_FormaPago1 FOREIGN KEY (FormaPago_idFormaPago) REFERENCES FormaPago (idFormaPago),
	CONSTRAINT fk_Factura_Orden_de_Trabajo1 FOREIGN KEY (OrdenTrabajo_idOrdenTrabajo) REFERENCES OrdenTrabajo (idOrdenTrabajo),
	CONSTRAINT fk_Factura_Promociones1 FOREIGN KEY (Promociones_idPromociones) REFERENCES Promociones (idPromociones),
	CONSTRAINT fk_Factura_Descuento1 FOREIGN KEY (Descuento_idDescuento) REFERENCES Descuento (idDescuento)
)
-- Table Factura
ALTER TABLE Factura


-- -----------------------------------------------------
-- Table Telefono
-- -----------------------------------------------------
CREATE TABLE Telefono (
	idTelefono INT NOT NULL,
	numeroTelefono VARCHAR(45) NULL,
	Persona_idPersona INT NOT NULL,
	PRIMARY KEY (idTelefono),
	CONSTRAINT fk_Teléfono_Persona1 FOREIGN KEY (Persona_idPersona) REFERENCES Persona (idPersona)
)
-- Table Telefono
ALTER TABLE Telefono


-- -----------------------------------------------------
-- Table VinculoCyV
-- -----------------------------------------------------
CREATE TABLE VinculoCyV (
	idVinculoCyV INT NOT NULL,
	Cliente_idCliente INT NOT NULL,
	Vehiculos_idVehiculos INT NOT NULL,
	PRIMARY KEY (idVinculoCyV),
	CONSTRAINT fk_Vehiculos_has_Cliente_Cliente1 FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente (idCliente),
	CONSTRAINT fk_Vehiculos_has_Cliente_Vehiculos1 FOREIGN KEY (Vehiculos_idVehiculos) REFERENCES Vehiculos (idVehiculos)
)
-- Table VinculoCyV
ALTER TABLE VinculoCyV


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
	PRIMARY KEY (idProducto),
	CONSTRAINT fk_Producto_Inventario1 FOREIGN KEY (Inventario_idInventario) REFERENCES Inventario (idInventario)
)
-- Table Producto
ALTER TABLE Producto


-- -----------------------------------------------------
-- Table Inventario_has_Lista_MyR
-- -----------------------------------------------------
CREATE TABLE Inventario_has_Lista_MyR (
	idInventario_has_Lista_MyR INT NOT NULL,
	ListaMyR_idListaMyR INT NOT NULL,
	Producto_idProducto INT NOT NULL,
	rebajados_del_inventario TINYINT NOT NULL,
	PRIMARY KEY (idInventario_has_Lista_MyR),
	CONSTRAINT fk_Inventario_has_Lista_MyR_Lista_MyR1 FOREIGN KEY (ListaMyR_idListaMyR) REFERENCES ListaMyR (idListaMyR),
	CONSTRAINT fk_Inventario_has_Lista_MyR_Producto1 FOREIGN KEY (Producto_idProducto) REFERENCES Producto (idProducto)
)
-- Table Inventario_has_Lista_MyR
ALTER TABLE Inventario_has_Lista_MyR


-- -----------------------------------------------------
-- Table Recambios
-- -----------------------------------------------------
CREATE TABLE Recambios (
	idRecambios INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	Producto_idProducto INT NOT NULL,
	PRIMARY KEY (idRecambios),
	CONSTRAINT fk_Recambios_Producto1 FOREIGN KEY (Producto_idProducto) REFERENCES Producto (idProducto)
)
-- Table Recambios
ALTER TABLE Recambios


-- -----------------------------------------------------
-- Table Materiales
-- -----------------------------------------------------
CREATE TABLE Materiales (
	idMateriales INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	Producto_idProducto INT NOT NULL,
	PRIMARY KEY (idMateriales),
	CONSTRAINT fk_Materiales_Producto1 FOREIGN KEY (Producto_idProducto) REFERENCES Producto (idProducto)
)
-- Table Materiales
ALTER TABLE Materiales


-- -----------------------------------------------------
-- Table Herramientas
-- -----------------------------------------------------
CREATE TABLE Herramientas (
	idHerramientas INT NOT NULL,
	nombre VARCHAR(45) NULL,
	precioCosto DECIMAL NULL,
	fechaIngreso DATE NULL,
	Inventario_idInventario INT NOT NULL,
	PRIMARY KEY (idHerramientas),
	CONSTRAINT fk_Herramientas_Inventario1 FOREIGN KEY (Inventario_idInventario) REFERENCES Inventario (idInventario)
)
-- Table Herramientas
ALTER TABLE Herramientas


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
	PRIMARY KEY (idHuella),
	CONSTRAINT fk_Huella_Empleado1 FOREIGN KEY (Empleado_idEmpleado) REFERENCES Empleado (idEmpleado)
)
-- Table Huella
ALTER TABLE Huella


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
	PRIMARY KEY (idContratoPersonal),
	CONSTRAINT fk_Contratos_de_Personal_TipoContrato1 FOREIGN KEY (TipoContrato_idTipoContrato) REFERENCES TipoContrato (idTipoContrato)
)
-- Table ContratoPersonal
ALTER TABLE ContratoPersonal


-- -----------------------------------------------------
-- Table EntrevistaTrabajo
-- -----------------------------------------------------
CREATE TABLE EntrevistaTrabajo (
	idEntrevistaTrabajo INT NOT NULL,
	fechaHora DATETIME NULL,
	Curriculum_idCurriculum INT NOT NULL,
	PRIMARY KEY (idEntrevistaTrabajo),
	CONSTRAINT fk_EntrevistaTrabajo_Curriculum1 FOREIGN KEY (Curriculum_idCurriculum) REFERENCES Curriculum (idCurriculum)
)
-- Table EntrevistaTrabajo
ALTER TABLE EntrevistaTrabajo


-- -----------------------------------------------------
-- Table Historico_Contratos
-- -----------------------------------------------------
CREATE TABLE Historico_Contratos (
	idHistorico_Contratos INT NOT NULL,
	ContratoPersonal_idContratoPersonal INT NOT NULL,
	Empleado_idEmpleado INT NOT NULL,
	PRIMARY KEY (idHistorico_Contratos),
	CONSTRAINT fk_Historico_Contratos_Contratos_de_Personal1 FOREIGN KEY (ContratoPersonal_idContratoPersonal) REFERENCES ContratoPersonal (idContratoPersonal),
	CONSTRAINT fk_Historico_Contratos_Empleado1 FOREIGN KEY (Empleado_idEmpleado) REFERENCES Empleado (idEmpleado)
)
-- Table Historico_Contratos
ALTER TABLE Historico_Contratos


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
	PRIMARY KEY (idHistorico_HE),
	CONSTRAINT fk_Historico_HorasExtras_Area_de_Trabajo1 FOREIGN KEY (AreaTrabajo_idAreaTrabajo) REFERENCES AreaTrabajo (idAreaTrabajo),
	CONSTRAINT fk_Historico_HorasExtras_Horas_extras1 FOREIGN KEY (Horas_extras_idHoras_extras) REFERENCES Horas_extras (idHoras_extras)
)
-- Table Historico_HE
ALTER TABLE Historico_HE


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
	PRIMARY KEY (idRolPago),
	CONSTRAINT fk_RolPago_Empleado1 FOREIGN KEY (Empleado_idEmpleado) REFERENCES Empleado (idEmpleado)
)
-- Table RolPago
ALTER TABLE RolPago


-- -----------------------------------------------------
-- Table Cotizacion_has_Producto
-- -----------------------------------------------------
CREATE TABLE Cotizacion_has_Producto (
	idCotizacion_has_Producto INT NOT NULL,
	Cotizacion_idCotizacion INT NOT NULL,
	Producto_idProducto INT NOT NULL,
	aprovados TINYINT NOT NULL,
	PRIMARY KEY (idCotizacion_has_Producto),
	CONSTRAINT fk_Cotizacion_has_Producto_Cotizacion1 FOREIGN KEY (Cotizacion_idCotizacion) REFERENCES Cotizacion (idCotizacion),
	CONSTRAINT fk_Cotizacion_has_Producto_Producto1 FOREIGN KEY (Producto_idProducto) REFERENCES Producto (idProducto)
)
-- Table Cotizacion_has_Producto
ALTER TABLE Cotizacion_has_Producto


-- -----------------------------------------------------
-- Table OrdenTrabajo_has_Servicios
-- -----------------------------------------------------
CREATE TABLE OrdenTrabajo_has_Servicios (
	OrdenTrabajo_idOrdenTrabajo INT NOT NULL,
	Servicios_idServicios INT NOT NULL,
	servicioEfectuado TINYINT NOT NULL,
	PRIMARY KEY (
		OrdenTrabajo_idOrdenTrabajo,
		Servicios_idServicios
	),
	CONSTRAINT fk_Orden_de_Trabajo_has_Servicios_Orden_de_Trabajo1 FOREIGN KEY (OrdenTrabajo_idOrdenTrabajo) REFERENCES OrdenTrabajo (idOrdenTrabajo),
	CONSTRAINT fk_Orden_de_Trabajo_has_Servicios_Servicios1 FOREIGN KEY (Servicios_idServicios) REFERENCES Servicios (idServicios)
)
-- Table OrdenTrabajo_has_Servicios
ALTER TABLE OrdenTrabajo_has_Servicios


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
	contraseña VARCHAR(45) NOT NULL,
	Empleado_idEmpleado INT NOT NULL,
	Estado_Usuario_idEstado_Usuario INT NOT NULL,
	PRIMARY KEY (idUsuario),
	CONSTRAINT NombreUsuario_UNIQUE UNIQUE(nombreUsuario),
	CONSTRAINT fk_Usuarios_Empleado1 FOREIGN KEY (Empleado_idEmpleado) REFERENCES Empleado (idEmpleado),
	CONSTRAINT fk_Usuarios_Estado_Usuario1 FOREIGN KEY (Estado_Usuario_idEstado_Usuario) REFERENCES Estado_Usuario (idEstado_Usuario)
)
-- Table Usuarios
ALTER TABLE Usuarios


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
	PRIMARY KEY (idRegistro_de_Actividad),
	CONSTRAINT fk_Registro_de_Actividad_Accion1 FOREIGN KEY (Accion_idAccion) REFERENCES Accion (idAccion),
	CONSTRAINT fk_Registro_de_Actividad_Usuarios1 FOREIGN KEY (Usuarios_idUsuarios) REFERENCES Usuarios (idUsuario)
)
-- Table Registro_de_Actividad
ALTER TABLE Registro_de_Actividad
