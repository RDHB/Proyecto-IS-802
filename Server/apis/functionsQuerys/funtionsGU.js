'use strict'

// IMPORTANDO LOS MODULOS NECESARIOS
const sql = require('mssql');
const generatorPaswword = require('generate-password');
const fs = require('fs');
const conn = require('../../db/connectionDB');
const messagesMiscelaneos = require('../../others/messagesMiscelaneos');
const functionsMiscelaneos = require('../functionsMiscelaneos/functionsMiscelaneos');
const directorio = require('../../../ruta');

// DEFINIENDO OBJETOS IMPORTANTES
const pathFoto = directorio.ruta.replace(/\\/g,'/') + "/APP/images/Usuarios/";

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
                result.output.idEmpleado = result.recordset[0].idEmpleado;
                result.output.token = token;
                result.output.usuario = req.body.usuario;
                result.output.nombreArchivo = '../images/Usuarios/'+result.recordsets[0][0].nombreArchivo;
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

function GU_LOGOUT(req,res){            
    req.session.user = null;
    req.session.password = null;
    req.session.name = null;
    req.session.idCargo = null;
    req.session.codigoEmpleado = null;
    res.send(messagesMiscelaneos.logOut);
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
                functionsMiscelaneos.sendEmail('testproject588@gmail.com','MLRroot3','test.usuarioprueba@gmail.com','VOLVO AUTOPARTES (PROJECT-PRUEBA) Creacion de Usuario',`Su usuario ha sido creado en el sistema, por favor reinicie la contraseña.
                Ingrese al sistema con usuario: ${req.body.nombreUsuario} y  contraseña: +${req.body.contrasenia}`);
            }
            res.send({output: result.output, data: result.recordsets[0]});
        }).catch(function(err){
            conn.close();
            res.send(messagesMiscelaneos.errorC2);
        });
    }).catch(function(err){
        res.send(messagesMiscelaneos.errorC1);
    });
};


function GU_REINICIO_CONTRASENIA(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pnombreUsuario',sql.VarChar,req.body.nombreUsuario);
        reqDB.input('paccion',sql.VarChar,req.body.accion);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.output('presetContrasenia', sql.VarChar);
        reqDB.execute('GU_REINICIO_CONTRASENIA').then(function(result){
            conn.close();
            if(result.output.pcodigoMensaje == 0 && req.body.accion === 'RESET'){
                functionsMiscelaneos.sendEmail('testproject588@gmail.com','MLRroot3','test.usuarioprueba@gmail.com','VOLVO AUTOPARTES (PROJECT-PRUEBA) Reinicio de Contraseña',`Su contraseña ha sido reiniciada por el administrador del sistema. Por favor cambie su contraseña. 
                Ingrese al sistema con usuario: ${req.body.nombreUsuario} y  contraseña: +${result.output.presetContrasenia}`);
            }
            res.send({output: result.output, data: result.recordsets[0]});
        }).catch(function(err){
            conn.close();
            res.send(messagesMiscelaneos.errorC2);
        });
    }).catch(function(err){
        res.send(messagesMiscelaneos.errorC1);
    });
}

function GU_CONFIG (req,res){
    if( req.body.accion === 'UPDATE-FPERFIL' ){
        if( req.files.nombreArchivo.mimetype.indexOf('image/') !== -1 ){
            req.body.extensionArchivo = '.' + req.files.nombreArchivo.mimetype.replace('image/','');
        }else{
            res.send({output : messagesMiscelaneos.errorC5});
            return;
        }
    }
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('paccion',sql.VarChar,req.body.accion);
        reqDB.input('pnombreUsuario',sql.VarChar,req.body.nombreUsuario);
        reqDB.input('pnewContrasenia',sql.VarChar,req.body.newContrasenia);
        reqDB.input('pnewNombreUsuario',sql.VarChar,req.body.newNombreUsuario);
        reqDB.input('pnewCorreoElectronico',sql.VarChar,req.body.newCorreoElectronico);
        reqDB.input('pnewDireccion',sql.VarChar,req.body.newDireccion);
        reqDB.input('pextensionArchivo',sql.VarChar,req.body.extensionArchivo);
        reqDB.input('pnewTelefono',sql.VarChar,req.body.newTelefono);
        reqDB.input('pidTelefono',sql.Int,req.body.idTelefono);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.output('pnombreArchivo', sql.VarChar);
        reqDB.output('pnombreArchivoAnterior', sql.VarChar);
        reqDB.execute('GU_CONFIG').then(function(result){
            conn.close();
            if(result.output.pcodigoMensaje == 0){
                switch(req.body.accion){
                    case 'UPDATE-CONTRASENIA':{
                        functionsMiscelaneos.sendEmail('testproject588@gmail.com','MLRroot3','test.usuarioprueba@gmail.com','VOLVO AUTOPARTES (PROJECT-PRUEBA) Cambio de Contraseña',`Su contraseña ha sido cambiada recientemente.
                        Recuerde ingresar al sistema con usuario: ${req.body.nombreUsuario} y  contraseña: ${req.body.newContrasenia}. 
                        Si usted no ha realizado estos cambios reporte inmediatamente con el administrador del sistema`);
                        break;
                    }
                    case 'UPDATE-USUARIO':{
                        functionsMiscelaneos.sendEmail('testproject588@gmail.com','MLRroot3','test.usuarioprueba@gmail.com','VOLVO AUTOPARTES (PROJECT-PRUEBA) Cambio de Nombre de Usuario',`Su nombre de usuario ha sido cambiado recientemente. 
                        Recuerde ingresar al sistema con el nombre de usuario: ${req.body.newNombreUsuario}.
                        Si usted no ha realizado estos cambios reporte inmediatamente con el administrador del sistema`);
                        break;
                    }
                    case 'UPDATE-FPERFIL':{            
                        var error = 0;
                        var foto = req.files.nombreArchivo;
                        var fotoName = result.output.pnombreArchivo;
                        if( result.output.pnombreArchivoAnterior !== 'default.png' ){
                            var oldFotoName = result.output.pnombreArchivoAnterior;
                            fs.unlink( pathFoto + oldFotoName, (error)=>{});
                        }
                        foto.mv( pathFoto + fotoName, function(err){if(err){error = 7;}});
                        if(error !=0){
                            res.send({output : messagesMiscelaneos.errorC7});
                            return;
                        }
                        result.output.pnombreArchivo = '../images/Usuarios/'+result.output.pnombreArchivo;
                        break;
                    }
                    case 'DELETE-FPERFIL':{
                        if( result.output.pnombreArchivoAnterior !== 'default.png' ){
                            var oldFotoName = result.output.pnombreArchivoAnterior;
                            fs.unlink( pathFoto + oldFotoName, (error)=>{});
                        }
                        result.output.pnombreArchivo = '../images/Usuarios/'+result.output.pnombreArchivo;
                        break;
                    }
                        
                }
            }
            res.send({output: result.output, data: result.recordsets[0]});
        }).catch(function(err){
            conn.close();
            res.send(messagesMiscelaneos.errorC2);
        });
    }).catch(function(err){
        res.send(messagesMiscelaneos.errorC1);
    });
}


// EXPORTANDO LAS FUNCIONES QUE ATENDERAN LAS PETICIONES
module.exports = {
    GU_LOGIN,
    GU_LOGOUT,
    GU_GESTION_USUARIOS,
    GU_REINICIO_CONTRASENIA,
    GU_CONFIG
};