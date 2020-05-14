'use strict'

// IMPORTANDO MODULOS NECESARIOS
const bodyParser = require('body-parser');
const express = require('express');
const session = require('express-session');
const filesUpload = require('express-fileupload');
const config = require('./Server/settings/config');
const apisGU = require('./Server/apis/apisGU');
const apisVE = require('./Server/apis/apisVE');
const apisMiscelaneos = require('./Server/apis/apisMiscelaneos');
const apisViews = require('./Server/views/apisViews');
const functionsMiscelaneos = require('./Server/others/functionsMiscelaneos');

//DEFINIENDO LA VARIABLE 'app' QUE ES EL SERVIDOR 
const app = express();

//DEFINIENDO MIDDLEWARE'S
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());
app.use(session(config.configSession));
app.use(filesUpload());
app.use('/volvo/api/GU',apisGU);
app.use('/volvo/api/VE',apisVE);
app.use('/volvo/api/Miscelaneos',apisMiscelaneos);
app.use('/volvo/view',apisViews);

// DEFINIENDO PUNTO DE INICIO DE APLICACION
app.get('/volvo',(req,res) => {
    if(req.session.name){
        functionsMiscelaneos.redirectById(req,res);
    }else{
        res.redirect('/volvo/view/login');
    }
});

// EXPORTANDO LA VARIABLE 'app'
module.exports = app;