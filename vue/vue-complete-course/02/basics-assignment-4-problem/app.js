const app = Vue.createApp({
  data() {
    return {
      inputClass: '',
      color: '',
      isVisible: true,
    }
  },
  computed: {
    visibleClass() {
      return this.isVisible ? 'visible' : 'hidden'
    }
  },
  methods: {
    toggle() {
      this.isVisible = !this.isVisible
    }
  }
})

app.mount('#assignment')