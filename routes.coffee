module.exports = (app, models)->
  app.get '/', (req, res)->
    res.render('index.jade')

  app.get '/new/:name', (req, res)->
    console.log models
    models.pets.findOne name: req.params.name, (err, doc)->
      if err?
        throw err
      else if doc?
        res.send(500, 'name taken')
      else
        now = new Date()
        newPet = new models.pets
          name: req.params.name
          birthday: now
          lastCheckAt: now
          lastPoopAt: now
          lastFedAt: now
          lastPetAt: now
        newPet.update()
        newPet.save (err)->
          if err?
            response =
              status: 'Save Error'
              data: err
            throw err
          else
            res.redirect("/c/#{req.params.name}")
    
  app.get '/c/:catName', (req, res)->
    res.render('pet.jade')
    catName = req.params.catName
    #  models.pets.findOne name: req.params.name, (err, doc)->
    #    if err?
    #      res.render('pet.jade')
    #      #res.send(404, 'yo cat aint here')
    #    else
    #      res.render('pet.jade', pet: doc)
