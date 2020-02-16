-- -----------------------------------------------------
-- Table `Persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Persona` (
  `idPersona` INT NOT NULL,
  `primerNombre` VARCHAR(50) NULL,
  `segundoNombre` VARCHAR(50) NULL,
  `primerApellido` VARCHAR(45) NULL,
  `segundoApellido` VARCHAR(45) NULL,
  `correoElectronico` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `numeroIdentidad` VARCHAR(45) NOT NULL,
  `genero` VARCHAR(45) NULL,
  `fechaIngreso` DATE NULL,
  PRIMARY KEY (`idPersona`),
  UNIQUE INDEX `númeroIdentidad_UNIQUE` (`numeroIdentidad` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Aspirante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aspirante` (
  `idAspirante` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `Persona_idPersona` INT NOT NULL,
  PRIMARY KEY (`idAspirante`),
  INDEX `fk_Aspirante_Persona1_idx` (`Persona_idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_Aspirante_Persona1`
    FOREIGN KEY (`Persona_idPersona`)
    REFERENCES `Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Curriculum`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Curriculum` (
  `idCurriculum` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `Aspirante_idAspirante` INT NOT NULL,
  PRIMARY KEY (`idCurriculum`),
  INDEX `fk_Curriculum_Aspirante1_idx` (`Aspirante_idAspirante` ASC) VISIBLE,
  CONSTRAINT `fk_Curriculum_Aspirante1`
    FOREIGN KEY (`Aspirante_idAspirante`)
    REFERENCES `Aspirante` (`idAspirante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cliente` (
  `idCliente` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `Persona_idPersona` INT NOT NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `fk_Cliente_Persona1_idx` (`Persona_idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Persona1`
    FOREIGN KEY (`Persona_idPersona`)
    REFERENCES `Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cargo` (
  `idCargo` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idCargo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AreaTrabajo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AreaTrabajo` (
  `idAreaTrabajo` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idAreaTrabajo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Marca` (
  `idMarca` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idMarca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Modelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Modelo` (
  `idModelo` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idModelo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vehiculos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vehiculos` (
  `idVehiculos` INT NOT NULL,
  `vin` VARCHAR(45) NULL,
  `color` VARCHAR(45) NULL,
  `placa` VARCHAR(45) NULL,
  `numeroMotor` VARCHAR(45) NULL,
  `caja_de_cambios` VARCHAR(45) NULL,
  `Marca_idMarca` INT NOT NULL,
  `Modelo_idModelo` INT NOT NULL,
  PRIMARY KEY (`idVehiculos`),
  INDEX `fk_Vehiculos_Marca_idx` (`Marca_idMarca` ASC) VISIBLE,
  INDEX `fk_Vehiculos_Modelo1_idx` (`Modelo_idModelo` ASC) VISIBLE,
  CONSTRAINT `fk_Vehiculos_Marca`
    FOREIGN KEY (`Marca_idMarca`)
    REFERENCES `Marca` (`idMarca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vehiculos_Modelo1`
    FOREIGN KEY (`Modelo_idModelo`)
    REFERENCES `Modelo` (`idModelo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '											';


-- -----------------------------------------------------
-- Table `Inventario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Inventario` (
  `idInventario` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `cantidad` INT NULL,
  PRIMARY KEY (`idInventario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Servicios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Servicios` (
  `idServicios` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `precioCosto` DOUBLE NULL,
  `duracion` TIME NULL,
  PRIMARY KEY (`idServicios`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cotizacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cotizacion` (
  `idCotizacion` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `fecha` DATE NULL,
  PRIMARY KEY (`idCotizacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Permisos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Permisos` (
  `idPermisos` INT NOT NULL,
  `motivo` VARCHAR(45) NULL,
  `fecha` DATE NULL,
  PRIMARY KEY (`idPermisos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vacaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Vacaciones` (
  `idVacaciones` INT NOT NULL,
  `cantidadDias` INT NULL,
  `fechaInicio` DATE NULL,
  `fechaFin` DATE NULL,
  `fechaRetorno` DATE NULL,
  PRIMARY KEY (`idVacaciones`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empleado` (
  `idEmpleado` INT NOT NULL,
  `codigoEmpleado` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `jefeInmediato` INT NULL,
  `Persona_idPersona` INT NOT NULL,
  `Cargo_idCargo` INT NOT NULL,
  `AreaTrabajo_idAreaTrabajo` INT NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  INDEX `fk_Empleado_Empleado1_idx` (`jefeInmediato` ASC) VISIBLE,
  INDEX `fk_Empleado_Persona1_idx` (`Persona_idPersona` ASC) VISIBLE,
  INDEX `fk_Empleado_Cargo1_idx` (`Cargo_idCargo` ASC) VISIBLE,
  INDEX `fk_Empleado_Area de Trabajo1_idx` (`AreaTrabajo_idAreaTrabajo` ASC) VISIBLE,
  UNIQUE INDEX `Codigo de Empleado_UNIQUE` (`codigoEmpleado` ASC) VISIBLE,
  CONSTRAINT `fk_Empleado_Empleado1`
    FOREIGN KEY (`jefeInmediato`)
    REFERENCES `Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empleado_Persona1`
    FOREIGN KEY (`Persona_idPersona`)
    REFERENCES `Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empleado_Cargo1`
    FOREIGN KEY (`Cargo_idCargo`)
    REFERENCES `Cargo` (`idCargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empleado_Area de Trabajo1`
    FOREIGN KEY (`AreaTrabajo_idAreaTrabajo`)
    REFERENCES `AreaTrabajo` (`idAreaTrabajo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Solicitudes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Solicitudes` (
  `idSolicitudes` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `Permisos_idPermisos` INT NULL,
  `Vaciones_idVaciones` INT NULL,
  `Empleado_idEmpleado` INT NOT NULL,
  PRIMARY KEY (`idSolicitudes`),
  INDEX `fk_Solicitudes_Permisos1_idx` (`Permisos_idPermisos` ASC) VISIBLE,
  INDEX `fk_Solicitudes_Vaciones1_idx` (`Vaciones_idVaciones` ASC) VISIBLE,
  INDEX `fk_Solicitudes_Empleado1_idx` (`Empleado_idEmpleado` ASC) VISIBLE,
  CONSTRAINT `fk_Solicitudes_Permisos1`
    FOREIGN KEY (`Permisos_idPermisos`)
    REFERENCES `Permisos` (`idPermisos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Solicitudes_Vaciones1`
    FOREIGN KEY (`Vaciones_idVaciones`)
    REFERENCES `Vacaciones` (`idVacaciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Solicitudes_Empleado1`
    FOREIGN KEY (`Empleado_idEmpleado`)
    REFERENCES `Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Reservacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Reservacion` (
  `idReservacion` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `cita` DATETIME NULL,
  `Empleado_idEmpleado` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idReservacion`),
  INDEX `fk_Reservación_Empleado1_idx` (`Empleado_idEmpleado` ASC) VISIBLE,
  INDEX `fk_Reservación_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Reservación_Empleado1`
    FOREIGN KEY (`Empleado_idEmpleado`)
    REFERENCES `Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservación_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ListaMyR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ListaMyR` (
  `idListaMyR` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idListaMyR`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FormaPago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FormaPago` (
  `idFormaPago` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idFormaPago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EstadoOT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EstadoOT` (
  `idEstadoOT` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstadoOT`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OrdenTrabajo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OrdenTrabajo` (
  `idOrdenTrabajo` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `estado_del_vehiculo` VARCHAR(45) NULL,
  `objetosPersonales` VARCHAR(45) NULL,
  `fechaInicio` DATE NULL,
  `fechaFin` DATE NULL,
  `reparacionesEfectuadas` VARCHAR(45) NULL,
  `reparacionesNoEfectuadas` VARCHAR(45) NULL,
  `comentarios` VARCHAR(45) NULL,
  `Cotizacion_idCotizacion` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `ListaMyR_idListaMyR` INT NOT NULL,
  `EstadoOT_idEstadoOT` INT NOT NULL,
  `Vehiculos_idVehiculos` INT NOT NULL,
  PRIMARY KEY (`idOrdenTrabajo`),
  INDEX `fk_Orden de Trabajo_Cotizacion1_idx` (`Cotizacion_idCotizacion` ASC) VISIBLE,
  INDEX `fk_Orden de Trabajo_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Orden de Trabajo_Lista MyR1_idx` (`ListaMyR_idListaMyR` ASC) VISIBLE,
  INDEX `fk_Orden de Trabajo_Estado O.T.1_idx` (`EstadoOT_idEstadoOT` ASC) VISIBLE,
  INDEX `fk_Orden de Trabajo_Vehiculos1_idx` (`Vehiculos_idVehiculos` ASC) VISIBLE,
  CONSTRAINT `fk_Orden de Trabajo_Cotizacion1`
    FOREIGN KEY (`Cotizacion_idCotizacion`)
    REFERENCES `Cotizacion` (`idCotizacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orden de Trabajo_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orden de Trabajo_Lista MyR1`
    FOREIGN KEY (`ListaMyR_idListaMyR`)
    REFERENCES `ListaMyR` (`idListaMyR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orden de Trabajo_Estado O.T.1`
    FOREIGN KEY (`EstadoOT_idEstadoOT`)
    REFERENCES `EstadoOT` (`idEstadoOT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orden de Trabajo_Vehiculos1`
    FOREIGN KEY (`Vehiculos_idVehiculos`)
    REFERENCES `Vehiculos` (`idVehiculos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Promociones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Promociones` (
  `idPromociones` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `fechaInicio` DATE NULL,
  `fechaFin` DATE NULL,
  `estado` VARCHAR(45) NULL,
  PRIMARY KEY (`idPromociones`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Descuento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Descuento` (
  `idDescuento` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `porcentaje` DOUBLE NULL,
  `fecha_de_validez` DATE NULL,
  PRIMARY KEY (`idDescuento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Factura` (
  `idFactura` INT NOT NULL,
  `fecha` DATETIME NULL,
  `precio` DOUBLE NULL,
  `total_a_pagar` DOUBLE NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Empleado_idEmpleado` INT NOT NULL,
  `FormaPago_idFormaPago` INT NOT NULL,
  `OrdenTrabajo_idOrdenTrabajo` INT NOT NULL,
  `Promociones_idPromociones` INT NOT NULL,
  `Descuento_idDescuento` INT NOT NULL,
  PRIMARY KEY (`idFactura`),
  INDEX `fk_Factura_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Factura_Empleado1_idx` (`Empleado_idEmpleado` ASC) VISIBLE,
  INDEX `fk_Factura_FormaPago1_idx` (`FormaPago_idFormaPago` ASC) VISIBLE,
  INDEX `fk_Factura_Orden de Trabajo1_idx` (`OrdenTrabajo_idOrdenTrabajo` ASC) VISIBLE,
  INDEX `fk_Factura_Promociones1_idx` (`Promociones_idPromociones` ASC) VISIBLE,
  INDEX `fk_Factura_Descuento1_idx` (`Descuento_idDescuento` ASC) VISIBLE,
  CONSTRAINT `fk_Factura_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Factura_Empleado1`
    FOREIGN KEY (`Empleado_idEmpleado`)
    REFERENCES `Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Factura_FormaPago1`
    FOREIGN KEY (`FormaPago_idFormaPago`)
    REFERENCES `FormaPago` (`idFormaPago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Factura_Orden de Trabajo1`
    FOREIGN KEY (`OrdenTrabajo_idOrdenTrabajo`)
    REFERENCES `OrdenTrabajo` (`idOrdenTrabajo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Factura_Promociones1`
    FOREIGN KEY (`Promociones_idPromociones`)
    REFERENCES `Promociones` (`idPromociones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Factura_Descuento1`
    FOREIGN KEY (`Descuento_idDescuento`)
    REFERENCES `Descuento` (`idDescuento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Telefono`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Telefono` (
  `idTelefono` INT NOT NULL,
  `numeroTelefono` VARCHAR(45) NULL,
  `Persona_idPersona` INT NOT NULL,
  PRIMARY KEY (`idTelefono`),
  INDEX `fk_Teléfono_Persona1_idx` (`Persona_idPersona` ASC) VISIBLE,
  CONSTRAINT `fk_Teléfono_Persona1`
    FOREIGN KEY (`Persona_idPersona`)
    REFERENCES `Persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VinculoCyV`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VinculoCyV` (
  `idVinculoCyV` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Vehiculos_idVehiculos` INT NOT NULL,
  INDEX `fk_Vehiculos_has_Cliente_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Vehiculos_has_Cliente_Vehiculos1_idx` (`Vehiculos_idVehiculos` ASC) VISIBLE,
  PRIMARY KEY (`idVinculoCyV`),
  CONSTRAINT `fk_Vehiculos_has_Cliente_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vehiculos_has_Cliente_Vehiculos1`
    FOREIGN KEY (`Vehiculos_idVehiculos`)
    REFERENCES `Vehiculos` (`idVehiculos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Producto` (
  `idProducto` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `precioVenta` DOUBLE NULL,
  `precioCompra` DOUBLE NULL,
  `fechaIngreso` DATE NULL,
  `fechaVencimiento` DATE NULL,
  `Inventario_idInventario` INT NOT NULL,
  PRIMARY KEY (`idProducto`),
  INDEX `fk_Producto_Inventario1_idx` (`Inventario_idInventario` ASC) VISIBLE,
  CONSTRAINT `fk_Producto_Inventario1`
    FOREIGN KEY (`Inventario_idInventario`)
    REFERENCES `Inventario` (`idInventario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Inventario_has_Lista MyR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Inventario_has_Lista MyR` (
  `idInventario_has_Lista MyR` INT NOT NULL,
  `ListaMyR_idListaMyR` INT NOT NULL,
  `Producto_idProducto` INT NOT NULL,
  `rebajados_del_inventario` TINYINT NOT NULL,
  PRIMARY KEY (`idInventario_has_Lista MyR`),
  INDEX `fk_Inventario_has_Lista MyR_Lista MyR1_idx` (`ListaMyR_idListaMyR` ASC) VISIBLE,
  INDEX `fk_Inventario_has_Lista MyR_Producto1_idx` (`Producto_idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_Inventario_has_Lista MyR_Lista MyR1`
    FOREIGN KEY (`ListaMyR_idListaMyR`)
    REFERENCES `ListaMyR` (`idListaMyR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventario_has_Lista MyR_Producto1`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Recambios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Recambios` (
  `idRecambios` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `Producto_idProducto` INT NOT NULL,
  PRIMARY KEY (`idRecambios`),
  INDEX `fk_Recambios_Producto1_idx` (`Producto_idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_Recambios_Producto1`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Materiales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Materiales` (
  `idMateriales` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `Producto_idProducto` INT NOT NULL,
  PRIMARY KEY (`idMateriales`),
  INDEX `fk_Materiales_Producto1_idx` (`Producto_idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_Materiales_Producto1`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Herramientas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Herramientas` (
  `idHerramientas` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `precioCosto` DOUBLE NULL,
  `fechaIngreso` DATE NULL,
  `Inventario_idInventario` INT NOT NULL,
  PRIMARY KEY (`idHerramientas`),
  INDEX `fk_Herramientas_Inventario1_idx` (`Inventario_idInventario` ASC) VISIBLE,
  CONSTRAINT `fk_Herramientas_Inventario1`
    FOREIGN KEY (`Inventario_idInventario`)
    REFERENCES `Inventario` (`idInventario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Huella`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Huella` (
  `idHuella` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `horaEntrada` TIME NULL,
  `horaSalida` TIME NULL,
  `fecha` DATE NULL,
  `Empleado_idEmpleado` INT NOT NULL,
  PRIMARY KEY (`idHuella`),
  INDEX `fk_Huella_Empleado1_idx` (`Empleado_idEmpleado` ASC) VISIBLE,
  CONSTRAINT `fk_Huella_Empleado1`
    FOREIGN KEY (`Empleado_idEmpleado`)
    REFERENCES `Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TipoContrato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TipoContrato` (
  `idTipoContrato` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idTipoContrato`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ContratoPersonal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ContratoPersonal` (
  `idContratoPersonal` INT NOT NULL,
  `fechaContrato` DATE NULL,
  `sueldo` DOUBLE NULL,
  `horaEntrada` TIME NULL,
  `horaSalida` TIME NULL,
  `TipoContrato_idTipoContrato` INT NOT NULL,
  PRIMARY KEY (`idContratoPersonal`),
  INDEX `fk_Contratos de Personal_TipoContrato1_idx` (`TipoContrato_idTipoContrato` ASC) VISIBLE,
  CONSTRAINT `fk_Contratos de Personal_TipoContrato1`
    FOREIGN KEY (`TipoContrato_idTipoContrato`)
    REFERENCES `TipoContrato` (`idTipoContrato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `EntrevistaTrabajo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `EntrevistaTrabajo` (
  `idEntrevistaTrabajo` INT NOT NULL,
  `fechaHora` DATETIME NULL,
  `Curriculum_idCurriculum` INT NOT NULL,
  PRIMARY KEY (`idEntrevistaTrabajo`),
  INDEX `fk_EntrevistaTrabajo_Curriculum1_idx` (`Curriculum_idCurriculum` ASC) VISIBLE,
  CONSTRAINT `fk_EntrevistaTrabajo_Curriculum1`
    FOREIGN KEY (`Curriculum_idCurriculum`)
    REFERENCES `Curriculum` (`idCurriculum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Historico_Contratos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Historico_Contratos` (
  `idHistorico_Contratos` INT NOT NULL,
  `ContratoPersonal_idContratoPersonal` INT NOT NULL,
  `Empleado_idEmpleado` INT NOT NULL,
  PRIMARY KEY (`idHistorico_Contratos`),
  INDEX `fk_Historico_Contratos_Contratos de Personal1_idx` (`ContratoPersonal_idContratoPersonal` ASC) VISIBLE,
  INDEX `fk_Historico_Contratos_Empleado1_idx` (`Empleado_idEmpleado` ASC) VISIBLE,
  CONSTRAINT `fk_Historico_Contratos_Contratos de Personal1`
    FOREIGN KEY (`ContratoPersonal_idContratoPersonal`)
    REFERENCES `ContratoPersonal` (`idContratoPersonal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Historico_Contratos_Empleado1`
    FOREIGN KEY (`Empleado_idEmpleado`)
    REFERENCES `Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Horas_extras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Horas_extras` (
  `idHoras_extras` INT NOT NULL,
  `horaInicio` TIME NULL,
  `horaFin` TIME NULL,
  `fecha` DATE NULL,
  PRIMARY KEY (`idHoras_extras`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Historico_HE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Historico_HE` (
  `idHistorico_HE` INT NOT NULL,
  `AreaTrabajo_idAreaTrabajo` INT NOT NULL,
  `Horas_extras_idHoras_extras` INT NOT NULL,
  PRIMARY KEY (`idHistorico_HE`),
  INDEX `fk_Historico_HorasExtras_Area de Trabajo1_idx` (`AreaTrabajo_idAreaTrabajo` ASC) VISIBLE,
  INDEX `fk_Historico_HorasExtras_Horas_extras1_idx` (`Horas_extras_idHoras_extras` ASC) VISIBLE,
  CONSTRAINT `fk_Historico_HorasExtras_Area de Trabajo1`
    FOREIGN KEY (`AreaTrabajo_idAreaTrabajo`)
    REFERENCES `AreaTrabajo` (`idAreaTrabajo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Historico_HorasExtras_Horas_extras1`
    FOREIGN KEY (`Horas_extras_idHoras_extras`)
    REFERENCES `Horas_extras` (`idHoras_extras`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RolPago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RolPago` (
  `idRolPago` INT NOT NULL,
  `sueldo` DOUBLE NULL,
  `fecha` DATE NULL,
  `deducciones` DOUBLE NULL,
  `cantidadHT` INT NULL,
  `cantidadHE` INT NULL,
  `pagoHT` DOUBLE NULL,
  `pagoHE` DOUBLE NULL,
  `comisiones` DOUBLE NULL,
  `cargo` VARCHAR(45) NULL,
  `Empleado_idEmpleado` INT NOT NULL,
  PRIMARY KEY (`idRolPago`),
  INDEX `fk_RolPago_Empleado1_idx` (`Empleado_idEmpleado` ASC) VISIBLE,
  CONSTRAINT `fk_RolPago_Empleado1`
    FOREIGN KEY (`Empleado_idEmpleado`)
    REFERENCES `Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Cotizacion_has_Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cotizacion_has_Producto` (
  `idCotizacion_has_Producto` INT NOT NULL,
  `Cotizacion_idCotizacion` INT NOT NULL,
  `Producto_idProducto` INT NOT NULL,
  `aprovados` TINYINT NOT NULL,
  INDEX `fk_Cotizacion_has_Producto_Producto1_idx` (`Producto_idProducto` ASC) VISIBLE,
  INDEX `fk_Cotizacion_has_Producto_Cotizacion1_idx` (`Cotizacion_idCotizacion` ASC) VISIBLE,
  PRIMARY KEY (`idCotizacion_has_Producto`),
  CONSTRAINT `fk_Cotizacion_has_Producto_Cotizacion1`
    FOREIGN KEY (`Cotizacion_idCotizacion`)
    REFERENCES `Cotizacion` (`idCotizacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cotizacion_has_Producto_Producto1`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OrdenTrabajo_has_Servicios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OrdenTrabajo_has_Servicios` (
  `OrdenTrabajo_idOrdenTrabajo` INT NOT NULL,
  `Servicios_idServicios` INT NOT NULL,
  `servicioEfectuado` TINYINT NOT NULL,
  PRIMARY KEY (`OrdenTrabajo_idOrdenTrabajo`, `Servicios_idServicios`),
  INDEX `fk_Orden de Trabajo_has_Servicios_Servicios1_idx` (`Servicios_idServicios` ASC) VISIBLE,
  INDEX `fk_Orden de Trabajo_has_Servicios_Orden de Trabajo1_idx` (`OrdenTrabajo_idOrdenTrabajo` ASC) VISIBLE,
  CONSTRAINT `fk_Orden de Trabajo_has_Servicios_Orden de Trabajo1`
    FOREIGN KEY (`OrdenTrabajo_idOrdenTrabajo`)
    REFERENCES `OrdenTrabajo` (`idOrdenTrabajo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orden de Trabajo_has_Servicios_Servicios1`
    FOREIGN KEY (`Servicios_idServicios`)
    REFERENCES `Servicios` (`idServicios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Estado_Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Estado_Usuario` (
  `idEstado_Usuario` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstado_Usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Usuarios` (
  `idUsuario` INT NOT NULL,
  `nombreUsuario` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  `Empleado_idEmpleado` INT NOT NULL,
  `Estado_Usuario_idEstado_Usuario` INT NOT NULL,
  PRIMARY KEY (`idUsuario`),
  INDEX `fk_Usuarios_Empleado1_idx` (`Empleado_idEmpleado` ASC) VISIBLE,
  INDEX `fk_Usuarios_Estado_Usuario1_idx` (`Estado_Usuario_idEstado_Usuario` ASC) VISIBLE,
  UNIQUE INDEX `NombreUsuario_UNIQUE` (`nombreUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Usuarios_Empleado1`
    FOREIGN KEY (`Empleado_idEmpleado`)
    REFERENCES `Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_Estado_Usuario1`
    FOREIGN KEY (`Estado_Usuario_idEstado_Usuario`)
    REFERENCES `Estado_Usuario` (`idEstado_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Accion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Accion` (
  `idAccion` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idAccion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Registro_de_Actividad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Registro_de_Actividad` (
  `idRegistro_de_Actividad` INT NOT NULL,
  `descripcion` VARCHAR(4000) NULL,
  `registrosAfectados` INT NULL,
  `fecha` DATETIME NULL,
  `Accion_idAccion` INT NOT NULL,
  `Usuarios_idUsuarios` INT NOT NULL,
  PRIMARY KEY (`idRegistro_de_Actividad`),
  INDEX `fk_Registro de Actividad_Accion1_idx` (`Accion_idAccion` ASC) VISIBLE,
  INDEX `fk_Registro de Actividad_Usuarios1_idx` (`Usuarios_idUsuarios` ASC) VISIBLE,
  CONSTRAINT `fk_Registro de Actividad_Accion1`
    FOREIGN KEY (`Accion_idAccion`)
    REFERENCES `Accion` (`idAccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Registro de Actividad_Usuarios1`
    FOREIGN KEY (`Usuarios_idUsuarios`)
    REFERENCES `Usuarios` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
