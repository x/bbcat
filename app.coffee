# app
express = require('express')
app = express()
app.mongoose = require('mongoose')
env = process.env.NODE_ENV || 'development'

# config
require('./config')(app, express)

# models
models = {}
models.pets = require('./models/pet')(app, app.mongoose).model

app.use((req, res, next) ->
  if env == 'production'
    if req.headers.host.match(/^www/) != null
      next()
    else
      url = 'http://www.bbcat.co' + req.url
      util.log("Redirecting to " + url)
      res.redirect(url)
  else
    next()
)

# routes
require('./routes')(app, models)

# listen
app.listen(process.env.PORT || 3000)
