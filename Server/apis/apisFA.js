'use strict'

// IMPORTANDO LOS MODULOS NECESARIOS
const express = require('express');
const functionsFA = require('./functionsQuerys/functionsFA');
const functionsMiscelaneos = require('./functionsMiscelaneos/functionsMiscelaneos');

// DEFINIENDO OBJETO QUE SE UTILIZAR PARA ATENDER LLAMADOS CON LA RUTA '/volvo/api/GU'
const apisFA = express.Router();

// DEFINIENDO SUBRUTAS Y ATENCION A PETICIONES AL SERVIDOR
apisFA.post('/FA_FACTURA',/*functionsMiscelaneos.authToken,*/functionsFA.FA_FACTURA);




// EXPORTANDO EL OBJETO DESEADO
module.exports = apisFA;