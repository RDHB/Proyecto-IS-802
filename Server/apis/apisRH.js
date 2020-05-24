'use strict'

// IMPORTANDO LOS MODULOS NECESARIOS
const express = require('express');
const functionsRH = require('./functionsQuerys/functionsRH');
const functionsMiscelaneos = require('./functionsMiscelaneos/functionsMiscelaneos');

// DEFINIENDO OBJETO QUE SE UTILIZAR PARA ATENDER LLAMADOS CON LA RUTA '/volvo/api/GU'
const apisRH = express.Router();

// DEFINIENDO SUBRUTAS Y ATENCION A PETICIONES AL SERVIDOR
apisRH.post('/RH_CONTRATOS',/*functionsMiscelaneos.authToken,*/functionsRH.RH_CONTRATOS);
apisRH.post('/RH_ENTREVISTA_TRABAJO',/*functionsMiscelaneos.authToken,*/functionsRH.RH_ENTREVISTA_TRABAJO);
apisRH.post('/RH_HUELLA',/*functionsMiscelaneos.authToken,*/functionsRH.RH_HUELLA);
apisRH.post('/RH_PERMISOS',/*functionsMiscelaneos.authToken,*/functionsRH.RH_PERMISOS);
apisRH.post('/RH_ROL_PAGO',/*functionsMiscelaneos.authToken,*/functionsRH.RH_ROL_PAGO);
apisRH.post('/RH_VACACIONES',/*functionsMiscelaneos.authToken,*/functionsRH.RH_VACACIONES);

// EXPORTANDO EL OBJETO DESEADO
module.exports = apisRH;