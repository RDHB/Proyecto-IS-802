'use strict'

// IMPORTANDO LOS MODULOS NECESARIOS
const sql = require('mssql');
const conn = require('../../db/connectionDB');
const messagesMiscelaneos = require('../../others/messagesMiscelaneos');

// DEFINIENDO LAS FUNCIONES
function SP_LOGIN(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pnombreUsuario',sql.VarChar,req.body.usuario);
        reqDB.input('pcontrasenia',sql.VarChar,req.body.password);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.output('pcodigoEmpleado', sql.VarChar);
        reqDB.output('pidCargo',sql.Int);
        reqDB.execute('SP_LOGIN').then(function(result){
            conn.close();
            if(result.output.pcodigoMensaje == 0){
                req.session.name = req.body.usuario;
                req.session.password = req.body.password;
                req.session.idCargo = result.output.pidCargo;
                req.session.codigoEmpleado = result.output.pcodigoEmpleado;
            }
            res.send(result.output);
        }).catch(function(err){
            conn.close();
            resp.send(messagesMiscelaneos.errorC2);
        });
    })
    .catch(function(err){
        res.send(messagesMiscelaneos.errorC1);
    });
};

// EXPORTANDO LAS FUNCIONES QUE ATENDERAN LAS PETICIONES
module.exports = {
    SP_LOGIN
};