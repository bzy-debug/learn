window.onload = function() {
  const canvas = document.querySelector("canvas"),
    context = canvas.getContext('2d'),
    width = canvas.width = window.innerWidth,
    height = canvas.height = window.innerHeight

  context.translate(0, height / 2)
  context.scale(1, -1)
  
  for (let angel = 0; angel < Math.PI * 2; angel += .01) {
    const x = angel * 200,
      y = Math.sin(angel) * 200

    context.fillRect(x, y, 5, 5)
  }
}