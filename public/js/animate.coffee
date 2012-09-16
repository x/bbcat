$ ->
  if window.DeviceMotionEvent
    console.log 'this browser supports devicemotion'
    window.addEventListener 'devicemotion', (event)->
      y = event.acceleration.y
      z = event.acceleration.z
      x = event.acceleration.x
      console.log x, y, z
      power = Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2) + Math.pow(z, 2))
      if power > 50
        console.log 'the power was', power
        window.bb.isAngry = true
  else
    console.log 'this browser does not support devicemotion'
  
  domain = "#{document.location.origin}/public/img/"
  sources = [
    'cat.png'
    'cat-curl-z1.png'
    'cat-curl-z2.png'
    'cat-curl-z3.png'
    'cat-curl.png'
    'cat-dead.png'
    'cat-happy.png'
    'cat-mad.png'
    'cat-sad.png'
    'cat-sick.png'
    'cat-walk1.png'
    'cat-walk2.png'
    'cat-walk1-right.png'
    'cat-walk2-right.png'
    'poop.png'
    'poop1.png'
    'poop2.png'
    'poop3.png'
  ]
  cx = 64
  cy = 8
  cwx = 32
  step = 16

  px = 188
  py = 56

  frame = 750

  delay = (ms, cb)-> setTimeout(cb, ms)
  delayInterval = (ms, cb)-> setInterval(cb, ms)

  images = {}
  loadImages = (sources, images, cb)->
    loadedImages = 0
    numImages = 0
    for src in sources
      numImages++
    for src in sources
      images[src] = new Image()
      images[src].onload = ->
        if ++loadedImages >= numImages
          cb(images)
      images[src].src = domain + src
  
  canvas = document.getElementById('pet')
  canvas.width = 256
  canvas.height = 128
  
  ctx = canvas.getContext('2d')
  
  ctx.clear = -> 
    ctx.clearRect(0, 0, 256, 128)
    if window.bb.pet.poop
      ctx.drawImage(images['poop.png'], px, py)
  
  sitCenterFor = (count, cb)->
    ctx.clear()
    console.log 'sitting cat'
    if window.bb.emotion() == 'sick'
      ctx.drawImage(images['cat-sick.png'], cx, cy)
    else if window.bb.emotion() == 'sad'
      ctx.drawImage(images['cat-sad.png'], cx, cy)
    else
      ctx.drawImage(images['cat.png'], cx, cy)
    delay count*frame, cb
  
  sitCenter = (cb)->
    ctx.clear()
    console.log 'sitting cat'
    ctx.drawImage(images['cat.png'], cx, cy)
    delay frame, cb

  sitCenterIfNeeded = (cb)->
    sitIfNeeded(cx, cb)

  sitLeftIfNeeded = (cb)->
    sitIfNeeded(-16, cb)

  sitRightIfNeeded = (cb)->
    sitIfNeeded(128, cb)

  sitIfNeeded = (x, cb)->
    if window.bb.petme
      window.bb.petme = false
      console.log 'pet the cat'
      ctx.clear()
      ctx.drawImage(images['cat-happy.png'], x, cy)
      delay frame, cb
    else
      cb()

  walkCenterToLeft = (cb)->
    console.log 'walking center to left'
    ctx.clear()
    ctx.drawImage(images['cat-walk1.png'], cwx, cy)
    delay frame, ->
      ctx.clear()
      ctx.drawImage(images['cat-walk2.png'], cwx-step, cy)
      delay frame, ->
        ctx.clear()
        ctx.drawImage(images['cat-walk1.png'], cwx-2*step, cy)
        delay frame, ->
          sitLeftIfNeeded cb

  walkLeftToCenter = (cb)->
    console.log 'walking left to center'
    ctx.clear()
    ctx.drawImage(images['cat-walk2-right.png'], -3*step, cy)
    delay frame, ->
      ctx.clear()
      ctx.drawImage(images['cat-walk1-right.png'], -2*step, cy)
      delay frame, ->
        ctx.clear()
        ctx.drawImage(images['cat-walk2-right.png'], -1*step, cy)
        delay frame, ->
          sitCenterIfNeeded cb

  walkCenterToRight = (cb)->
    console.log 'walking center to left'
    ctx.clear()
    ctx.drawImage(images['cat-walk1-right.png'], 0, cy)
    delay frame, ->
      ctx.clear()
      ctx.drawImage(images['cat-walk2-right.png'], step, cy)
      delay frame, ->
        ctx.clear()
        ctx.drawImage(images['cat-walk1-right.png'], step*2, cy)
        delay frame, ->
          ctx.clear()
          ctx.drawImage(images['cat-walk2-right.png'], step*3, cy)
          delay frame, ->
            ctx.clear()
            ctx.drawImage(images['cat-walk1-right.png'], step*4, cy)
            delay frame, ->
              sitRightIfNeeded cb
  
  walkRightToCenter = (cb)->
    console.log 'walking right to center'
    ctx.clear()
    ctx.drawImage(images['cat-walk2.png'], 7*step, cy)
    delay frame, ->
      ctx.clear()
      ctx.drawImage(images['cat-walk1.png'], 6*step, cy)
      delay frame, ->
        ctx.clear()
        ctx.drawImage(images['cat-walk2.png'], 5*step, cy)
        delay frame, ->
          ctx.clear()
          ctx.drawImage(images['cat-walk1.png'], 4*step, cy)
          delay frame, ->
            ctx.clear()
            ctx.drawImage(images['cat-walk2.png'], 3*step, cy)
            delay frame, ->
              sitCenterIfNeeded cb
   
  pace = (cb)->
    console.log 'pacing from center to center'
    walkCenterToLeft ->
      walkLeftToCenter ->
        walkCenterToRight ->
          walkRightToCenter cb

  paceOnLeft = (cb)->
    console.log 'pacing from center to left to center'
    walkCenterToLeft ->
      walkLeftToCenter ->
        walkCenterToLeft ->
          walkLeftToCenter cb

  zzz = (cb)->
    console.log 'zzz'
    ctx.clear()
    ctx.drawImage(images['cat-curl.png'], cx, cy)
    ctx.drawImage(images['cat-curl-z1.png'], cx, cy)
    delay frame, ->
      sitCenterIfNeeded ->
        ctx.clear()
        ctx.drawImage(images['cat-curl.png'], cx, cy)
        ctx.drawImage(images['cat-curl-z2.png'], cx, cy)
        delay frame, ->
          sitCenterIfNeeded ->
            ctx.clear()
            ctx.drawImage(images['cat-curl.png'], cx, cy)
            ctx.drawImage(images['cat-curl-z3.png'], cx, cy)
            delay frame, ->
              sitCenterIfNeeded ->
                ctx.clear()
                ctx.drawImage(images['cat-curl.png'], cx, cy)
                delay frame, ->
                  sitCenterIfNeeded cb
  
  sleep = (cb)->
    console.log 'sleeping'
    ctx.clear()
    ctx.drawImage(images['cat-curl.png'], cx, cy)
    delay frame*5, ->
      sitCenterIfNeeded ->
        ctx.clear()
        zzz ->
          zzz ->
            zzz cb

  chooseCycle = ->
    if window.bb.pet.poop
      poopCycle()
    else
      cycle()

  cycle = ->
    ctx.clear()
    sitCenterFor 5, ->
      pace ->
        sitCenterFor 5, ->
          sleep chooseCycle

  poopCycle = ->
    ctx.clear()
    sitCenterFor 5, ->
      paceOnLeft ->
        sitCenterFor 5, ->
          sleep chooseCycle

  loadImages sources, images, ->
    console.log 'images loaded'
    chooseCycle()
    console.log 'done'
