-- <=== Alter Table ===>
-- Table Persona
ALTER TABLE Persona ADD
	CONSTRAINT fk_Persona_Genero1 
		FOREIGN KEY (Genero_idGenero) 
		REFERENCES Genero (idGenero),
	CONSTRAINT numeroIdentidad_UNIQUE 
		UNIQUE (numeroIdentidad)

-- Table Aspirante
ALTER TABLE Aspirante ADD
	CONSTRAINT fk_Aspirante_Persona1 
		FOREIGN KEY (Persona_idPersona) 
		REFERENCES Persona (idPersona)

-- Table Curriculum
ALTER TABLE Curriculum ADD
	CONSTRAINT fk_Curriculum_Aspirante1 
		FOREIGN KEY (Aspirante_idAspirante) 
		REFERENCES Aspirante (idAspirante)

-- Table Cliente
ALTER TABLE Cliente ADD
	CONSTRAINT fk_Cliente_Persona1 
		FOREIGN KEY (Persona_idPersona) 
		REFERENCES Persona (idPersona)

-- Table Modelo
ALTER TABLE Modelo ADD
CONSTRAINT fk_Vehiculos_Marca 
		FOREIGN KEY (Marca_idMarca) 
		REFERENCES Marca (idMarca)

-- Table Vehiculos
ALTER TABLE Vehiculos ADD
	CONSTRAINT fk_Vehiculos_Modelo1 
		FOREIGN KEY (Modelo_idModelo) 
		REFERENCES Modelo (idModelo)

-- Table Empleado
ALTER TABLE Empleado ADD
	CONSTRAINT Codigo_de_Empleado_UNIQUE 
		UNIQUE (codigoEmpleado),
	CONSTRAINT fk_Empleado_Empleado1 
		FOREIGN KEY (jefeInmediato) 
		REFERENCES Empleado (idEmpleado),
	CONSTRAINT fk_Empleado_Persona1 
		FOREIGN KEY (Persona_idPersona) 
		REFERENCES Persona (idPersona),
	CONSTRAINT fk_Empleado_Cargo1 
		FOREIGN KEY (Cargo_idCargo) 
		REFERENCES Cargo (idCargo),
	CONSTRAINT fk_Empleado_Area_de_Trabajo1 
		FOREIGN KEY (AreaTrabajo_idAreaTrabajo) 
		REFERENCES AreaTrabajo (idAreaTrabajo)

-- Table Solicitudes
ALTER TABLE Solicitudes ADD
	CONSTRAINT fk_Solicitudes_Permisos1 
		FOREIGN KEY (Permisos_idPermisos) 
		REFERENCES Permisos (idPermisos),
	CONSTRAINT fk_Solicitudes_Vacaciones1 
		FOREIGN KEY (Vacaciones_idVacaciones) 
		REFERENCES Vacaciones (idVacaciones),
	CONSTRAINT fk_Solicitudes_Empleado1 
		FOREIGN KEY (Empleado_idEmpleado) 
		REFERENCES Empleado (idEmpleado)

-- Table Reservacion
ALTER TABLE Reservacion ADD
	CONSTRAINT fk_Reservación_Empleado1 
		FOREIGN KEY (Empleado_idEmpleado) 
		REFERENCES Empleado (idEmpleado),
	CONSTRAINT fk_Reservación_Cliente1 
		FOREIGN KEY (Cliente_idCliente) 
		REFERENCES Cliente (idCliente)



-- Table OrdenTrabajo
ALTER TABLE OrdenTrabajo ADD
	CONSTRAINT fk_Orden_de_Trabajo_Cotizacion1 
		FOREIGN KEY (Cotizacion_idCotizacion) 
		REFERENCES Cotizacion (idCotizacion),
	CONSTRAINT fk_Orden_de_Trabajo_Cliente1 
		FOREIGN KEY (Cliente_idCliente) 
		REFERENCES Cliente (idCliente),
	CONSTRAINT fk_Orden_de_Trabajo_Lista_MyR1 
		FOREIGN KEY (ListaMyR_idListaMyR) 
		REFERENCES ListaMyR (idListaMyR),
	CONSTRAINT fk_Orden_de_Trabajo_EstadoOT1 
		FOREIGN KEY (EstadoOT_idEstadoOT) 
		REFERENCES EstadoOT (idEstadoOT),
	CONSTRAINT fk_Orden_de_Trabajo_Vehiculos1 
		FOREIGN KEY (Vehiculos_idVehiculos) 
		REFERENCES Vehiculos (idVehiculos)

-- Table Factura
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
		FOREIGN KEY (OrdenTrabajo_idOrdenTrabajo) 
		REFERENCES OrdenTrabajo (idOrdenTrabajo),
	CONSTRAINT fk_Factura_Promociones1 
		FOREIGN KEY (Promociones_idPromociones) 
		REFERENCES Promociones (idPromociones),
	CONSTRAINT fk_Factura_Descuento1 
		FOREIGN KEY (Descuento_idDescuento) 
		REFERENCES Descuento (idDescuento)

-- Table Telefono
ALTER TABLE Telefono ADD
	CONSTRAINT fk_Teléfono_Persona1 
		FOREIGN KEY (Persona_idPersona) 
		REFERENCES Persona (idPersona)

-- Table VinculoCyV
ALTER TABLE VinculoCyV ADD
	CONSTRAINT fk_Vehiculos_has_Cliente_Cliente1 
		FOREIGN KEY (Cliente_idCliente) 
		REFERENCES Cliente (idCliente),
	CONSTRAINT fk_Vehiculos_has_Cliente_Vehiculos1 
		FOREIGN KEY (Vehiculos_idVehiculos) 
		REFERENCES Vehiculos (idVehiculos)

