const app = Vue.createApp({
  data() {
    return { 
      goals: [],
      inputGoal: '',
    };
  },
  methods: {
    addGoal() {
      this.goals.push(this.inputGoal)
      this.inputGoal = ''
    },
    removeGoal(idx) {
      this.goals.splice(idx, 1)
    }
  }
});

app.mount('#user-goals');
