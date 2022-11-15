const app = Vue.createApp({
  data() {
    return {
      counter: 0,
    }
  },
  watch: {
    result() {
      const that = this
      setTimeout(() => {
        that.counter = 0
      }, 5000);
    }
  },
  computed: {
    result() {
      if (this.counter === 37) {
        return 'Exactly'
      }
      return this.counter < 37 ? 'Not there yet' : 'Too much!'
    }
  },
  methods: {
    add(num) {
      this.counter += num
    }
  },
})

app.mount('#assignment')