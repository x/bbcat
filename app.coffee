# app
app = require('express')()
app.mongoose = require('mongoose')

# config
require('./config')

# models
models = {}
models.cats = require('./models/pet')(app.mongoose).model

# routes
require('./routes')(app, models)

# listen
app.listen(process.env.PORT || 3000)
