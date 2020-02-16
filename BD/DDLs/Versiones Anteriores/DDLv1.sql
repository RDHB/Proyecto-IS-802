-- -----------------------------------------------------
-- Table Persona
-- -----------------------------------------------------
CREATE TABLE Persona (
	idPersona INT NOT NULL,
	primerNombre VARCHAR(50) NULL,
	segundoNombre VARCHAR(50) NULL,
	primerApellido VARCHAR(45) NULL,
	segundoApellido VARCHAR(45) NULL,
	correo_Electronico VARCHAR(45) NULL,
	direccion VARCHAR(45) NULL,
	numeroIdentidad VARCHAR(45) NOT NULL,
	Genero VARCHAR(45) NULL,
	Fecha_de_Ingreso DATE NULL,
	PRIMARY KEY (idPersona)
);

-- -----------------------------------------------------
-- Table Aspirante
-- -----------------------------------------------------
CREATE TABLE Aspirante (
	idAspirante INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	Persona_idPersona INT NOT NULL,
	PRIMARY KEY (idAspirante)
	
);

-- -----------------------------------------------------
-- Table Curriculum
-- -----------------------------------------------------
CREATE TABLE Curriculum (
	idCurriculum INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	Aspirante_idAspirante INT NOT NULL,
	PRIMARY KEY (idCurriculum)
);

-- -----------------------------------------------------
-- Table Cliente
-- -----------------------------------------------------
CREATE TABLE Cliente (
	idCliente INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	Persona_idPersona INT NOT NULL,
	PRIMARY KEY (idCliente)
);

-- -----------------------------------------------------
-- Table Cargo
-- -----------------------------------------------------
CREATE TABLE Cargo (
	idCargo INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	PRIMARY KEY (idCargo)
);


-- -----------------------------------------------------
-- Table Area_de_Trabajo
-- -----------------------------------------------------
CREATE TABLE Area_de_Trabajo (
	idArea_de_Trabajo INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	PRIMARY KEY (idArea_de_Trabajo)
);


-- -----------------------------------------------------
-- Table Marca
-- -----------------------------------------------------
CREATE TABLE Marca (
	idMarca INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	PRIMARY KEY (idMarca)
);


-- -----------------------------------------------------
-- Table Modelo
-- -----------------------------------------------------
CREATE TABLE Modelo (
	idModelo INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	PRIMARY KEY (idModelo)
);


-- -----------------------------------------------------
-- Table Vehiculos
-- -----------------------------------------------------
CREATE TABLE Vehiculos (
	idVehiculos INT NOT NULL,
	Vin VARCHAR(45) NULL,
	Color VARCHAR(45) NULL,
	Placa VARCHAR(45) NULL,
	numeroMotoe VARCHAR(45) NULL,
	caja_de_cambios VARCHAR(45) NULL,
	Marca_idMarca INT NOT NULL,
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
);


-- -----------------------------------------------------
-- Table Servicios
-- -----------------------------------------------------
CREATE TABLE Servicios (
	idServicios INT NOT NULL,
	nombre VARCHAR(45) NULL,
	precioCosto DECIMAL NULL,
	duracion TIME NULL,
	PRIMARY KEY (idServicios)
);


-- -----------------------------------------------------
-- Table Cotizacion
-- -----------------------------------------------------
CREATE TABLE Cotizacion (
	idCotizacion INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	Fecha DATE NULL,
	PRIMARY KEY (idCotizacion)
);


-- -----------------------------------------------------
-- Table Permisos
-- -----------------------------------------------------
CREATE TABLE Permisos (
	idPermisos INT NOT NULL,
	motivo VARCHAR(45) NULL,
	fecha DATE NULL,
	PRIMARY KEY (idPermisos)
);


