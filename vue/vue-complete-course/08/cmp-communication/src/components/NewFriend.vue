<template>
  <form @submit.prevent="createFriend">
    <div>
      <label>Name </label>
      <input type="text" v-model="name" />
    </div>
    <div>
      <label>Phone</label>
      <input type="tel" v-model="phone" />
    </div>
    <div>
      <label>Email </label>
      <input type="email" v-model="email" />
    </div>
    <div>
      <label>Favorite </label>
      <input type="checkbox" v-model="isFavorite" />
    </div>
    <button>Add Contact</button>
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
