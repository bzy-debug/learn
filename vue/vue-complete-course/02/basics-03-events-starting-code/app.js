const app = Vue.createApp({
  data() {
    return {
      counter: 0,
      inputName: '',
    };
  },
  methods: {
    setName(e) {
      this.inputName = e.target.value
    },

    add(num) {
      this.counter += num
    },
    remove(num) {
      this.counter -= num
    }
  }
});

app.mount('#events');
