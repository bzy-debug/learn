const inputEl = document.getElementById('goal')

function addGoal() {
  const goalText = goal.value
  const newItem = document.createElement('li')
  newItem.textContent = goalText

  document.getElementById('list').appendChild(newItem)
  goal.value = ''
}

document.getElementById('button').addEventListener('click', addGoal)