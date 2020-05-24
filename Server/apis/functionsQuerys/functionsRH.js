'use strict'

// IMPORTANDO LOS MODULOS NECESARIOS
const sql = require('mssql');
const conn = require('../../db/connectionDB');
const messagesMiscelaneos = require('../../others/messagesMiscelaneos');

// DEFINIENDO LAS FUNCIONES
function RH_CONTRATOS(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pnumeroIdentidad',sql.VarChar,req.body.numeroIdentidad);
        reqDB.input('psueldo',sql.Decimal,req.body.sueldo);
        reqDB.input('phoraInicio',sql.Time,req.body.horaInicio);
        reqDB.input('phoraFin',sql.Time,req.body.horaFin);
        reqDB.input('pidTipoContrato',sql.Int,req.body.idTipoContrato);
        reqDB.input('pidAreaTrabajo',sql.Int,req.body.idAreaTrabajo);
        reqDB.input('pidCargo',sql.Int,req.body.idCargo);
        reqDB.input('paccion',sql.VarChar,req.body.accion);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.output('pcodigoEmpleado', sql.VarChar);
        reqDB.execute('RH_CONTRATOS').then(function(result){
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


function RH_ENTREVISTA_TRABAJO(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pnumeroIdentidad',sql.VarChar,req.body.numeroIdentidad);
        reqDB.input('pprimerNombre',sql.VarChar,req.body.primerNombre);
        reqDB.input('psegundoNombre',sql.VarChar,req.body.segundoNombre);
        reqDB.input('pprimerApellido',sql.VarChar,req.body.primerApellido);
        reqDB.input('psegundoApellido',sql.VarChar,req.body.segundoApellido);
        reqDB.input('pcorreoElectronico',sql.VarChar,req.body.correoElectronico);
        reqDB.input('pdireccion',sql.VarChar,req.body.direccion);
        reqDB.input('pnumeroTelefono',sql.VarChar,req.body.numeroTelefono);
        reqDB.input('pidGenero',sql.Int,req.body.idGenero);
        reqDB.input('pdescripcion',sql.VarChar,req.body.descripcion);
        reqDB.input('pFecha',sql.Date,req.body.fecha);
        reqDB.input('paccion',sql.VarChar,req.body.accion);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.output('pNombreArchivo', sql.VarChar);
        reqDB.execute('RH_ENTREVISTA_TRABAJO').then(function(result){
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

function RH_HORAS_EXTRAS(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pidAreaTrabajo',sql.VarChar,req.body.idAreaTrabajo);
        reqDB.input('pfecha',sql.VarChar,req.body.fecha);
        reqDB.input('paccion',sql.VarChar,req.body.accion);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.output('phoraInicio', sql.VarChar);
        reqDB.output('phoraFin', sql.VarChar);
        reqDB.execute('RH_HORAS_EXTRAS').then(function(result){
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


function RH_HUELLA(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pcodigoEmpleado',sql.VarChar,req.body.codigoEmpleado);
        reqDB.input('pfecha',sql.Date,req.body.fecha);
        reqDB.input('paccion',sql.VarChar,req.body.accion);        
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.output('pCargo', sql.VarChar);
        reqDB.output('pAreaTrabajo', sql.VarChar);
        reqDB.output('pdescripcion', sql.VarChar);
        reqDB.output('phoraEntrada', sql.Time);
        reqDB.output('phoraSalida', sql.Time);
        reqDB.execute('RH_HUELLA').then(function(result){
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


function RH_PERMISOS(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pcodigoEmpleado',sql.VarChar,req.body.codigoEmpleado);
        reqDB.input('pmotivo',sql.VarChar,req.body.motivo);
        reqDB.input('pfecha',sql.Date,req.body.fecha);
        reqDB.input('pdescripcion',sql.VarChar,req.body.descripcion);
        reqDB.input('paccion',sql.VarChar,req.body.accion);        
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.output('pnombreCompleto', sql.VarChar);
        reqDB.output('pcargo', sql.VarChar);
        reqDB.execute('RH_PERMISOS').then(function(result){
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


function RH_ROL_PAGO(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pcodigoEmpleado',sql.VarChar,req.body.codigoEmpleado);
        reqDB.input('ppagoHE',sql.Decimal,req.body.pagoHE);
        reqDB.input('pcomisiones',sql.Decimal,req.body.comisiones);
        reqDB.input('pdeducciones',sql.Decimal,req.body.deducciones);
        reqDB.input('paccion',sql.VarChar,req.body.accion);        
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.output('pnumeroPago', sql.VarChar);
        reqDB.execute('RH_ROL_PAGO').then(function(result){
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


function RH_VACACIONES(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pcodigoEmpleado',sql.VarChar,req.body.codigoEmpleado);
        reqDB.input('pcantidadDias',sql.Int,req.body.cantidadDias);
        reqDB.input('pfechaInicio',sql.Date,req.body.fechaInicio);
        reqDB.input('pdescripcion',sql.VarChar,req.body.descripcion);
        reqDB.input('paccion',sql.VarChar,req.body.accion);        
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.output('pfechaFin', sql.Date);
        reqDB.output('pfechaReingreso', sql.Date);
        reqDB.output('pnombreCompleto', sql.VarChar);
        reqDB.output('pcargo', sql.VarChar);
        reqDB.execute('RH_VACACIONES').then(function(result){
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




// EXPORTANDO LAS FUNCIONES QUE ATENDERAN LAS PETICIONES
module.exports = {
    RH_CONTRATOS,
    RH_ENTREVISTA_TRABAJO,
    RH_HORAS_EXTRAS,
    RH_HUELLA,
    RH_PERMISOS,
    RH_ROL_PAGO,
    RH_VACACIONES
};