<template>
  <q-page class="q-py-lg q-px-md">
    <span class="text-h4">Nueva actividad</span>
    <section class="q-mt-md">
      <activity-form></activity-form>
    </section>
  </q-page>
</template>

<script>
import { defineAsyncComponent, defineComponent } from "vue";
export default defineComponent({
  name: "NewActivityPage",
  components: {
    activityForm: defineAsyncComponent(() =>
      import("src/components/activity/ActivityForm")
    ),
  },
});
</script>

<style lang="scss" scoped></style>
