const app = Vue.createApp({
  data() {
    return {
      counter: 0,
      name: '',
      confirmName: '',
      lastName: '',
    };
  },
  watch: {
    counter(value) {
      if(value > 50)
        this.counter = 0
    }
  },
  computed: {
    fullName() {
      if(this.name === '' || this.lastName === '') {
        return ''
      }
      return this.name + ' ' + this.lastName
    },
  },
  methods: {
    confirmed() {
      this.confirmName = this.inputName
      this.inputName = ''
    },

    submit() {
      alert('Submitted!')
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
