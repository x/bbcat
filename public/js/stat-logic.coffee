$ ->
  # graphical stat updates
  window.bb.emotion = ->
    health = window.bb.pet.health
    happy = window.bb.pet.happy
    if health < 20
      return 'sick'
    else
      if happy < 40
        return 'sad'
      else
        return 'happy'
  
  window.bb.fishUpdate = ->
    hunger = window.bb.pet.hunger
    fishCount = Math.round(hunger/20)
    console.log "pet has #{fishCount} fish now"
    $('.fish').each (i, elem)->
      if i < fishCount
        $(elem).addClass('active')

  window.bb.heartUpdate = ->
    health = window.bb.pet.health
    heartCount = Math.round(health/20)
    console.log "pet has #{heartCount} fish now"
    $('.heart').each (i, elem)->
      if i < heartCount
        $(elem).addClass('active')


  # post stat updates
  window.bb.feed = ->
    $.post '/feed', pet: window.bb.pet, (data, status)->
      window.bb.pet = data
      console.log 'pet was fed', data, status
      window.bb.fishUpdate()

  window.bb.heal = ->
    unless window.bb.pet.poop
      $.post '/heal', pet: window.bb.pet, (data, status)->
        window.bb.pet = data
        console.log 'pet was healed', data, status
        window.bb.heartUpdate()

  window.bb.clean = ->
    window.bb.pet.poop = false
    $.post '/clean', pet: window.bb.pet, (data, status)->
      console.log 'pet was cleaned', data, status

  window.bb.play = ->
    $.post '/play', pet: window.bb.pet, (data, status)->
      window.bb.pet = data
      console.log 'pet was played with', data, status


  # init buttons
  $('#feed').click(window.bb.feed)
  $('#heal').click(window.bb.heal)
  $('#clean').click(window.bb.clean)

  # init current stats
  window.bb.fishUpdate()
  window.bb.heartUpdate()
