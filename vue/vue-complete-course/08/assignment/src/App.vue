<template>
  <h1>User Data Assginment</h1>
  <hr />
  <user-data @new-user="addUser"></user-data>
  <active-user
    v-for="userData in userDatas"
    :key="userData.id"
    :name="userData.name"
    :age="userData.age"
  ></active-user>
</template>

<script>
export default {
  data() {
    return {
      userDatas: [],
    };
  },
  methods: {
    addUser(newUser) {
      newUser.id = new Date().toISOString();
      this.userDatas.push(newUser);
    },
  },
};
</script>

<style></style>
