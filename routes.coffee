module.exports = (app, models)->
  app.get '/', (req, res)->
    res.render('index.jade')

  app.get '/c/:catName', (req, res)->
    catName = req.params.catName
    res.render('pet.jade')
