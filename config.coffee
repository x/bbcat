module.exports = (app, express)->
  config = this
  app.set('views', __dirname + '/views')
  app.set('view engine', 'jade')
  app.use('/public', express.static(__dirname + '/public'))
  app.use(express.bodyParser())
  app.use(express.cookieParser())

  app.db = app.mongoose.createConnection('mongodb://batman:robin@alex.mongohq.com:10066/bbcats')

  return config
