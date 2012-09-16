$ ->
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
  ]
  cx = 64
  cy = 0
  cwx = 32
  step = 16

  frame = 750

  delay = (ms, cb)-> setTimeout(cb, ms)
  delayInterval = (ms, cb)-> setInterval(cb, ms)

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
  ctx.clear = -> ctx.clearRect(0, 0, 256, 128)
  
  images = {}

  sitCenter = (cb)->
    ctx.clear()
    console.log 'sitting cat'
    ctx.drawImage(images['cat.png'], cx, cy)
    delay frame, cb

  sitCenterFor = (count, cb)->
    ctx.clear()
    console.log 'sitting cat'
    ctx.drawImage(images['cat.png'], cx, cy)
    delay count*frame, cb

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
        delay frame, cb

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
        delay frame, cb

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
            delay frame, cb
  
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
            delay frame, cb
   
  pace = (cb)->
    console.log 'pacing from center to center'
    walkCenterToLeft ->
      walkLeftToCenter ->
        walkCenterToRight ->
          walkRightToCenter cb

  zzz = (cb)->
    console.log 'zzz'
    ctx.clear()
    ctx.drawImage(images['cat-curl.png'], cx, cy)
    ctx.drawImage(images['cat-curl-z1.png'], cx, cy)
    delay frame, ->
      ctx.clear()
      ctx.drawImage(images['cat-curl.png'], cx, cy)
      ctx.drawImage(images['cat-curl-z2.png'], cx, cy)
      delay frame, ->
        ctx.clear()
        ctx.drawImage(images['cat-curl.png'], cx, cy)
        ctx.drawImage(images['cat-curl-z3.png'], cx, cy)
        delay frame, ->
          ctx.clear()
          ctx.drawImage(images['cat-curl.png'], cx, cy)
          delay frame, cb
  
  sleep = (cb)->
    console.log 'sleeping'
    ctx.clear()
    ctx.drawImage(images['cat-curl.png'], cx, cy)
    delay frame*5, ->
      ctx.clear()
      zzz ->
        zzz ->
          zzz cb

  cycle = (cb)->
    ctx.clear()
    sitCenterFor 5, ->
      pace ->
        sitCenterFor 5, ->
          sleep ->

  loadImages sources, images, ->
    console.log 'images loaded'
    cycle ->
      console.log 'done'
