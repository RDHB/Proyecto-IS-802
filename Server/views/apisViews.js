'use strict'

// IMPORTANDO LOS MODULOS NECESARIOS
const express = require('express');

// DEFINIENDO OBJETOS IMPORTANTES
const path = '/home/rdhb/Desktop/Repositorio GitHub/Proyecto-IS-802/APP';

// DEFINIENDO OBJETO QUE MANEJARA LA RUTA '/volvo/views/'
const apisViews = express.Router();

// DEFINIENDO MIDDLEWARES PARA SERVIR ARCHIVOS ESTATICOS
apisViews.use(express.static(path));

// DEFINIENDO APIS PARA MOSTRAR CADA UNA DE LAS VISTA
apisViews.get('/login', (req,res) => {
    res.sendFile(path + '/login.html');
});

apisViews.get('/home/facturacion/FA', (req,res) => {
    res.sendFile(path + '/Facturacion/FA_Home.html');
});

apisViews.get('/home/gestionUsuario', (req,res) => {
    res.sendFile(path + '/GestionUsuario/GU_Home.html');
});

apisViews.get('/home/ordenTrabajo/OT-A', (req,res) => {
    res.sendFile(path + '/OrdenTrabajo/OT-A_Home.html');
});

apisViews.get('/home/rrhh/RH', (req,res) => {
    res.sendFile(path + '/RRHH/RH_Home.html');
});

apisViews.get('/home/vehiculos/VE', (req,res) => {
    res.sendFile(path + '/Vehiculos/VE_Home.html');
});

// EXPORTANDO LA API QUE MUESTRA LA VISTA
module.exports = apisViews;