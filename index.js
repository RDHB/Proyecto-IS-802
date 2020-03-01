'use strict'

//LLAMADOS DE DOCUMENTACION REQUERIDA
const functGestionUsuario = require("./Server/funcionesQuery/gestionUsuario");
const qry = require("./Server/Conexion BD/Conexion_SQLServer");
const configServer = require('./Server/ConfiguracionServer/Config');
const bodyParser = require('body-parser');
const express = require('express');
const session = require('express-session');

//DEFINIENDO CONSTANTES IMPORTANTES
const port = configServer.port;
const app = express();

//DEFINIENDO MIDDLEWARE
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());
app.use(express.static('./APP'));

//DEFINIENDO VARIABLES PARA SESIONES
app.use(session({
    secret: 'QuegranSecretoj@@@',
    saveUninitialized: true,
    resave: true
}));


//ESCUCHANDO A TRAVEZ DEL PUERTO CONFIGURADO
app.listen(port, () => {
    console.log(`aplicacion corriendo en http://localhost:${port}`)
});

//-----------------------VISTAS----------------------------------------------------
//'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 
app.get('/volvo', (req,res) => {
    if(req.session.name){
        res.sendFile(__dirname + '/APP/index-demo.html');
    }else{
        res.sendFile(__dirname + '/APP/login.html');
    }
});

app.get('/login', (req,res) => {
    if(req.session.name){
        res.sendFile(__dirname + '/APP/index-demo.html');
    }else{
        res.sendFile(__dirname + '/APP/login.html');
    }
});


app.get('/session',(req,res)=>{
    if(req.session.name){
        res.send({
            name : req.session.name, 
            IdCargo : req.session.IdCargo,
            CodigoEmpleado : req.session.CodigoEmpleado
        });
    }else{
        res.send({message : 'no esta logueado'});
    }
}); 


//------------------------CONSULTAS BASES DE DATOS-----------------------------------
//'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
//usado para loguearse
app.post('/SP_LOGIN',(req,resp) => {
    functGestionUsuario.SP_LOGIN(qry,req.body.usuario,req.body.password,req,resp);
});

/*app.get('/GU_CARGAR_USUARIOS',(req,resp)=>{
    functGestionUsuario.GU_CARGAR_USUARIOS(qry, , ,resp)
});*/