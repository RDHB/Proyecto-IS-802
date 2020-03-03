'use strict'

// IMPORTANDO LOS MODULOS NECESARIOS
const express = require('express');
const functionsGU = require('./functionsMiscelaneos/functionsMiscelaneos');

// DEFINIENDO OBJETO QUE SE UTILIZAR PARA ATENDER LLAMADOS CON LA RUTA '/volvo/api/Miscelaneos'
const apisMiscelaneos = express.Router();

// DEFINIENDO SUBRUTAS Y ATENCION A PETICIONES AL SERVIDOR


// EXPORTANDO EL OBJETO DESEADO
module.exports = apisMiscelaneos;