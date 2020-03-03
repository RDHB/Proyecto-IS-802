'use strict'

// SE EXPORTAN DIVERSOS DATOS DE INTERES PARA LA CONEXION EN EL SERVIDOR Y LA REALIZAR LA CONEXION A LA BASE DE DATOS INSTALADO EN EL SERVIDOR

module.exports = {
    configServer : {
        port : process.env.PORT || 3000
    },
    configDB : {
        server: "localhost",
        database: "VOLVODB",
        user: "sa",
        password: "MLRroot3",
        port: 1433,
        parseJSON: true
    },
    configSession : {
        secret: 'QuegranSecretoj@@@',
        saveUninitialized: true,
        resave: true
    }
};