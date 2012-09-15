module.exports = (app, express)->
  config = this
  app.set('views', __dirname + '/views')
  app.set('view engine', 'jade')
  app.use('/public', express.static(__dirname + '/public'))

  app.mongoose.connect('mongodb://batman:robin@alex.mongohq.com:10066/bbcats')

  return config
