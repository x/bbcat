module.exports = (mongoose)->
  
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
      Math.floor((now - this.birthday)/msInDay)

    update: -> 
      now = new Date()
      timeSincePoop = this.lastPoopAt - now
      timeSinceFed = this.lastFedAt - now
      timeSincePet = this.lastPetAt - now
      updateHunger(timeSinceFed)
      updatePoop(timeSincePoop)
      updateHealth(timeSincePoop)
      updateHappy(timeSincePet)
      
    updateHunger: (timeSinceFed)->
      this.hunger = 100 - (timeSinceFed/msInDay)*100
      
    updatePoop: (timeSincePoop)->
      this.poop = false
      if timeSincePoop > msInDay/3
        this.poop = true

    updateHealth: (timeSincePoop)->
      this.health = 100 - (timeSincePoop/msInDay)*50
    
    updateHappy: (timeSincePet)->
      fedHappieness = this.hunger
      petHappieness = (timeSincePet/msInDay)*100
      if this.poop
        cleanHappieness = 100
      else
        cleanHappieness = 0
      this.happy = 100 - fedHappienss/4 + petHappieness/2 + cleanHappieness/4

  this.model = mongoose.model('pets', petSchema)

  return this