-- -----------------------------------------------------
-- Table Vacaciones
-- -----------------------------------------------------
CREATE TABLE Vacaciones (
	idVacaciones INT NOT NULL,
	Cantidad_de_Dias INT NULL,
	FechaInicio DATE NULL,
	FechaFin DATE NULL,
	Fecha_de_retorno DATE NULL,
	PRIMARY KEY (idVacaciones)
);


-- -----------------------------------------------------
-- Table Empleado
-- -----------------------------------------------------
CREATE TABLE Empleado (
	idEmpleado INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	JefeInmediato INT NULL,
	Persona_idPersona INT NOT NULL,
	Cargo_idCargo INT NOT NULL,
	Area_de_Trabajo_idArea_de_Trabajo INT NOT NULL,
	Codigo_de_Empleado VARCHAR(45) NOT NULL,
	PRIMARY KEY (idEmpleado)
);

-- -----------------------------------------------------
-- Table Solicitudes
-- -----------------------------------------------------
CREATE TABLE Solicitudes (
	idSolicitudes INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	Permisos_idPermisos INT NULL,
	Vaciones_idVaciones INT NULL,
	Empleado_idEmpleado INT NOT NULL,
	PRIMARY KEY (idSolicitudes)
);

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
);

-- -----------------------------------------------------
-- Table Lista_MyR
-- -----------------------------------------------------
CREATE TABLE Lista_MyR (
	idLista_MyR INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	PRIMARY KEY (idLista_MyR)
);


-- -----------------------------------------------------
-- Table FormaPago
-- -----------------------------------------------------
CREATE TABLE FormaPago (
	idFormaPago INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	PRIMARY KEY (idFormaPago)
);


-- -----------------------------------------------------
-- Table Estado_OT
-- -----------------------------------------------------
CREATE TABLE Estado_OT (
	idEstado_OT INT NOT NULL,
	Descripcion VARCHAR(45) NULL,
	PRIMARY KEY (idEstado_OT)
);


-- -----------------------------------------------------
-- Table Orden_de_Trabajo
-- -----------------------------------------------------
CREATE TABLE Orden_de_Trabajo (
	idOrden_de_Trabajo INT NOT NULL,
	Descripcion VARCHAR(45) NULL,
	Cotizacion_idCotizacion INT NOT NULL,
	Cliente_idCliente INT NOT NULL,
	Lista_MyR_idLista_MyR INT NOT NULL,
	Estado_OT_idEstado_OT INT NOT NULL,
	Vehiculos_idVehiculos INT NOT NULL,
	Reparaciones_Efectuadas VARCHAR(45) NULL,
	Reparaciones_no_Efectuadas VARCHAR(45) NULL,
	Imprevistos VARCHAR(45) NULL,
	Sugerencias_a_Imprevistos VARCHAR(45) NULL,
	Otros_Comentarios VARCHAR(45) NULL,
	Fecha_Inicio DATE NULL,
	Fecha_Fin DATE NULL,
	PRIMARY KEY (idOrden_de_Trabajo)
);

-- -----------------------------------------------------
-- Table Promociones
-- -----------------------------------------------------
CREATE TABLE Promociones (
	idPromociones INT NOT NULL,
	Descripcion VARCHAR(45) NULL,
	FechaInicio DATE NULL,
	FechaFin DATE NULL,
	Estado VARCHAR(45) NULL,
	PRIMARY KEY (idPromociones)
);


-- -----------------------------------------------------
-- Table Factura
-- -----------------------------------------------------
CREATE TABLE Factura (
	idFactura INT NOT NULL,
	fecha DATETIME NULL,
	precio DECIMAL NULL,
	Cliente_idCliente INT NOT NULL,
	Empleado_idEmpleado INT NOT NULL,
	FormaPago_idFormaPago INT NOT NULL,
	Orden_de_Trabajo_idOrden_de_Trabajo INT NOT NULL,
	Promociones_idPromociones INT NOT NULL,
	Total_a_Pagar DECIMAL NULL,
	PRIMARY KEY (idFactura)
)

