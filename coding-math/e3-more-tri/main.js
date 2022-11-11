window.onload = function() {
  const canvas = document.querySelector("canvas"),
    context = canvas.getContext('2d'),
    width = canvas.width = window.innerWidth,
    height = canvas.height = window.innerHeight

  const centerY = height * .5,
        centerX = width * .5,
        radius = 100,
        speed = 0.01
  let angel = 0

  render()
  
  function render() {
    let pointX = centerX + radius * Math.cos(angel)
    let pointY = centerY + radius * Math.sin(angel)
    context.clearRect(0, 0, width, height)

    context.beginPath()
    context.arc(centerX, centerY, radius, 0, Math.PI * 2, false)
    context.stroke()

    context.beginPath()
    context.arc(pointX, pointY, 10, 0, Math.PI * 2, false)
    context.fill()

    angel += speed

    requestAnimationFrame(render)
  }
}