let originTime = 25 * 60
let currentTime = originTime
let isRunning = false
let interval = null
const focusButton = document.getElementById('focus')
const shortButton = document.getElementById('short')
const longButton = document.getElementById('long')
const timer = document.getElementById('timer')
const startButton = document.getElementById('start')

function timeToString(time) {
  function appendZero(t) {
    return t < 10 ? "0" + t : t
  }
  let minute = Math.floor(time / 60) 
  let second = time % 60
  return `${appendZero(minute)}:${appendZero(second)}`
}

function toggle() {
  if (isRunning) {
    clearInterval(interval)
  } else {
    interval = setInterval(run, 1000)
  }
  isRunning = !isRunning
  this.textContent = isRunning ? 'Stop' : 'Start'
}

function change(toTime) {
  clearInterval(interval)
  isRunning = false
  startButton.textContent = "Start"
  originTime = toTime
  currentTime = originTime
  timer.textContent = timeToString(originTime)
}

function toFocus() {
  change(25 * 60)
}

function toShort() {
  change(5 * 60)
}

function toLong() {
  change(15 * 60)
}

function run() {
  if(currentTime > 0){
    currentTime --
  }

  timer.textContent = timeToString(currentTime)
}

focusButton.addEventListener('click', toFocus)
shortButton.addEventListener('click', toShort)
longButton.addEventListener('click', toLong)
startButton.addEventListener('click', toggle)