-- ----------------------------------------------------
-- Taile Telefono
-- ----------------------------------------------------
CREATE TABLE Telefono (
	idTelifeno INT NOT NULL,
	numero_eelefonico VARCHAR(45) NULL,
	Persona_idPersona INT NOT NULL,
)

-- -----------------------------------------------------
CREATE TABLE VinculoCyV (
	idVinculoCyV INT NOT NULL,
	Cliente_idCliente INT NOT NULL,
	Vehiculos_idVehiculos INT NOT NULL,
	PRIMARY KEY (idVinculoCyV)
);


-- -----------------------------------------------------
-- Table Producto
-- -----------------------------------------------------
CREATE TABLE Producto (
	idProducto INT NOT NULL,
	nombre VARCHAR(45) NULL,
	precioVenta DECIMAL NULL,
	precioCompra DECIMAL NULL,
	FechaIngreso DATE NULL,
	FechaVencimiento DATE NULL,
	Inventario_idInventario INT NOT NULL,
	PRIMARY KEY (idProducto)
);


-- -----------------------------------------------------
-- Table Inventario_has_Lista_MyR
-- -----------------------------------------------------
CREATE TABLE Inventario_has_Lista_MyR (
	idInventario_has_Lista_MyR INT NOT NULL,
	Lista_MyR_idLista_MyR INT NOT NULL,
	Producto_idProducto INT NOT NULL,
	Rebajados_del_Inventario TINYINT NOT NULL,
	PRIMARY KEY (idInventario_has_Lista_MyR)
);


-- -----------------------------------------------------
-- Table Recambios
-- -----------------------------------------------------
CREATE TABLE Recambios (
	idRecambios INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	Producto_idProducto INT NOT NULL,
	PRIMARY KEY (idRecambios)
);


-- -----------------------------------------------------
-- Table Materiales
-- -----------------------------------------------------
CREATE TABLE Materiales (
	idMateriales INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	Producto_idProducto INT NOT NULL,
	PRIMARY KEY (idMateriales)
);


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
);


-- -----------------------------------------------------
-- Table Huella
-- -----------------------------------------------------
CREATE TABLE Huella (
	idHuella INT NOT NULL,
	descripcion VARCHAR(45) NULL,
	HoraEntrada TIME NULL,
	HoraSalida TIME NULL,
	Fecha DATE NULL,
	Empleado_idEmpleado INT NOT NULL,
	PRIMARY KEY (idHuella)
);


-- -----------------------------------------------------
-- Table TipoContrato
-- -----------------------------------------------------
CREATE TABLE TipoContrato (
	idTipoContrato INT NOT NULL,
	Temporal VARCHAR(45) NULL,
	Permanente VARCHAR(45) NULL,
	PRIMARY KEY (idTipoContrato)
);


-- -----------------------------------------------------
-- Table Contratos_de_Personal
-- -----------------------------------------------------
CREATE TABLE Contratos_de_Personal (
	idContratos_de_Personal INT NOT NULL,
	Fecha_de_Contrato DATE NULL,
	Sueldo DECIMAL NULL,
	horaEntrada TIME NULL,
	horaSalida TIME NULL,
	TipoContrato_idTipoContrato INT NOT NULL,
	PRIMARY KEY (idContratos_de_Personal)
);


-- -----------------------------------------------------
-- Table EntrevistaTrabajo
-- -----------------------------------------------------
CREATE TABLE EntrevistaTrabajo (
	idEntrevistaTrabajo INT NOT NULL,
	Hora_Fecha DATETIME NULL,
	Curriculum_idCurriculum INT NOT NULL,
	PRIMARY KEY (idEntrevistaTrabajo)
);


-- -----------------------------------------------------
-- Table Historico_Contratos
-- -----------------------------------------------------
CREATE TABLE Historico_Contratos (
	idHistorico_Contratos INT NOT NULL,
	Contratos_de_Personal_idContratos_de_Personal INT NOT NULL,
	Empleado_idEmpleado INT NOT NULL,
	PRIMARY KEY (idHistorico_Contratos)
);


