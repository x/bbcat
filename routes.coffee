app.get '/', (req, res)->
  res.render('index')

app.get '/c/:catName', (req, res)->
  req.params.catName
