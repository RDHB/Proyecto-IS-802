'use strict'

// IMPORTANDO LOS MODULOS NECESARIOS
const express = require('express');
const functionsMiscelaneos = require('./functionsMiscelaneos/functionsMiscelaneos');

// DEFINIENDO OBJETO QUE SE UTILIZAR PARA ATENDER LLAMADOS CON LA RUTA '/volvo/api/Miscelaneos'
const apisMiscelaneos = express.Router();

// MIDDELEWARE PARA AUTENTICAS LAS APIS DE ESTA RUTA
apisMiscelaneos.use(functionsMiscelaneos.authToken);

// DEFINIENDO SUBRUTAS Y ATENCION A PETICIONES AL SERVIDOR
apisMiscelaneos.post('/GENERIC_GESTION_TABLAS',functionsMiscelaneos.GENERIC_GESTION_TABLAS);

// EXPORTANDO EL OBJETO DESEADO
module.exports = apisMiscelaneos;