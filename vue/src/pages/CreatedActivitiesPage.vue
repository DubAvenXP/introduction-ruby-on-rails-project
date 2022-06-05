<template>
  <q-page class="q-py-lg q-px-md">
    <div class="flex justify-between items-center">
      <span class="text-h4">Actividades creadas</span>
      <q-btn
        :to="{ name: 'create-activity' }"
        color="primary"
        icon="add_circle"
        label="Nueva actividad"
      />
    </div>

    <h3 v-if="isLoading">Cargando...</h3>
    <section v-else class="q-mt-md activities">
      <activity-card
        v-for="activity in activities"
        :key="activity.id"
        :activity="activity"
        :isMyActivitiesView="true"
        @delete-activity="displayConfirmModal"
      ></activity-card>
    </section>
    <h5 class="text-center text-dark" v-if="activities.length === 0">
      No tienes actividades creadas
    </h5>

    <q-dialog v-model="confirmModalVisibility">
      <q-card>
        <q-card-section class="row items-center">
          <q-avatar icon="delete" color="primary" text-color="white" />
          <span class="q-ml-sm">
            ¿ Estas seguro que quieres eliminar la actividad "{{
              currentActivity?.name
            }}" ?
          </span>
        </q-card-section>
        <q-card-actions align="right">
          <q-btn flat label="Cancelar" color="primary" v-close-popup />
          <q-btn flat label="Eliminar" color="red" @click="onDelete" />
        </q-card-actions>
      </q-card>
    </q-dialog>
  </q-page>
</template>

<script>
import useActivity from "src/composables/useActivity";
import { useAuthStore } from "src/stores/auth-store";
import { defineAsyncComponent, defineComponent } from "vue";

export default defineComponent({
  name: "EnrolledActivitiesPage",
  components: {
    activityCard: defineAsyncComponent(() =>
      import("src/components/activity/ActivityCard.vue")
    ),
  },
  setup() {
    const store = useAuthStore();
    const {
      fetchActivities,
      displayConfirmModal,
      onDelete,
      currentActivity,
      isLoading,
      activities,
      confirmModalVisibility,
    } = useActivity();
    fetchActivities(store.user.id);
    return {
      displayConfirmModal,
      onDelete,
      currentActivity,
      isLoading,
      activities,
      confirmModalVisibility,
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
