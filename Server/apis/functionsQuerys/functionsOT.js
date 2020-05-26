'use strict'

// IMPORTANDO LOS MODULOS NECESARIOS
const sql = require('mssql');
const conn = require('../../db/connectionDB');
const messagesMiscelaneos = require('../../others/messagesMiscelaneos');

// DEFINIENDO LAS FUNCIONES
function OT_A_APROVACION_COTIZACION(req,res){
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

function OT_A_CONTRATAR_SERVICIOS(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pnumeroOT',sql.VarChar,req.body.numeroOT);
        reqDB.input('pidServicios',sql.VarChar,req.body.idServicios);
        reqDB.input('paccion',sql.VarChar,req.body.accion);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.execute('OT_A_CONTRATAR_SERVICIOS').then(function(result){
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

function OT_A_COTIZACION(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pnumeroOT',sql.VarChar,req.body.numeroOT);
        reqDB.input('pidProducto',sql.VarChar,req.body.idProducto);
        reqDB.input('pcantidad',sql.VarChar,req.body.cantidad);
        reqDB.input('paccion',sql.VarChar,req.body.accion);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.execute('OT_A_COTIZACION').then(function(result){
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


function OT_A_GENERAR_OT(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pvin',sql.VarChar,req.body.vin);
        reqDB.input('pnumeroIdentidad',sql.VarChar,req.body.numeroIdentidad);
        reqDB.input('paccion',sql.VarChar,req.body.accion);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.output('pnumeroOT',sql.VarChar);
        reqDB.execute('OT_A_GENERAR_OT').then(function(result){
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

function OT_A_REVISION_VEHICULO(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pnumeroOT',sql.VarChar,req.body.numeroOT);
        reqDB.input('pestado_del_vehiculo',sql.VarChar,req.body.estado_del_vehiculo);
        reqDB.input('pobjetosPersonales',sql.VarChar,req.body.objetosPersonales);
        reqDB.input('paccion',sql.VarChar,req.body.accion);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.execute('OT_A_REVISION_VEHICULO').then(function(result){
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


function OT_A_FINALIZAR_OT(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pnumeroOT',sql.VarChar,req.body.numeroOT);
        reqDB.input('paccion',sql.VarChar,req.body.accion);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.execute('OT_A_FINALIZAR_OT').then(function(result){
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


function OT_E_REBAJAR_INVENTARIO(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pnumeroOT',sql.VarChar,req.body.numeroOT);
        reqDB.input('paccion',sql.VarChar,req.body.accion);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.execute('OT_E_REBAJAR_INVENTARIO').then(function(result){
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


function OT_J_APROVACION_COTIZACION(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pnumeroOT',sql.VarChar,req.body.numeroOT);
        reqDB.input('paccion',sql.VarChar,req.body.accion);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.execute('OT_J_APROVACION_COTIZACION').then(function(result){
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


function OT_J_APROVACION_LISTA(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pnumeroOT',sql.VarChar,req.body.numeroOT);
        reqDB.input('paccion',sql.VarChar,req.body.accion);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.execute('OT_J_APROVACION_LISTA').then(function(result){
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


function OT_T_FINALIZAR_MANTENIMIENTO(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pnumeroOT',sql.VarChar,req.body.numeroOT);
        reqDB.input('preparacionesEfectuadas',sql.VarChar,req.body.reparacionesEfectuadas);
        reqDB.input('preparacionesNoEfectuadas',sql.VarChar,req.body.reparacionesNoEfectuadas);
        reqDB.input('paccion',sql.VarChar,req.body.accion);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.execute('OT_T_FINALIZAR_MANTENIMIENTO').then(function(result){
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


function OT_A_GENERAR_LISTA(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pnumeroOT',sql.VarChar,req.body.numeroOT);
        reqDB.input('pidProducto',sql.Int,req.body.idProducto);
        reqDB.input('pcantidad',sql.Int,req.body.cantidad);
        reqDB.input('paccion',sql.VarChar,req.body.accion);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.execute('OT_A_GENERAR_LISTA').then(function(result){
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

function OT_J_CONTROL_CALIDAD(req,res){
    conn.connect().then(function(){
        var reqDB = new sql.Request(conn);
        reqDB.input('pnumeroOT',sql.VarChar,req.body.numeroOT);
        reqDB.input('precomendaciones',sql.VarChar,req.body.recomendaciones);
        reqDB.input('paccion',sql.VarChar,req.body.accion);
        reqDB.output('pcodigoMensaje', sql.Int);
        reqDB.output('pmensaje', sql.VarChar);
        reqDB.execute('OT_J_CONTROL_CALIDAD').then(function(result){
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
    OT_A_APROVACION_COTIZACION,
    OT_A_CONTRATAR_SERVICIOS,
    OT_A_COTIZACION,
    OT_A_GENERAR_OT,
    OT_A_REVISION_VEHICULO,
    OT_E_REBAJAR_INVENTARIO,
    OT_J_APROVACION_COTIZACION,
    OT_J_APROVACION_LISTA,
    OT_T_FINALIZAR_MANTENIMIENTO,
    OT_A_GENERAR_LISTA,
    OT_A_FINALIZAR_OT,
    OT_J_CONTROL_CALIDAD
};