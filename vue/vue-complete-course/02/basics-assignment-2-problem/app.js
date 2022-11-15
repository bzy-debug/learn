const app = Vue.createApp({
  data() {
    return {
      input: '',
      enter: '',
    }
  },
  methods: {
    showAlert() {
      alert('Alert!')
    },
    getInput(e) {
      this.input = e.target.value
    },
    confirmInput() {
      this.enter = this.input
    }
  }
})

app.mount('#assignment')