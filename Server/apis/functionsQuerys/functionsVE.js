'use strict'

// IMPORTANDO LOS MODULOS NECESARIOS
const sql = require('mssql');
const conn = require('../../db/connectionDB');
const messagesMiscelaneos = require('../../others/messagesMiscelaneos');

// DEFINIENDO LAS FUNCIONES
function VE_ASOCIAR_CYV(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pvin',sql.VarChar,req.body.vin);
        reqDB.input('pnumeroIdentidad',sql.VarChar,req.body.numeroIdentidad);
        reqDB.input('paccion',sql.VarChar,req.body.accion);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.execute('VE_ASOCIAR_CYV').then(function(result){
            conn.close();
            if(req.body.accion === 'LINK' || req.body.accion === 'UNLINK'){
                res.send(result.output);
            }else if(req.body.accion === 'SELECT'){
                res.send({output:result.output,data: result.recordsets});
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

function VE_GESTION_CLIENTES(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pprimerNombre',sql.VarChar,req.body.primerNombre);
        reqDB.input('psegundoNombre',sql.VarChar,req.body.segundoNombre	);
        reqDB.input('pprimerapellido',sql.VarChar,req.body.primerapellido);
        reqDB.input('psegundoapellido',sql.VarChar,req.body.segundoapellido);
        reqDB.input('pcorreoElectronico',sql.VarChar,req.body.correoElectronico);
        reqDB.input('pdireccion',sql.VarChar,req.body.direccion);
        reqDB.input('pnumeroIdentidad',sql.VarChar,req.body.numeroIdentidad);
        reqDB.input('pidGenero',sql.Int,req.body.idGenero);
        reqDB.input('pnumeroTelefono',sql.VarChar,req.body.numeroTelefono);
        reqDB.input('paccion',sql.VarChar,req.body.accion);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.execute('VE_GESTION_CLIENTES').then(function(result){
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

function VE_GESTION_VEHICULOS(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pvin',sql.VarChar,req.body.vin);
        reqDB.input('pcolor',sql.VarChar,req.body.color	);
        reqDB.input('pplaca',sql.VarChar,req.body.placa);
        reqDB.input('pnumeroMotor',sql.VarChar,req.body.numeroMotor);
        reqDB.input('pcaja_de_cambios',sql.VarChar,req.body.caja_de_cambios);
        reqDB.input('pidModelo',sql.Int,req.body.idModelo);
        reqDB.input('paccion',sql.VarChar,req.body.accion);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.execute('VE_GESTION_VEHICULOS').then(function(result){
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
    VE_ASOCIAR_CYV,
    VE_GESTION_CLIENTES,
    VE_GESTION_VEHICULOS
};