-- -----------------------------------------------------
-- Table Horas_extras
-- -----------------------------------------------------
CREATE TABLE Horas_extras (
	idHoras_extras INT NOT NULL,
	HoraInicio TIME NULL,
	HoraFin TIME NULL,
	Fecha DATE NULL,
	PRIMARY KEY (idHoras_extras)
);


-- -----------------------------------------------------
-- Table Historico_HorasExtras
-- -----------------------------------------------------
CREATE TABLE Historico_HorasExtras (
	idHistorico_HorasExtras INT NOT NULL,
	Area_de_Trabajo_idArea_de_Trabajo INT NOT NULL,
	Horas_extras_idHoras_extras INT NOT NULL,
	PRIMARY KEY (idHistorico_HorasExtras)
);


-- -----------------------------------------------------
-- Table RolPago
-- -----------------------------------------------------
CREATE TABLE RolPago (
	idRolPago INT NOT NULL,
	Sueldo DECIMAL NULL,
	Fecha DATE NULL,
	Deducciones DECIMAL NULL,
	Cantidad_de_HT INT NULL,
	Cantidad_de_HE INT NULL,
	Pago_de_HT DECIMAL NULL,
	Pago_de_HE DECIMAL NULL,
	Comisiones DECIMAL NULL,
	Cargo VARCHAR(45) NULL,
	Empleado_idEmpleado INT NOT NULL,
	PRIMARY KEY (idRolPago)
);


-- -----------------------------------------------------
-- Table Cotizacion_has_Producto
-- -----------------------------------------------------
CREATE TABLE Cotizacion_has_Producto (
	idCotizacion_has_Producto INT NOT NULL,
	Cotizacion_idCotizacion INT NOT NULL,
	Producto_idProducto INT NOT NULL,
	Aprovados TINYINT NOT NULL,
	PRIMARY KEY (idCotizacion_has_Producto)
);


-- -----------------------------------------------------
-- Table Orden_de_Trabajo_has_Servicios
-- -----------------------------------------------------
CREATE TABLE Orden_de_Trabajo_has_Servicios (
	Orden_de_Trabajo_idOrden_de_Trabajo INT NOT NULL,
	Servicios_idServicios INT NOT NULL,
	Servicio_Efectuado TINYINT NOT NULL,
	PRIMARY KEY (Orden_de_Trabajo_idOrden_de_Trabajo, Servicios_idServicios)
);


-- -----------------------------------------------------
-- Table Estado_Usuario
-- -----------------------------------------------------
CREATE TABLE Estado_Usuario (
	idEstado_Usuario INT NOT NULL,
	Descripcion VARCHAR(45) NULL,
	PRIMARY KEY (idEstado_Usuario)
);


-- -----------------------------------------------------
-- Table Usuarios
-- -----------------------------------------------------
CREATE TABLE Usuarios (
	idUsuarios INT NOT NULL,
	Empleado_idEmpleado INT NOT NULL,
	Contraseña VARCHAR(45) NOT NULL,
	Estado_Usuario_idEstado_Usuario INT NOT NULL,
	PRIMARY KEY (idUsuarios)
);


-- -----------------------------------------------------
-- Table Accion
-- -----------------------------------------------------
CREATE TABLE Accion (
	idAccion INT NOT NULL,
	Descripcion VARCHAR(45) NULL,
	PRIMARY KEY (idAccion)
);


-- -----------------------------------------------------
-- Table Registro_de_Actividad
-- -----------------------------------------------------
CREATE TABLE Registro_de_Actividad (
	idRegistro_de_Actividad INT NOT NULL,
	Descripcion VARCHAR(4000) NULL,
	Registros_Afectados INT NULL,
	Fecha DATETIME NULL,
	Accion_idAccion INT NOT NULL,
	Usuarios_idUsuarios INT NOT NULL,
	PRIMARY KEY (idRegistro_de_Actividad)
);


