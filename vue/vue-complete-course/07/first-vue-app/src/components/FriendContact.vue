<template>
  <li>
    <h2>{{ friend.name }}</h2>
    <button @click="toggleDetail">{{ toggleText }}</button>
    <ul v-show="detailVisible">
      <li><strong>Phone:</strong> {{ friend.phone }}</li>
      <li><strong>Email:</strong> {{ friend.email }}</li>
    </ul>
  </li>
</template>

<script>
export default {
  data() {
    return {
      detailVisible: false,
      friend: {
        id: 1,
        name: "wqq",
        phone: "1234567890",
        email: "wqq@localhost.com",
      },
    };
  },
  computed: {
    toggleText() {
      return (this.detailVisible ? "Hide" : "Show") + " Details";
    },
  },
  methods: {
    toggleDetail() {
      this.detailVisible = !this.detailVisible;
    },
  },
};
</script>
