'use strict'

const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const port = process.env.PORT || 3000

app.use(bodyParser.urlencoded({extended: false}))
app.use(bodyParser.json())

app.get('/main', (req,res) => {
    res.send(
        {message: 'hola >:'}
    )
})

app.listen(port, () => {
    console.log(`aplicacion corriendo en http://localhost:${port}`)
})