-- -----------------------------------------------------
-- Table Descuento
-- -----------------------------------------------------
CREATE TABLE Descuento (
	idDescuento INT NOT NULL,
	Descripcion VARCHAR(45) NULL,
	Porcentaje DECIMAL NULL,
	Fecha_de_Validez DATE NULL,
	PRIMARY KEY (idDescuento)
);


-- -----------------------------------------------------
-- Table Descuento_has_Factura
-- -----------------------------------------------------
CREATE TABLE Descuento_has_Factura (
	Descuento_idDescuento INT NOT NULL,
	Factura_idFactura INT NOT NULL,
	PRIMARY KEY (Descuento_idDescuento, Factura_idFactura)
);


--<===LLaves Foraneas===>
ALTER TABLE Persona ADD
	CONSTRAINT numeroIdentidad_UNIQUE
	UNIQUE (numeroIdentidad)

ALTER TABLE Aspirante ADD
	CONSTRAINT fk_Aspirante_Persona1
		FOREIGN KEY (Persona_idPersona)
		REFERENCES Persona (idPersona)

ALTER TABLE Curriculum ADD
	CONSTRAINT fk_Curriculum_Aspirante1
		FOREIGN KEY (Aspirante_idAspirante)
		REFERENCES Aspirante (idAspirante)

ALTER TABLE Cliente Add
	CONSTRAINT fk_Cliente_Persona1
		FOREIGN KEY (Persona_idPersona)
		REFERENCES Persona (idPersona)

ALTER TABLE Vehiculos ADD
	CONSTRAINT fk_Vehiculos_Marca
		FOREIGN KEY (Marca_idMarca)
		REFERENCES Marca (idMarca),
	CONSTRAINT fk_Vehiculos_Modelo1
		FOREIGN KEY (Modelo_idModelo)
		REFERENCES Modelo (idModelo)


ALTER TABLE Empleado ADD
	CONSTRAINT fk_Empleado_Empleado1
		FOREIGN KEY (JefeInmediato)
		REFERENCES Empleado (idEmpleado),
	CONSTRAINT fk_Empleado_Persona1
		FOREIGN KEY (Persona_idPersona)
		REFERENCES Persona (idPersona),
	CONSTRAINT fk_Empleado_Cargo1
		FOREIGN KEY (Cargo_idCargo)
		REFERENCES Cargo (idCargo),
	CONSTRAINT fk_Empleado_Area_de_Trabajo1
		FOREIGN KEY (Area_de_Trabajo_idArea_de_Trabajo)
		REFERENCES Area_de_Trabajo (idArea_de_Trabajo),
	CONSTRAINT Codigo_de_Empleado_UNIQUE
  		UNIQUE (Codigo_de_Empleado)

ALTER TABLE Solicitudes ADD
	CONSTRAINT fk_Solicitudes_Permisos1
		FOREIGN KEY (Permisos_idPermisos)
		REFERENCES Permisos (idPermisos),
	CONSTRAINT fk_Solicitudes_Vaciones1
		FOREIGN KEY (Vaciones_idVaciones)
		REFERENCES Vacaciones (idVacaciones),
	CONSTRAINT fk_Solicitudes_Empleado1
		FOREIGN KEY (Empleado_idEmpleado)
		REFERENCES Empleado (idEmpleado)

ALTER TABLE Reservacion ADD
	CONSTRAINT fk_Reservacion_Empleado1
		FOREIGN KEY (Empleado_idEmpleado)
		REFERENCES Empleado (idEmpleado),
	CONSTRAINT fk_Reservacion_Cliente1
		FOREIGN KEY (Cliente_idCliente)
		REFERENCES Cliente (idCliente)

