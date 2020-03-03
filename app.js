'use strict'

// IMPORTANDO MODULOS NECESARIOS
const bodyParser = require('body-parser');
const express = require('express');
const session = require('express-session');
const config = require('./Server/settings/config');
const apisGU = require('./Server/apis/apisGU');
const apisMiscelaneos = require('./Server/apis/apisMiscelaneos');

//DEFINIENDO LA VARIABLE 'app' QUE ES EL SERVIDOR 
const app = express();

//DEFINIENDO MIDDLEWARE'S
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());
app.use(session(config.configSession));
app.use('/volvo/api/GU',apisGU);
app.use('/volvo/api/Miscelaneos',apisMiscelaneos);

// EXPORTANDO LA VARIABLE 'app'
module.exports = app;