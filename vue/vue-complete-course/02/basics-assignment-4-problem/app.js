const app = Vue.createApp({
  data() {
    return {
      inputClass: '',
      color: '',
      isVisible: true,
    }
  },
  computed: {
    pClass() {
      return {
        user1: this.inputClass === 'user1',
        user2: this.inputClass === 'user2',
        visible: this.isVisible,
        hidden: !this.isVisible,
      }
    }
  },
  methods: {
    toggle() {
      this.isVisible = !this.isVisible
    }
  }
})

app.mount('#assignment')