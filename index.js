'use strict'

// IMPORTANDO LOS MODULOS NECESARIOS
const config = require('./Server/settings/config');
const app = require('./app');

//ESCUCHANDO A TRAVEZ DEL PUERTO CONFIGURADO EN 'settings/config'
app.listen(config.configServer.port, () => {
    console.log(`aplicacion corriendo en http://localhost:${config.configServer.port}`)
});
