sources = []
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
