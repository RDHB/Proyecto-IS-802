'use strict'

// IMPORTANDO LOS MODULOS NECESARIOS
const sql = require('mssql');
const jwt = require('jsonwebtoken');
const conn = require('../../db/connectionDB');
const messagesMiscelaneos = require('../../others/messagesMiscelaneos');
const secretToken = require('../../settings/config')


// DEFINIENDO FUNCIONES MISCELANEAS
function GENERIC_GESTION_TABLAS(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pNombreTabla',sql.VarChar,req.body.nombreTabla);
        reqDB.input('pNombreCampo',sql.VarChar,req.body.nombreCampo);
        reqDB.input('pFiltroCampo',sql.VarChar,req.body.filtroCampo);
        reqDB.input('pjson',sql.VarChar,req.body.json);
        reqDB.input('paccion',sql.VarChar,req.body.accion);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.execute('GENERIC_GESTION_TABLAS').then(function(result){
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

function generateToken (user){
    return jwt.sign({username:user}, secretToken.configToken.key, { expiresIn: 60*60*24});
}

function authToken(req, res, next){
    const token = req.headers['authorization'].replace('Bearer ','');

    if (token == null){
        res.send(messagesMiscelaneos.errorC6);
    }else{
        jwt.verify(token, secretToken.configToken.key,(err,decoded)=>{
            if(decoded){
                req.decoded = decoded;
                next();
            }else if(err){
                res.send(messagesMiscelaneos.errorC6);
            }
        });
    }
}

// EXPORTANDO FUNCIONES MISCELANEAS
module.exports = {
    GENERIC_GESTION_TABLAS,
    generateToken,
    authToken
};