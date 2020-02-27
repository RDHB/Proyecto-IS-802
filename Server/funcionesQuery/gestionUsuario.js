var sql = require("mssql");

// FUNCIONES CREADAS PARA CONSULTAR LA BASE DE DATOS MEDIANTE PROCEDIMIENTOS ALMACENADOS DE GESTION DE USUARIOS
function queryLogin(conn,usuario,password,resp){
        conn.connect().then(function(){
        var req = new sql.Request(conn);
        req.input('pcNombreUsuario',sql.VarChar,usuario);
        req.input('pcContrasenia',sql.VarChar,password);
        req.output('pnCodigoMensaje', sql.Int);
        req.output('pcMensaje', sql.VarChar);
        req.output('pnCodigoEmpleado', sql.VarChar);
        req.execute('SP_LOGIN').then(function(data){
            conn.close();
            resp.send(data.output);
    
        })
        .catch(function(err){
            conn.close();
            resp.send(err);
        }); 
    })
    .catch(function(err){
        resp.send(err);
    });
};


module.exports = {
    queryLogin
}