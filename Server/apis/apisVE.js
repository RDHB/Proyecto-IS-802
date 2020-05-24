'use strict'

// IMPORTANDO LOS MODULOS NECESARIOS
const express = require('express');
const functionsVE = require('./functionsQuerys/functionsVE');
const functionsMiscelaneos = require('./functionsMiscelaneos/functionsMiscelaneos');

// DEFINIENDO OBJETO QUE SE UTILIZAR PARA ATENDER LLAMADOS CON LA RUTA '/volvo/api/GU'
const apisVE = express.Router();

// DEFINIENDO SUBRUTAS Y ATENCION A PETICIONES AL SERVIDOR
apisVE.post('/VE_ASOCIAR_CYV',functionsMiscelaneos.authToken,functionsVE.VE_ASOCIAR_CYV);
apisVE.post('/VE_GESTION_CLIENTES',functionsMiscelaneos.authToken,functionsVE.VE_GESTION_CLIENTES);
apisVE.post('/VE_GESTION_VEHICULOS',functionsMiscelaneos.authToken,functionsVE.VE_GESTION_VEHICULOS);


// EXPORTANDO EL OBJETO DESEADO
module.exports = apisVE;