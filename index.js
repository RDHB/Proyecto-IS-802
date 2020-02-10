'use strict'

const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const port = process.env.PORT || 3000

app.use(express.static(__dirname + '/APP'))
app.use(bodyParser.urlencoded({extended: false}))
app.use(bodyParser.json())

//ESCUCHANDO A TRAVEZ DEL PUERTO 3000
app.listen(port, () => {
    console.log(`aplicacion corriendo en http://localhost:${port}`)
})

//CONFIGURANDO DIRECCIONES PARA LAS VISTAS
app.get('/main', (req,res) => {
    res.sendFile(__dirname + '/APP/main.html')
})

app.get('/login', (req,res) => {
    res.sendFile(__dirname + '/APP/login.html')
})


//CONFIGURANDO LAS DIFERENTES PETICIONES GET, POST, PUT, DELETE