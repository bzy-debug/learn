const app = Vue.createApp({
  data() {
    return {
      tasks: [],
      inputTask: "",
      show: true,
    };
  },
  computed: {
    showButtonText() {
      return this.show ? "Hide List" : "Show List";
    },
  },
  methods: {
    addTask() {
      this.tasks.push(this.inputTask);
      this.inputTask = "";
    },
    toggle() {
      this.show = !this.show;
    },
  },
});

app.mount("#assignment");
