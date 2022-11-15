const app = Vue.createApp({
  data() {
    return {
      counter: 0,
      inputName: '',
      confirmName: '',
    };
  },
  computed: {
    fullName() {
      console.log('again')
      if(this.confirmName === '') {
        return ''
      }
      return 'happy ' + this.confirmName
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
