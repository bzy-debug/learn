<template>
  <form @submit.prevent="addUser">
    <div>
      <label>Name: </label>
      <input type="text" v-model="name" placeholder="User Name" />
    </div>
    <div>
      <label>Age: </label>
      <input type="number" v-model="age" />
    </div>
    <button>Add User</button>
  </form>
</template>

<script>
export default {
  emits: ["new-user"],
  data() {
    return {
      name: "",
      age: 0,
    };
  },
  methods: {
    addUser() {
      this.$emit("new-user", { name: this.name, age: this.age });
    },
  },
};
</script>
