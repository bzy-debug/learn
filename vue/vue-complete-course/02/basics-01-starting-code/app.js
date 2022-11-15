const app = Vue.createApp({
  data() {
    return {
      goal: "Graduate",
      anotherGoal: 'goal',
      vueLink: 'https://vuejs.org'
    }
  },
  methods: {
    getGoal() {
      const randomNum = Math.random()
      if (randomNum < 0.5)
        return this.goal
      else
        return this.anotherGoal
    }
  }
})

app.mount("#user-goal")