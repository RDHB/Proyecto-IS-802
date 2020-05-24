'use strict'

// IMPORTANDO LOS MODULOS NECESARIOS
const sql = require('mssql');
const conn = require('../../db/connectionDB');
const messagesMiscelaneos = require('../../others/messagesMiscelaneos');

// DEFINIENDO LAS FUNCIONES
/*function OT_A_APROVACION_COTIZACION(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pnumeroOT',sql.VarChar,req.body.numeroOT);
        reqDB.input('paccion',sql.VarChar,req.body.accion);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.execute('OT_A_APROVACION_COTIZACION').then(function(result){
            conn.close();
            res.send({output: result.output, data: result.recordsets[0]});                
        }).catch(function(err){
            conn.close();
            res.send(messagesMiscelaneos.errorC2);
        });
    })
    .catch(function(err){
        res.send(messagesMiscelaneos.errorC1);
    });
};

*/



// EXPORTANDO LAS FUNCIONES QUE ATENDERAN LAS PETICIONES
module.exports = {
};