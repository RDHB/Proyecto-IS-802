'use strict'

//LLAMADOS DE DOCUMENTACION REQUERIDA
const functGestionUsuario = require("./Server/funcionesQuery/gestionUsuario");
const qry = require("./Server/Conexion BD/Conexion_SQLServer");
const configServer = require('./Server/ConfiguracionServer/Config');
const bodyParser = require('body-parser');
const express = require('express');

//DEFINIENDO CONSTANTES IMPORTANTES
const port = configServer.port;
const app = express();

//DEFINIENDO MIDDLEWARE
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

//ESCUCHANDO A TRAVEZ DEL PUERTO CONFIGURADO
app.listen(port, () => {
    console.log(`aplicacion corriendo en http://localhost:${port}`)
});

// POST VALIDACION DE USUARIO
app.post('/usuario',(req,resp) => {
    functGestionUsuario.queryLogin(qry,req.body.usuario,req.body.password,resp);
});