-- Table Producto
ALTER TABLE Producto ADD
	CONSTRAINT fk_Producto_Inventario1 
		FOREIGN KEY (Inventario_idInventario) 
		REFERENCES Inventario (idInventario)

-- Table Inventario_has_Lista_MyR
ALTER TABLE Inventario_has_Lista_MyR ADD
	CONSTRAINT fk_Inventario_has_Lista_MyR_Lista_MyR1 
		FOREIGN KEY (ListaMyR_idListaMyR) 
		REFERENCES ListaMyR (idListaMyR),
	CONSTRAINT fk_Inventario_has_Lista_MyR_Producto1 
		FOREIGN KEY (Producto_idProducto) 
		REFERENCES Producto (idProducto)

-- Table Recambios
ALTER TABLE Recambios ADD
	CONSTRAINT fk_Recambios_Producto1 
		FOREIGN KEY (Producto_idProducto) 
		REFERENCES Producto (idProducto)

-- Table Materiales
ALTER TABLE Materiales ADD
	CONSTRAINT fk_Materiales_Producto1 
		FOREIGN KEY (Producto_idProducto) 
		REFERENCES Producto (idProducto)

-- Table Herramientas
ALTER TABLE Herramientas ADD
	CONSTRAINT fk_Herramientas_Inventario1 
		FOREIGN KEY (Inventario_idInventario) 
		REFERENCES Inventario (idInventario)

-- Table Huella
ALTER TABLE Huella ADD
	CONSTRAINT fk_Huella_Empleado1 
		FOREIGN KEY (Empleado_idEmpleado) 
		REFERENCES Empleado (idEmpleado)



-- Table ContratoPersonal
ALTER TABLE ContratoPersonal ADD
	CONSTRAINT fk_Contratos_de_Personal_TipoContrato1 
		FOREIGN KEY (TipoContrato_idTipoContrato) 
		REFERENCES TipoContrato (idTipoContrato)

-- Table EntrevistaTrabajo
ALTER TABLE EntrevistaTrabajo ADD
	CONSTRAINT fk_EntrevistaTrabajo_Curriculum1 
		FOREIGN KEY (Curriculum_idCurriculum) 
		REFERENCES Curriculum (idCurriculum)

-- Table Historico_Contratos
ALTER TABLE Historico_Contratos ADD
	CONSTRAINT fk_Historico_Contratos_Contratos_de_Personal1 
		FOREIGN KEY (ContratoPersonal_idContratoPersonal) 
		REFERENCES ContratoPersonal (idContratoPersonal),
	CONSTRAINT fk_Historico_Contratos_Empleado1 
		FOREIGN KEY (Empleado_idEmpleado) 
		REFERENCES Empleado (idEmpleado)

-- Table Historico_HE
ALTER TABLE Historico_HE ADD
	CONSTRAINT fk_Historico_HorasExtras_Area_de_Trabajo1 
		FOREIGN KEY (AreaTrabajo_idAreaTrabajo) 
		REFERENCES AreaTrabajo (idAreaTrabajo),
	CONSTRAINT fk_Historico_HorasExtras_Horas_extras1 
		FOREIGN KEY (Horas_extras_idHoras_extras) 
		REFERENCES Horas_extras (idHoras_extras)

-- Table RolPago
ALTER TABLE RolPago ADD
	CONSTRAINT fk_RolPago_Empleado1 
		FOREIGN KEY (Empleado_idEmpleado) 
		REFERENCES Empleado (idEmpleado)

-- Table Cotizacion_has_Producto
ALTER TABLE Cotizacion_has_Producto ADD
	CONSTRAINT fk_Cotizacion_has_Producto_Cotizacion1 
		FOREIGN KEY (Cotizacion_idCotizacion) 
		REFERENCES Cotizacion (idCotizacion),
	CONSTRAINT fk_Cotizacion_has_Producto_Producto1 
		FOREIGN KEY (Producto_idProducto) 
		REFERENCES Producto (idProducto)

-- Table OrdenTrabajo_has_Servicios
ALTER TABLE OrdenTrabajo_has_Servicios ADD
	CONSTRAINT fk_Orden_de_Trabajo_has_Servicios_Orden_de_Trabajo1 
		FOREIGN KEY (OrdenTrabajo_idOrdenTrabajo) 
		REFERENCES OrdenTrabajo (idOrdenTrabajo),
	CONSTRAINT fk_Orden_de_Trabajo_has_Servicios_Servicios1 
		FOREIGN KEY (Servicios_idServicios) 
		REFERENCES Servicios (idServicios)

-- Table Usuarios
ALTER TABLE Usuarios ADD
	CONSTRAINT NombreUsuario_UNIQUE 
		UNIQUE (nombreUsuario),
	CONSTRAINT fk_Usuarios_Empleado1 
		FOREIGN KEY (Empleado_idEmpleado) 
		REFERENCES Empleado (idEmpleado),
	CONSTRAINT fk_Usuarios_Estado_Usuario1 
		FOREIGN KEY (Estado_Usuario_idEstado_Usuario) 
		REFERENCES Estado_Usuario (idEstado_Usuario)

-- Table Registro_de_Actividad
ALTER TABLE Registro_de_Actividad ADD
	CONSTRAINT fk_Registro_de_Actividad_Accion1 
		FOREIGN KEY (Accion_idAccion) 
		REFERENCES Accion (idAccion),
	CONSTRAINT fk_Registro_de_Actividad_Usuarios1 
		FOREIGN KEY (Usuarios_idUsuarios) 
		REFERENCES Usuarios (idUsuario)
