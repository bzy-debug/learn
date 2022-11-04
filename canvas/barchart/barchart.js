const data = [ 16, 80, 20, 30, 54 ]

let canvas = document.getElementById('canvas')
let ctx = canvas.getContext('2d')

ctx.fillStyle = 'white'
ctx.fillRect(0, 0, 500, 500)

ctx.fillStyle = 'blue'

// plain version
// for (let i = 0; i < data.length; i++) {
//   const dp = data[i]
//   ctx.fillRect(25 + i * 100, 30, 50, dp * 5)
// }

// fix orientation
for (let i = 0; i < data.length; i++) {
  const dp = data[i]
  ctx.fillRect(40 + i * 100, 460 - dp * 5, 50, dp * 5)
}

// draw axis lines

ctx.fillStyle = 'black'
ctx.lineWidth = 2
ctx.beginPath()
ctx.moveTo(30, 10)
ctx.lineTo(30, 460)
ctx.lineTo(490, 460)
ctx.stroke()

//draw texts on vertical lines

ctx.fillStyle = 'black'

for (let i = 0; i < 6; i++) {
  ctx.fillText((5-i) * 20 + '', 4, i*80+60)
  ctx.beginPath()
  ctx.moveTo(25, i*80+60)
  ctx.lineTo(30, i*80+60)
  ctx.stroke()
}

//draw labels
const labels = ['JAN', 'FEB', 'MAR', 'APR', 'MAY']
for (let i = 0; i < labels.length; i++) {
  ctx.fillText(labels[i], 50 + i * 100, 475)
}
