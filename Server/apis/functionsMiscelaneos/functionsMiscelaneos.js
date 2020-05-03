'use strict'

// IMPORTANDO LOS MODULOS NECESARIOS
const sql = require('mssql');
const jwt = require('jsonwebtoken');
const nodemailer = require('nodemailer')
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


function GET_DATA_USER(req, res){
    const dataUser = {
        user: req.session.user,
        name: req.session.name,
        idCargo: req.session.idCargo
    };
    res.send(dataUser);
}

function GET_TABLESNAMES_DB(req, res){
    conn.connect().then(function(result){
        var reqDB = new sql.Request(conn);
        reqDB.query('SELECT * FROM INFORMATION_SCHEMA.TABLES').then(function(result){
            conn.close();
            res.send({data: result.recordsets[0]});
        })
        .catch(function(err){
            conn.close();
            res.send(messagesMiscelaneos.errorC2);
        });
    })
    .catch(function(err){
        res.send(messagesMiscelaneos.errorC1);
    });
}

function GET_CAMPOS_TABLE_DB(req, res){
    conn.connect().then(function(result){
        var reqDB = new sql.Request(conn);
        reqDB.query("SELECT COLUMN_NAME FROM Information_Schema.Columns WHERE TABLE_NAME = '"+req.body.nombreTabla+"' ORDER BY COLUMN_NAME")
        .then(function(result){
            conn.close();
            res.send({data: result.recordsets[0]});
        })
        .catch(function(err){
            conn.close();
            res.send(messagesMiscelaneos.errorC2);
        });
    })
    .catch(function(err){
        res.send(messagesMiscelaneos.errorC1);
    });
}

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


function sendEmail(emailRemitente, passwordRemitente,emailDestinatario, subjectEmail, mensajeEmail){
    var transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
            user: emailRemitente,
            pass: passwordRemitente
        }
    });
    var mailOptions = {
        from: emailRemitente,
        to: emailDestinatario,
        subject: subjectEmail,
        text: mensajeEmail
    };
    transporter.sendMail(mailOptions, function(error, info){
        if (error){
            return false;
        } else {
            return true;
        }
    });
}

// EXPORTANDO FUNCIONES MISCELANEAS
module.exports = {
    GENERIC_GESTION_TABLAS,
    GET_DATA_USER,
    GET_TABLESNAMES_DB,
    GET_CAMPOS_TABLE_DB,
    generateToken,
    authToken,
    sendEmail
};
