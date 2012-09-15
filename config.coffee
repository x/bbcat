module.exports = (app, express, mongoose)->
  config = this
  app.set('views', __dirname + '/views')
  app.set('view engine', 'jade')
  app.use(express.static(__dirname + '/public'))

  return config
