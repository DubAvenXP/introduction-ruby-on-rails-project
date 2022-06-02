<template>
  <router-view />
</template>

<script>
import { defineComponent } from "vue";
import { useAppStore } from "src/stores/application-store";

export default defineComponent({
  name: "App",
  setup() {
    useAppStore();
  },
});
</script>
