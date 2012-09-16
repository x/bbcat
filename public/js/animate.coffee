sources = ['../img/cat-curl-z1.png', '../img/cat-curl-z2.png', '../img/cat-curl-z3.png', '../img/cat-curl.png', '../img/cat-dead.png', '../img/cat-happy.png', '../img/cat-mad.png', '../img/cat-sad.png', '../img/cat-sick.png', '../img/cat-walk1.png', '../img/cat-walk2.png', '../img/cat.png', ]
cx = 64
cy = 128

loadImages = (sources, images, cb)->
  loadedImages = 0
  numImages = 0
  for src in sources
    numImages++
  for src in sources
    images[src] = new Image()
    images[src].onload = ->
      if ++loadImages >= numImages
        cb(images)
    images[src].src = sources[src]

$canvase = $('#pet')
ctx = $canvas.ctx

ctx.drawImage(cx, cy)