ALTER TABLE Orden_de_Trabajo ADD
	CONSTRAINT fk_Orden_de_Trabajo_Cotizacion1
		FOREIGN KEY (Cotizacion_idCotizacion)
		REFERENCES Cotizacion (idCotizacion),
	CONSTRAINT fk_Orden_de_Trabajo_Cliente1
		FOREIGN KEY (Cliente_idCliente)
		REFERENCES Cliente (idCliente),
	CONSTRAINT fk_Orden_de_Trabajo_Lista_MyR1
		FOREIGN KEY (Lista_MyR_idLista_MyR)
		REFERENCES Lista_MyR (idLista_MyR),
	CONSTRAINT fk_Orden_de_Trabajo_Estado_OT1
		FOREIGN KEY (Estado_OT_idEstado_OT)
		REFERENCES Estado_OT (idEstado_OT),
	CONSTRAINT fk_Orden_de_Trabajo_Vehiculos1
		FOREIGN KEY (Vehiculos_idVehiculos)
		REFERENCES Vehiculos (idVehiculos)

ALTER TABLE Factura ADD
	CONSTRAINT fk_Factura_Cliente1
		FOREIGN KEY (Cliente_idCliente)
		REFERENCES Cliente (idCliente),
	CONSTRAINT fk_Factura_Empleado1
		FOREIGN KEY (Empleado_idEmpleado)
		REFERENCES Empleado (idEmpleado),
	CONSTRAINT fk_Factura_FormaPago1
		FOREIGN KEY (FormaPago_idFormaPago)
		REFERENCES FormaPago (idFormaPago),
	CONSTRAINT fk_Factura_Orden_de_Trabajo1
		FOREIGN KEY (Orden_de_Trabajo_idOrden_de_Trabajo)
		REFERENCES Orden_de_Trabajo (idOrden_de_Trabajo),
	CONSTRAINT fk_Factura_Promociones1
		FOREIGN KEY (Promociones_idPromociones)
		REFERENCES Promociones (idPromociones)

ALTER TABLE Telefono ADD
	CONSTRAINT fk_Telefono_Persona1
		FOREIGN KEY (Persona_idPersona)
		REFERENCeS Persona (idPersona)

ALTER TABLE VinculoCyV ADD
	CONSTRAINT fk_Cliente_has_Vehiculos_Cliente1
		FOREIGN KEY (Cliente_idCliente)
		REFERENCES Cliente (idCliente),
	CONSTRAINT fk_Vehiculos_has_Cliente_Vehiculos1
		FOREIGN KEY (Vehiculos_idVehiculos)
		REFERENCES Vehiculos (idVehiculos)

ALTER TABLE Producto ADD
	CONSTRAINT fk_Producto_Inventario1
		FOREIGN KEY (Inventario_idInventario)
		REFERENCES Inventario (idInventario)

ALTER TABLE Inventario_has_Lista_MyR ADD
	CONSTRAINT fk_Inventario_has_Lista_MyR_Lista_MyR1
		FOREIGN KEY (Lista_MyR_idLista_MyR)
		REFERENCES Lista_MyR (idLista_MyR),
	CONSTRAINT fk_Inventario_has_Lista_MyR_Producto1
		FOREIGN KEY (Producto_idProducto)
		REFERENCES Producto (idProducto)

ALTER TABLE Recambios ADD
	CONSTRAINT fk_Recambios_Producto1
		FOREIGN KEY (Producto_idProducto)
		REFERENCES Producto (idProducto)

ALTER TABLE Materiales ADD
	CONSTRAINT fk_Materiales_Producto1
		FOREIGN KEY (Producto_idProducto)
		REFERENCES Producto (idProducto)

ALTER TABLE Herramientas ADD
	CONSTRAINT fk_Herramientas_Inventario1
		FOREIGN KEY (Inventario_idInventario)
		REFERENCES Inventario (idInventario)

ALTER TABLE Huella ADD
	CONSTRAINT fk_Huella_Empleado1
		FOREIGN KEY (Empleado_idEmpleado)
		REFERENCES Empleado (idEmpleado)

