<template>
  <router-view />
</template>

<script>
import { defineComponent } from "vue";
import { useAuthStore } from "src/stores/auth-store";

export default defineComponent({
  name: "App",
  setup() {
    useAuthStore();
  },
});
</script>
