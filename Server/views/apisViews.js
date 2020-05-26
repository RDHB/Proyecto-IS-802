'use strict'

// IMPORTANDO LOS MODULOS NECESARIOS
const express = require('express');
const functionsAuth = require('../others/functionsAuth')
const directorio = require('../../ruta');

// DEFINIENDO OBJETOS IMPORTANTES
const path = directorio.ruta.replace(/\\/g,'/') + "/APP";

// DEFINIENDO OBJETO QUE MANEJARA LA RUTA '/volvo/views/'
const apisViews = express.Router();

// DEFINIENDO MIDDLEWARES PARA SERVIR ARCHIVOS ESTATICOS
apisViews.use(express.static(path));

// DEFINIENDO APIS PARA MOSTRAR CADA UNA DE LAS VISTA
// -- VISTA LOGIN
apisViews.get('/login', (req,res) => {
    if(req.session.name){
        res.redirect('/volvo')
    }else{
        res.sendFile(path + '/login.html');
    }
});

// -- VISTA CONFIGURACION DE USUARIO
apisViews.get('/gestionUsuario/GU_Configuracion_Usuario',functionsAuth.authLogin,(req,res) => {
    res.sendFile(path + '/GestionUsuario/GU_Configuracion_Usuario.html');
});    

// -- VISTAS FACTURACION
apisViews.get('/facturacion/FA_Home',/*functionsAuth.authCajero,*/ (req,res) => {
    res.sendFile(path + '/Facturacion/FA_Home.html');
});

apisViews.get('/facturacion/FA_Facturar',/*functionsAuth.authCajero,*/ (req,res) => {
    res.sendFile(path + '/Facturacion/FA_Facturar.html');
});

// -- VISTAS GESTION DE USUARIO 
apisViews.get('/gestionUsuario/GU_Home',functionsAuth.authAdmin,(req,res) => {
    res.sendFile(path + '/GestionUsuario/GU_Home.html');
});

apisViews.get('/gestionUsuario/GU_Gestion_Usuarios',functionsAuth.authAdmin, (req,res) => {
    res.sendFile(path + '/GestionUsuario/GU_Gestion_Usuarios.html');
});

apisViews.get('/gestionUsuario/GU_DataBase',functionsAuth.authAdmin,(req,res) => {
    res.sendFile(path + '/GestionUsuario/GU_Gestion_DataBase.html');
});

// -- VISTAS ORDEN DE TRABAJO
apisViews.get('/ordenTrabajo/OT_Home',functionsAuth.authHomeOrdenTrabajo, (req,res) => {
    res.sendFile(path + '/OrdenTrabajo/OT_Home.html');
});
// asesor servicios
apisViews.get('/ordenTrabajo/OT-A_AprobacionCotizacion',/*functionsAuth.authAsesorServicios,*/ (req,res) => {
    res.sendFile(path + '/OrdenTrabajo/OT-A_AprobacionCotizacion.html');//>>>>>>>>>>>>>
});

apisViews.get('/ordenTrabajo/OT-A_ContratarServicios',/*functionsAuth.authAsesorServicios,*/ (req,res) => {
    res.sendFile(path + '/OrdenTrabajo/OT-A_ContratarServicios.html');
});

apisViews.get('/ordenTrabajo/OT-A_Cotizacion',/*functionsAuth.authAsesorServicios,*/ (req,res) => {
    res.sendFile(path + '/OrdenTrabajo/OT-A_Cotizacion.html');
});

apisViews.get('/ordenTrabajo/OT-A_FinalizarOT',/*functionsAuth.authAsesorServicios,*/ (req,res) => {
    res.sendFile(path + '/OrdenTrabajo/OT-A_FinalizarOT.html');
});

apisViews.get('/ordenTrabajo/OT-A_GenerarOT',/*functionsAuth.authAsesorServicios,*/ (req,res) => {
    res.sendFile(path + '/OrdenTrabajo/OT-A_GenerarOT.html');
});

apisViews.get('/ordenTrabajo/OT-A_RevisionVehiculo',/*functionsAuth.authAsesorServicios,*/ (req,res) => {
    res.sendFile(path + '/OrdenTrabajo/OT-A_RevisionVehiculo.html');
});
// jefe taller
apisViews.get('/ordenTrabajo/OT-J_AprobacionLista',/*functionsAuth.authJefeTaller,*/ (req,res) => {
    res.sendFile(path + '/OrdenTrabajo/OT-J_AprobacionLista.html');//>>>>>>>>>>>>>>>>>>>
});

