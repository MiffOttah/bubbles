W = 400
H = 400

ColorHue = 218

TAU = 2 * Math.PI

$ ->
    $('#drawarea').click redraw
    redraw()

redraw = ->
    bubbles = []

    context = document.getElementById('drawarea').getContext '2d'
    context.clearRect 0, 0, W, H

    bubbleAt = (x, y, generation) ->
        r = rnd(10, 30)
        bubbles.push { x, y, r }

        if generation < 6
            children = rnd(1, 4)
            while children > 0
                children--

                distanceAngle = Math.random() * TAU
                distanceX = x + (Math.cos(distanceAngle) * r * 1.2)
                distanceY = y + (Math.sin(distanceAngle) * r * 1.2)

                bubbleAt distanceX, distanceY, generation + 1

    kaitemaru = (sat, lum, x, y, r) ->
        context.beginPath()
        context.arc x, y, r, 0, TAU, false
        context.fillStyle = "hsl(#{ColorHue}, #{sat}%, #{lum}%)"
        context.fill()

    bubbleAt W / 2, H / 2, 1

    for bubble in bubbles
        kaitemaru 100, 80, bubble.x, bubble.y, bubble.r
    for bubble in bubbles
        kaitemaru 50, 50, bubble.x, bubble.y, bubble.r / 2
    

rnd = (min, max) ->
    dmax = max - min
    return min + Math.floor(Math.random() * dmax)