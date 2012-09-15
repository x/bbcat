module.exports = (app, mongoose)->
  
  petSchema = new mongoose.Schema
    name: String
    birthday: Date
    lastCheck: Date
    lastPoopAt: Date
    lastFedAt: Date
    lastPetAt: Date
    health: Number # 0 to 100
    hunger: Number # 0 to 100
    happy: Number # 0 to 100
    poop: Boolean
  
  msInDay = 86400000
  petSchema.methods = 
    daysOld: ->
      now = new Date()
      Math.floor((now - @birthday)/msInDay)

    update: -> 
      now = new Date()
      timeSincePoop = @lastPoopAt - now
      timeSinceFed = @lastFedAt - now
      timeSincePet = @lastPetAt - now
      @updateHunger(timeSinceFed)
      @updatePoop(timeSincePoop)
      @updateHealth(timeSincePoop)
      @updateHappy(timeSincePet)
      
    updateHunger: (timeSinceFed)->
      @hunger = 100 - (timeSinceFed/msInDay)*100
      
    updatePoop: (timeSincePoop)->
      @poop = false
      if timeSincePoop > msInDay/3
        @poop = true

    updateHealth: (timeSincePoop)->
      @health = 100 - (timeSincePoop/msInDay)*50
    
    updateHappy: (timeSincePet)->
      fedHappieness = @hunger
      petHappieness = (timeSincePet/msInDay)*100
      if @poop
        cleanHappieness = 100
      else
        cleanHappieness = 0
      @happy = 100 - fedHappieness/4 + petHappieness/2 + cleanHappieness/4

  @model = app.db.model('pets', petSchema)

  return this
