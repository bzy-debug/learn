const app = Vue.createApp({
  data() {
    return {
      selected: {
        'A': false,
        'B': false,
        'C': false,
      }
    }
  },
  computed: {
    classes() {
      return {
        'A': {active: this.selected['A']},
        'B': {active: this.selected['B']},
        'C': {active: this.selected['C']},
      }
    }
  },
  methods: {
    toggle(id) {
      this.selected[id] = !this.selected[id]
    }
  },
})

app.mount('#styling')