apisViews.get('/ordenTrabajo/OT-J_ControlCalidad',/*functionsAuth.authJefeTaller,*/ (req,res) => {
    res.sendFile(path + '/OrdenTrabajo/OT-J_ControlCalidad.html');
});

apisViews.get('/ordenTrabajo/OT-J_AprobacionCotizacion',/*functionsAuth.authJefeTaller,*/ (req,res) => {
    res.sendFile(path + '/OrdenTrabajo/OT-J_AprobacionCotizacion.html');
});
// tecnico
apisViews.get('/ordenTrabajo/OT-T_FinalizarMantenimiento',/*functionsAuth.authTecnico,*/ (req,res) => {
    res.sendFile(path + '/OrdenTrabajo/OT-T_FinalizarMantenimiento.html');
});

apisViews.get('/ordenTrabajo/OT-T_Generarlista',/*functionsAuth.authTecnico,*/ (req,res) => {
    res.sendFile(path + '/OrdenTrabajo/OT-T_Generarlista.html');
});
// encargado bodega
apisViews.get('/ordenTrabajo/OT-E_RebajarInventario',/*functionsAuth.authEncargadoBodega,*/ (req,res) => {
    res.sendFile(path + '/OrdenTrabajo/OT-E_RebajarInventario.html');
});

// -- VISTAS RRHH
apisViews.get('/rrhh/RH_Home',/*functionsAuth.authHomeRRHH,*/ (req,res) => {
    res.sendFile(path + '/RRHH/RH_Home.html');
});
// jefe rrhh
apisViews.get('/rrhh/RH_Permisos',/*functionsAuth.authJefeRRHH,*/ (req,res) => {
    res.sendFile(path + '/RRHH/RH_Permisos.html');
});

apisViews.get('/rrhh/RH_Vacaciones',/*functionsAuth.authJefeRRHH,*/ (req,res) => {
    res.sendFile(path + '/RRHH/RH_Vacaciones.html');
});
// asistente rrhh
apisViews.get('/rrhh/RH_Contratos',/*functionsAuth.authAsistenteRRHH,*/ (req,res) => {
    res.sendFile(path + '/RRHH/RH_Contratos.html');
});

apisViews.get('/rrhh/RH_EntrevistaTrabajo',/*functionsAuth.authAsistenteRRHH,*/ (req,res) => {
    res.sendFile(path + '/RRHH/RH_EntrevistaTrabajo.html');
});

apisViews.get('/rrhh/RH_HorasExtras',/*functionsAuth.authAsistenteRRHH,*/ (req,res) => {
    res.sendFile(path + '/RRHH/RH_HorasExtras.html');
});

apisViews.get('/rrhh/RH_HuellaDigital',/*functionsAuth.authAsistenteRRHH,*/ (req,res) => {
    res.sendFile(path + '/RRHH/RH_HuellaDigital.html');
});

apisViews.get('/rrhh/RH_RolPago',/*functionsAuth.authAsistenteRRHH,*/ (req,res) => {
    res.sendFile(path + '/RRHH/RH_RolPago.html');
});

// -- PANTALLAS VEHICULOS
apisViews.get('/vehiculos/VE_Home',functionsAuth.authAsesorServicios, (req,res) => {
    res.sendFile(path + '/Vehiculos/VE_Home.html');
});

apisViews.get('/vehiculos/VE_AsociarClienteVehiculo',functionsAuth.authAsesorServicios, (req,res) => {
    res.sendFile(path + '/Vehiculos/VE_AsociarClienteVehiculo.html');
});

apisViews.get('/vehiculos/VE_RegistrarVehiculos',functionsAuth.authAsesorServicios, (req,res) => {
    res.sendFile(path + '/Vehiculos/VE_RegistrarVehiculos.html');
});

apisViews.get('/vehiculos/VE_RegistrarCliente',functionsAuth.authAsesorServicios, (req,res) => {
    res.sendFile(path + '/Vehiculos/VE_RegistrarCliente.html');
});
// EXPORTANDO LA API QUE MUESTRA LA VISTA
module.exports = apisViews;