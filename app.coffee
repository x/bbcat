# app
express = require('express')
app = express()
app.mongoose = require('mongoose')

# config
require('./config')(app, express)

# models
models = {}
models.cats = require('./models/pet')(app.mongoose).model

# routes
require('./routes')(app, models)

# listen
app.listen(process.env.PORT || 3000)
