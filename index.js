'use strict'

const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const port = process.env.PORT || 3000

app.use(bodyParser.urlencoded({extended: false}))
app.use(bodyParser.json())


var router = express.Router()
router.use('/views',express.static('../APP'))
app.use('/',router)

app.listen(port, () => {
    console.log(`aplicacion corriendo en http://localhost:${port}`)
}) 

app.get('/main', (req,res) => {
    res.send({message: 'API'})
})

