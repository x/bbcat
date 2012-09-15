require('coffee-script')
mongoose = require('mongoose')

Schema = mongoose.Schema

petSchema = new Schema
  name: String
  birthday: Date
  health: Number
  hunger: Number
  happy: Number
  poop: Number
  petting: Number


