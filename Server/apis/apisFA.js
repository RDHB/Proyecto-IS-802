'use strict'

// IMPORTANDO LOS MODULOS NECESARIOS
const express = require('express');
const functionsFA = require('./functionsQuerys/functionsFA');
const functionsMiscelaneos = require('./functionsMiscelaneos/functionsMiscelaneos');

// DEFINIENDO OBJETO QUE SE UTILIZAR PARA ATENDER LLAMADOS CON LA RUTA '/volvo/api/GU'
const apisFA = express.Router();

// DEFINIENDO SUBRUTAS Y ATENCION A PETICIONES AL SERVIDOR
//apisFA.post('/OT_A_APROVACION_COTIZACION',/*functionsMiscelaneos.authToken,*/functionsFA.OT_A_APROVACION_COTIZACION);




// EXPORTANDO EL OBJETO DESEADO
module.exports = apisFA;