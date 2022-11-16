const app = Vue.createApp({
  data() {
    return {
      tasks: [],
      inputTask: "",
      show: true,
      showButtonText: "Hide List",
    };
  },
  methods: {
    addTask() {
      this.tasks.push(this.inputTask);
      this.inputTask = "";
    },
    toggle() {
      this.show = !this.show;
      this.showButtonText = this.show ? "Hide List" : "Show List";
    },
  },
});

app.mount("#assignment");
