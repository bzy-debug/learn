<template>
  <form>
    <div>Name <input type="text" v-model="name" /></div>
    <div>Phone <input type="text" v-model="phone" /></div>
    <div>Email <input type="text" v-model="email" /></div>
    <div>Favorite <input type="checkbox" v-model="isFavorite" /></div>
    <button @click.prevent="createFriend">Submit</button>
  </form>
</template>

<script>
export default {
  emits: {
    "create-friend": function (friend) {
      if (friend) return true;
      else return false;
    },
  },
  data() {
    return {
      name: "",
      phone: "",
      email: "",
      isFavorite: false,
    };
  },
  methods: {
    createFriend() {
      const newFriend = {
        id: this.name,
        name: this.name,
        phone: this.phone,
        email: this.email,
        isFavorite: this.isFavorite,
      };
      this.name = this.phone = this.email = "";
      this.isFavorite = false;
      this.$emit("create-friend", newFriend);
    },
  },
};
</script>
