'use strict'

// IMPORTANDO LOS MODULOS NECESARIOS
const sql = require('mssql');
const generatorPaswword = require('generate-password');
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
                req.session.user = req.body.usuario;
                req.session.password = req.body.password;
                req.session.name = result.recordset[0].Nombre;
                req.session.idCargo = result.output.pidCargo;
                req.session.codigoEmpleado = result.output.pcodigoEmpleado;
                token = functionsMiscelaneos.generateToken(req.session.name)
                result.output.nombre = result.recordset[0].Nombre;
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
        if(req.body.accion === 'INSERT'){
            req.body.contrasenia = generatorPaswword.generate({length: 10,numbers: true, symbols: true, lowercase: true, uppercase: true});
        }
        reqDB.input('pidUsuario',sql.Int,req.body.idUsuario);
        reqDB.input('pcodigoEmpleado',sql.VarChar,req.body.codigoEmpleado);
        reqDB.input('pnombreUsuario',sql.VarChar,req.body.nombreUsuario);
        reqDB.input('pcontrasenia',sql.VarChar,req.body.contrasenia);
        reqDB.input('pcorreoElectronico',sql.VarChar,req.body.correoElectronico);
        reqDB.input('ptelefono',sql.VarChar,req.body.telefono);
        reqDB.input('pnombrePersona',sql.VarChar,req.body.nombrePersona);
        reqDB.input('pidEstadoUsuario',sql.Int,req.body.idEstadoUsuario);
        reqDB.input('pidAreaTrabajo',sql.Int,req.body.idAreaTrabajo);
        reqDB.input('pAccion',sql.VarChar,req.body.accion);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.execute('GU_GESTION_USUARIOS').then(function(result){
            conn.close();
            if(result.output.pcodigoMensaje == 0 && req.body.accion === 'INSERT'){
                functionsMiscelaneos.sendEmail('testproject588@gmail.com','MLRroot3','test.usuarioprueba@gmail.com','VOLVO AUTOPARTES (PROJECT-PRUEBA) Creacion de Usuario',`Su usuario ha sido creado en el sistema, por favor reinicie la contraseña. Ingrese al sistema con usuario: ${req.body.nombreUsuario} y  contraseña: +${req.body.contrasenia}`);
            }
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

// EXPORTANDO LAS FUNCIONES QUE ATENDERAN LAS PETICIONES
module.exports = {
    GU_LOGIN,
    GU_GESTION_USUARIOS
};