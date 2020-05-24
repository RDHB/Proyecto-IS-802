'use strict'

// IMPORTANDO LOS MODULOS NECESARIOS
const express = require('express');
const functionsOT = require('./functionsQuerys/functionsOT');
const functionsMiscelaneos = require('./functionsMiscelaneos/functionsMiscelaneos');

// DEFINIENDO OBJETO QUE SE UTILIZAR PARA ATENDER LLAMADOS CON LA RUTA '/volvo/api/GU'
const apisOT = express.Router();

// DEFINIENDO SUBRUTAS Y ATENCION A PETICIONES AL SERVIDOR
apisOT.post('/OT_A_APROVACION_COTIZACION',/*functionsMiscelaneos.authToken,*/functionsOT.OT_A_APROVACION_COTIZACION);
apisOT.post('/OT_A_CONTRATAR_SERVICIOS',/*functionsMiscelaneos.authToken,*/functionsOT.OT_A_CONTRATAR_SERVICIOS);
apisOT.post('/OT_A_COTIZACION',/*functionsMiscelaneos.authToken,*/functionsOT.OT_A_COTIZACION);
apisOT.post('/OT_A_GENERAR_OT',/*functionsMiscelaneos.authToken,*/functionsOT.OT_A_GENERAR_OT);
apisOT.post('/OT_A_REVISION_VEHICULO',/*functionsMiscelaneos.authToken,*/functionsOT.OT_A_REVISION_VEHICULO);
apisOT.post('/OT_E_REBAJAR_INVENTARIO',/*functionsMiscelaneos.authToken,*/functionsOT.OT_E_REBAJAR_INVENTARIO);
apisOT.post('/OT_J_APROVACION_COTIZACION',/*functionsMiscelaneos.authToken,*/functionsOT.OT_J_APROVACION_COTIZACION);
apisOT.post('/OT_J_APROVACION_LISTA',/*functionsMiscelaneos.authToken,*/functionsOT.OT_J_APROVACION_LISTA);
apisOT.post('/OT_T_FINALIZAR_MANTENIMIENTO',/*functionsMiscelaneos.authToken,*/functionsOT.OT_T_FINALIZAR_MANTENIMIENTO);
apisOT.post('/OT_A_GENERAR_LISTA',/*functionsMiscelaneos.authToken,*/functionsOT.OT_A_GENERAR_LISTA);




// EXPORTANDO EL OBJETO DESEADO
module.exports = apisOT;