ALTER TABLE Contratos_de_Personal ADD
	CONSTRAINT fk_Contratos_de_Personal_TipoContrato1
		FOREIGN KEY (TipoContrato_idTipoContrato)
		REFERENCES TipoContrato (idTipoContrato)

ALTER TABLE EntrevistaTrabajo ADD
	CONSTRAINT fk_EntrevistaTrabajo_Curriculum1
		FOREIGN KEY (Curriculum_idCurriculum)
		REFERENCES Curriculum (idCurriculum)

ALTER TABLE Historico_Contratos ADD
	CONSTRAINT fk_Historico_Contratos_Contratos_de_Personal1
		FOREIGN KEY (Contratos_de_Personal_idContratos_de_Personal)
		REFERENCES Contratos_de_Personal (idContratos_de_Personal),
	CONSTRAINT fk_Historico_Contratos_Empleado1
		FOREIGN KEY (Empleado_idEmpleado)
		REFERENCES Empleado (idEmpleado)

ALTER TABLE Historico_HorasExtras ADD
	CONSTRAINT fk_Historico_HorasExtras_Area_de_Trabajo1
		FOREIGN KEY (Area_de_Trabajo_idArea_de_Trabajo)
		REFERENCES Area_de_Trabajo (idArea_de_Trabajo),
	CONSTRAINT fk_Historico_HorasExtras_Horas_extras1
		FOREIGN KEY (Horas_extras_idHoras_extras)
		REFERENCES Horas_extras (idHoras_extras)

ALTER TABLE RolPago ADD
	CONSTRAINT fk_RolPago_Empleado1
		FOREIGN KEY (Empleado_idEmpleado)
		REFERENCES Empleado (idEmpleado)

ALTER TABLE Cotizacion_has_producto ADD
	CONSTRAINT fk_Cotizacion_has_Producto_Cotizacion1
		FOREIGN KEY (Cotizacion_idCotizacion)
		REFERENCES Cotizacion (idCotizacion),
	CONSTRAINT fk_Cotizacion_has_Producto_Producto1
		FOREIGN KEY (Producto_idProducto)
		REFERENCES Producto (idProducto)

ALTER TABLE Orden_de_Trabajo_has_Servicios ADD
	CONSTRAINT fk_Orden_de_Trabajo_has_Servicios_Orden_de_Trabajo1
		FOREIGN KEY (Orden_de_Trabajo_idOrden_de_Trabajo)
		REFERENCES Orden_de_Trabajo (idOrden_de_Trabajo),
	CONSTRAINT fk_Orden_de_Trabajo_has_Servicios_Servicios1
		FOREIGN KEY (Servicios_idServicios)
		REFERENCES Servicios (idServicios)

ALTER TABLE Usuarios ADD
	CONSTRAINT fk_Usuarios_Empleado1
		FOREIGN KEY (Empleado_idEmpleado)
		REFERENCES Empleado (idEmpleado),
	CONSTRAINT fk_Usuarios_Estado_Usuario1
		FOREIGN KEY (Estado_Usuario_idEstado_Usuario)
		REFERENCES Estado_Usuario (idEstado_Usuario)

ALTER TABLE Registro_de_Actividad ADD
	CONSTRAINT fk_Registro_de_Actividad_Accion1
		FOREIGN KEY (Accion_idAccion)
		REFERENCES Accion (idAccion),
	CONSTRAINT fk_Registro_de_Actividad_Usuarios1
		FOREIGN KEY (Usuarios_idUsuarios)
		REFERENCES Usuarios (idUsuarios)

ALTER TABLE Descuento_has_Factura ADD
	CONSTRAINT fk_Descuento_has_Factura_Descuento1
		FOREIGN KEY (Descuento_idDescuento)
		REFERENCES Descuento (idDescuento),
	CONSTRAINT fk_Descuento_has_Factura_Factura1
		FOREIGN KEY (Factura_idFactura)
		REFERENCES Factura (idFactura)
