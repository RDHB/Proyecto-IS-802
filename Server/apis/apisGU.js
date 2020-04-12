'use strict'

// IMPORTANDO LOS MODULOS NECESARIOS
const express = require('express');
const functionsGU = require('./functionsQuerys/funtionsGU');

// DEFINIENDO OBJETO QUE SE UTILIZAR PARA ATENDER LLAMADOS CON LA RUTA '/volvo/api/GU'
const apisGU = express.Router();

// DEFINIENDO SUBRUTAS Y ATENCION A PETICIONES AL SERVIDOR
apisGU.post('/GU_LOGIN',functionsGU.GU_LOGIN);
apisGU.post('/GU_GESTION_USUARIOS',functionsGU.GU_GESTION_USUARIOS);


// EXPORTANDO EL OBJETO DESEADO
module.exports = apisGU;