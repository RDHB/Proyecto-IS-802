'use strict'

// IMPORTANDO LOS MODULOS NECESARIOS
const express = require('express');
const functionsGU = require('./functionsQuerys/funtionsGU');
const functionsMiscelaneos = require('./functionsMiscelaneos/functionsMiscelaneos');

// DEFINIENDO OBJETO QUE SE UTILIZAR PARA ATENDER LLAMADOS CON LA RUTA '/volvo/api/GU'
const apisGU = express.Router();

// DEFINIENDO SUBRUTAS Y ATENCION A PETICIONES AL SERVIDOR
apisGU.post('/GU_LOGIN',functionsGU.GU_LOGIN);
apisGU.post('/GU_LOGOUT', functionsMiscelaneos.authToken,functionsGU.GU_LOGOUT);
apisGU.post('/GU_GESTION_USUARIOS',functionsMiscelaneos.authToken,functionsGU.GU_GESTION_USUARIOS);
apisGU.post('/GU_REINICIO_CONTRASENIA',functionsMiscelaneos.authToken,functionsGU.GU_REINICIO_CONTRASENIA);
apisGU.post('/GU_CONFIG',functionsMiscelaneos.authToken,functionsGU.GU_CONFIG);



// EXPORTANDO EL OBJETO DESEADO
module.exports = apisGU;