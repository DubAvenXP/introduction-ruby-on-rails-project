<template>
  <q-page class="q-py-lg q-px-md">
    <span class="text-h4">{{ isEditable ? "Editar" : "Nueva" }} actividad</span>
    <section class="q-mt-md">
      <activity-form></activity-form>
    </section>
  </q-page>
</template>

<script>
import useActivity from "src/composables/useActivity";
import { defineAsyncComponent, defineComponent } from "vue";
export default defineComponent({
  name: "NewActivityPage",
  components: {
    activityForm: defineAsyncComponent(() =>
      import("src/components/activity/ActivityForm")
    ),
  },
  setup() {
    const { isEditable } = useActivity();
    return { isEditable };
  },
});
</script>

<style lang="scss" scoped></style>
