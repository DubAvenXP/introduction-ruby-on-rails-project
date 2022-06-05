<template>
  <q-card
    class="activity-card flex column justify-between relative-position"
    flat
    bordered
  >
    <q-img :src="getImage(activity.activity_type)" />

    <q-card-section>
      <div>
        <q-chip icon="event">{{ getStartDate(activity.start_date) }}</q-chip>
        <q-chip
          :icon="activity.access_level === 'public' ? 'public' : 'lock'"
          >{{ activity.access_level }}</q-chip
        >
      </div>
      <div class="text-h5 q-mt-sm q-mb-xs">{{ capitalize(activity.name) }}</div>
      <div class="text-caption text-grey">
        {{ activity.description }}
      </div>
    </q-card-section>

    <q-card-actions align="right" class="flex items-center">
      <q-btn
        v-if="isMyActivitiesView"
        flat
        color="red"
        label="Eliminar"
        @click="deleteActivity"
      />
      <q-btn
        :to="{ name: 'activity', params: { id: activity.id } }"
        flat
        color="dark"
        label="Detalles"
      />
      <q-btn
        v-if="isMyActivitiesView"
        flat
        color="primary"
        label="Editar"
        :to="{ name: 'edit-activity', params: { id: activity.id } }"
        @click="setActivityToStore(activity)"
      />
    </q-card-actions>

    <q-chip
      dense
      :color="activity.enrollment ? 'primary' : 'red'"
      class="absolute-top-right text-bold text-white"
      >{{ getEnrollmentStatus(activity.enrollment) }}</q-chip
    >
  </q-card>
</template>

<script>
import { defineComponent } from "vue";
import useActivity from "src/composables/useActivity";
export default defineComponent({
  name: "EssentialLink",
  props: {
    activity: {
      type: Object,
      required: true,
    },
    isMyActivitiesView: {
      type: Boolean,
      default: false,
    },
  },
  setup(props, { emit }) {
    const {
      getEnrollmentStatus,
      getStartDate,
      getImage,
      capitalize,
      setActivityToStore,
    } = useActivity();
    return {
      getEnrollmentStatus,
      getStartDate,
      getImage,
      capitalize,
      setActivityToStore,
      deleteActivity() {
        emit("delete-activity", props.activity);
      },
    };
  },
});
</script>

<style lang="scss" scoped>
.activity-card {
  width: 100%;
}
a {
  text-decoration: none;
  color: inherit;
}
</style>
