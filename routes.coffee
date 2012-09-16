module.exports = (app, models)->
  app.get '/', (req, res)->
    res.render('index.jade')
 
  app.post '/feed', (req, res)->
    console.log req.body
    name = req.body.pet.name
    now = new Date()
    models.pets.findOne name: name, (err, doc)->
      unless err?
        doc.lastFedAt = now
        doc.update()
        doc.save (err)->
          unless err?
            res.send doc

  app.post '/heal', (req, res)->
    console.log req.body
    name = req.body.pet.name
    now = new Date()
    models.pets.findOne name: name, (err, doc)->
      unless err?
        doc.updateHealth()
        doc.save (err)->
          unless err?
            res.send doc

  app.post '/clean', (req, res)->
    name = req.body.pet.name
    now = new Date()
    models.pets.findOne name: name, (err, doc)->
      unless err?
        doc.lastCleanAt = now
        doc.update()
        doc.save (err)->
          unless err?
            res.send doc

  app.post '/play', (req, res)->
    name = req.body.pet.name
    now = new Date()
    models.pets.findOne name: name, (err, doc)->
      unless err?
        doc.lastPetAt = now
        doc.update()
        doc.save (err)->
          unless err?
            res.send doc
  
  app.post '/new', (req, res)->
    models.pets.findOne name: req.body.name, (err, doc)->
      if err?
        throw err
      else if doc?
        res.send(500, 'name taken')
      else
        now = new Date()
        earlierToday = now - 21600000
        newPet = new models.pets
          name: req.body.name
          birthday: now
          health: 60
          lastCheckAt: now
          lastPoopAt: now
          lastFedAt: earlierToday
          lastPetAt: earlierToday
        newPet.update()
        newPet.save (err)->
          if err?
            response =
              status: 'Save Error'
              data: err
            throw err
          else
            res.redirect("/c/#{req.body.name}")
    
  app.get '/c/:catName', (req, res)->
    catName = req.params.catName
    models.pets.findOne name: catName, (err, doc)->
      if err? || !doc
        res.status(404)
        res.render('404.jade')
      else
        doc.update()
        datelessCat = doc.datelessModel()
        res.render('pet.jade', pet: JSON.stringify(datelessCat))

  app.get '*', (req, res)->
    res.status(404)
    res.render('404.jade')
