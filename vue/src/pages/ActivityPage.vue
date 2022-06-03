<template>
  <q-page>
    <h3 v-if="isLoading">Cargando...</h3>
    <section v-else class="activity">
      <activity-banner :title="activity.name"></activity-banner>
      <div class="content q-pa-lg">
        <activity-details :activity="activity"></activity-details>
        <activity-members :members="activity.users"></activity-members>
        <activity-comments :comments="activity.comments"></activity-comments>
      </div>
    </section>
  </q-page>
</template>

<script>
import useActivity from "src/composables/useActivity";
import { useActivityStore } from "src/stores/activity-store";
import { defineComponent, computed, defineAsyncComponent } from "vue";
import { useRoute } from "vue-router";

export default defineComponent({
  name: "ActivityPage",
  components: {
    activityBanner: defineAsyncComponent(() =>
      import("src/components/activity/ActivityBanner.vue")
    ),
    activityDetails: defineAsyncComponent(() =>
      import("src/components/activity/ActivityDetails.vue")
    ),
    activityMembers: defineAsyncComponent(() =>
      import("src/components/activity/ActivityMembers.vue")
    ),
    activityComments: defineAsyncComponent(() =>
      import("src/components/activity/ActivityComments.vue")
    ),
  },
  setup() {
    const route = useRoute();
    const store = useActivityStore();
    const { getImage } = useActivity();
    store.fetchActivityById(route.params.id);

    return {
      activity: computed(() => store.activity),
      isLoading: computed(() => store.isLoading),
      getImage,
    };
  },
});
</script>

<style lang="scss" scoped>
.content {
  width: 100%;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
  grid-auto-rows: auto;
  gap: 2rem;
}
</style>
