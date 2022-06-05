<template>
  <q-page class="q-py-lg q-px-md">
    <div class="flex justify-between items-center">
      <span class="text-h3">Actividades</span>
      <q-btn color="primary" icon="add_circle" label="Nueva actividad" />
    </div>

    <h3 v-if="isLoading">Cargando...</h3>
    <section v-else class="q-mt-md activities">
      <activity-card
        v-for="activity in activities"
        :key="activity.id"
        :activity="activity"
      ></activity-card>
    </section>
  </q-page>
</template>

<script>
import { useActivityStore } from "src/stores/activity-store";
import { computed, defineAsyncComponent, defineComponent } from "vue";

export default defineComponent({
  name: "ActivitiesPage",
  components: {
    activityCard: defineAsyncComponent(() =>
      import("src/components/activity/ActivityCard.vue")
    ),
  },
  setup() {
    const store = useActivityStore();
    store.fetchActivities();

    return {
      isLoading: computed(() => store.isLoading),
      activities: computed(() => store.activities),
    };
  },
});
</script>
<style lang="scss" scoped>
.activities {
  height: auto;
  width: 100%;
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  grid-auto-rows: auto;
  gap: 24px;
}
</style>
