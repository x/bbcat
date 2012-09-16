module.exports = (app, mongoose)->
  
  # scale for frequency of required care taking
  # feeding : scale*1 times per day
  # petting : scale*5 times per day
  # pooping : scale*3 times per day
  # health : no cleaning for 48hours/scale kills
  scale = 3

  petSchema = new mongoose.Schema
    name: String
    birthday: Date
    lastCheck: Date
    lastCleanAt: Date
    lastFedAt: Date
    lastPetAt: Date
    health: Number # 0 to 100
    hunger: Number # 0 to 100
    happy: Number # 0 to 100
    poop: Boolean
  
  msInDay = 86400000
  petSchema.methods = 
    datelessModel: ->
      now = new Date()
      that = this
      newModel =
        name: that.name
        daysOld: that.daysOld()
        health: that.health
        hunger: that.hunger
        happy: that.happy
        poop: that.poop
      console.log newModel
      return newModel
    
    daysOld: ->
      now = new Date()
      Math.floor((now - @birthday)/msInDay)

    update: -> 
      now = new Date()
      timeSincePoop = now - @lastCleanAt
      timeSinceFed = now - @lastFedAt
      timeSincePet = now - @lastPetAt
      @updateHunger(timeSinceFed)
      @updatePoop(timeSincePoop)
      @updateHappy(timeSincePet)
      
    updateHunger: (timeSinceFed)->
      @hunger = 100 - (timeSinceFed/msInDay)*100*scale
      
    updatePoop: (timeSincePoop)->
      @poop = false
      if timeSincePoop > msInDay/(3*scale)
        @poop = true
        @health = 100 - (timeSincePoop/msInDay)*50*scale

    updateHealth: (timeSincePoop)->
      unless @poop
        health = 100
    
    updateHappy: (timeSincePet)->
      fedSadness = 100 - @hunger
      petSadness = (timeSincePet/msInDay)*100*5*scale
      if @poop
        cleanSadness = 100
      else
        cleanSadness = 0
      @happy = 100 - fedSadness/4 - petSadness/2 - cleanSadness/4

  @model = app.db.model('pets', petSchema)

  return this
