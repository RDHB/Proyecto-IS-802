'use strict'

// IMPORTANDO LOS MODULOS NECESARIOS
const sql = require('mssql');
const conn = require('../../db/connectionDB');
const messagesMiscelaneos = require('../../others/messagesMiscelaneos');
const functionsMiscelaneos = require('../functionsMiscelaneos/functionsMiscelaneos');

// DEFINIENDO LAS FUNCIONES
function GU_LOGIN(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pnombreUsuario',sql.VarChar,req.body.usuario);
        reqDB.input('pcontrasenia',sql.VarChar,req.body.password);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.output('pcodigoEmpleado', sql.VarChar);
        reqDB.output('pidCargo',sql.Int);
        reqDB.execute('GU_LOGIN').then(function(result){
            conn.close();
            var token;
            if(result.output.pcodigoMensaje == 0){
                req.session.name = req.body.usuario;
                req.session.password = req.body.password;
                req.session.idCargo = result.output.pidCargo;
                req.session.codigoEmpleado = result.output.pcodigoEmpleado;
                token = functionsMiscelaneos.generateToken(req.session.name)
                result.output.token = token;
                res.send(result.output);
            }else{
                res.send({pcodigoMensaje: result.output.pcodigoMensaje, pmensaje: result.output.pmensaje});    
            }
            
        }).catch(function(err){
            conn.close();
            res.send(messagesMiscelaneos.errorC2);
        });
    })
    .catch(function(err){
        res.send(messagesMiscelaneos.errorC1);
    });
};

function GU_GESTION_USUARIOS(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pcodigoEmpleado',sql.VarChar,req.body.codigoEmpleado);
        reqDB.input('pnombreUsuario',sql.VarChar,req.body.nombreUsuario);
        reqDB.input('pcontrasenia',sql.VarChar,req.body.contrasenia);
        reqDB.input('pAccion',sql.VarChar,req.body.accion);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.execute('GU_GESTION_USUARIOS').then(function(result){
            conn.close();
            res.send(result.output);
        }).catch(function(err){
            conn.close();
            res.send(messagesMiscelaneos.errorC2);
        });
    })
    .catch(function(err){
        res.send(messagesMiscelaneos.errorC1);
    });
};

// EXPORTANDO LAS FUNCIONES QUE ATENDERAN LAS PETICIONES
module.exports = {
    GU_LOGIN,
    GU_GESTION_USUARIOS
};