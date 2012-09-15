module.exports = (app, models)->
  app.get '/', (req, res)->
    res.render('index.jade')

  app.post '/new/:name', (req, res)->
    response
    models.pet.findOne name: req.params.name, (err, doc)->
      if err?
        response =
          status: 'Find Error'
          data: err
        throw err
      else if doc?
        response =
          status: 'Name Taken'
          data: doc
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
    catName = req.params.catName
    models.pets.findOne name: req.params.name, (err, doc)->
      if err?
        res.send(404, 'yo cat aint here')
      else
        res.render('pet.jade', pet: doc)
