const session = require('express-session');
const sql = require("mssql");

// FUNCIONES CREADAS PARA CONSULTAR LA BASE DE DATOS MEDIANTE PROCEDIMIENTOS ALMACENADOS DE GESTION DE USUARIOS
function SP_LOGIN(conn,usuario,password,reqOrigin,resp){
        conn.connect().then(function(){
        var req = new sql.Request(conn);
        req.input('pcNombreUsuario',sql.VarChar,usuario);
        req.input('pcContrasenia',sql.VarChar,password);
        req.output('pnCodigoMensaje', sql.Int);
        req.output('pcMensaje', sql.VarChar);
        req.output('pnCodigoEmpleado', sql.VarChar);
        req.output('pnIdCargo',sql.Int);
        req.execute('SP_LOGIN').then(function(data){
            conn.close();
            if(data.output.pnCodigoMensaje == 0){
                reqOrigin.session.name = usuario;
                reqOrigin.session.password = password;
                reqOrigin.session.IdCargo = data.output.pnIdCargo;
                reqOrigin.session.CodigoEmpleado = data.output.pnCodigoEmpleado;
            }
            resp.send(data.output);
        })
        .catch(function(err){
            conn.close();
            resp.send({"pnCodigoMensaje": 2,
                       "pcMensaje": "Fallo la peticion con el procedimeinto almacenado"});
        }); 
    })
    .catch(function(err){
        resp.send({"pnCodigoMensaje": 1,
                   "pcMensaje": "Error: Fallo la conexion con la Base de Datos"});
    });
};


/*function GU_CARGAR_USUARIOS(qry, , ,resp){

};*/


module.exports = {
    SP_LOGIN
    //GU_CARGAR_USUARIOS
}