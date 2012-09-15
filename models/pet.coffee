module.exports = (mongoose)->
  
  petSchema = new mongoose.Schema
    name: String
    birthday: Date
    health: Number
    hunger: Number
    happy: Number
    poop: Number
    petting: Number

  this.model = mongoose.model('pets', petSchema)

  return this
