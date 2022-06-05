import { useActivityStore } from "src/stores/activity-store";
import { computed, ref, watch } from "vue";
import { useRoute, useRouter } from "vue-router";
import useNotify from "./useNotify";

const useActivity = () => {
  const store = useActivityStore();
  const router = useRouter();
  const route = useRoute();
  const { notifyError, notifySuccess } = useNotify();
  const activityForm = ref(null);
  const confirmModalVisibility = ref(false);
  const newActivity = ref({
    name: '',
    description: '',
    activity_type: '',
    location: '',
    budget: 0,
    start_date: '',
    end_date: '',
    access_level: '',
  });

  const clearForm = () => {
    newActivity.value = {
      name: '',
      description: '',
      activity_type: '',
      location: '',
      budget: 0,
      start_date: '',
      end_date: '',
      access_level: '',
    };
  };

  return {
    newActivity,
    activityForm,
    confirmModalVisibility,
    activities: computed(() => store.activities),
    isLoading: computed(() => store.isLoading),
    activity: computed(() => store.activity),
    currentActivity: computed(() => store.createdActivity),
    getImage: type => store.getActivityImageByType(type),
    activityTypes: ['lunch', 'trip', 'party', 'recreational_outlet',],
    accessLevels: ['public', 'private'],
    setActivityToStore: (activity) => {
      store.activity = activity;
    },
    displayConfirmModal: (activity) => {
      confirmModalVisibility.value = true;
      store.createdActivity = activity;
    },
    isEditable: computed(() => {
      if (route.name === 'edit-activity') return true;
      clearForm();
      return false;
    }),
    getStartDate: (start_date) => {
      const date = new Date(start_date);
      return `${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear()}`;
    },
    getEnrollmentStatus: (enrollment) => {
      if (enrollment) {
        return "Inscripciones abiertas";
      } else if (!enrollment) {
        return "Inscripciones cerradas";
      } else {
        return "Sin información";
      }
    },
    capitalize: (str) => {
      return str.charAt(0).toUpperCase() + str.slice(1);
    },
    getValue: (value, currency = 'Q.') => {
      // transform to decimal
      const decimal = parseFloat(value);
      return `${currency} ${decimal.toFixed(2)} `;
    },
    getRoleAssignment: (roleAssignment) => {
      if (roleAssignment === "owner") return "Organizador";
      if (roleAssignment !== "owner") return "Miembro";
    },
    fetchActivities: async (user_id) => {
      await store.fetchActivities(user_id);
    },
    onCreate: async () => {
      if (activityForm.value) {
        const valid = await activityForm.value.validate();
        if (valid) {
          const error = await store.createActivity(newActivity.value);
          if (error) {
            notifyError('Error al crear actividad');
            return;
          }
          router.push({ name: 'activity', params: { id: store.createdActivity.id } });
          notifySuccess('Actividad creada correctamente');
        }
      }
    },
    onUpdate: async () => {
      if (activityForm.value) {
        const valid = await activityForm.value.validate();
        if (valid) {
          const error = await store.updateActivity(newActivity.value);
          if (error) {
            notifyError(error.data.error || 'Error al actualizar actividad');
            return;
          }
          router.push({ name: 'activity', params: { id: store.createdActivity.id } });
          notifySuccess('Actividad actualizada correctamente');
        }
      }
    },
    onDelete: async () => {
      const error = await store.deleteActivity(store.createdActivity.id);
      if (error) {
        notifyError(error.data.error || 'Error al eliminar actividad');
        return;
      }
      confirmModalVisibility.value = false;
      notifySuccess('Actividad eliminada correctamente');
    },
    onReset: () => {
      if (activityForm.value) {
        clearForm();
        activityForm.value.resetValidation();
      }
    },

  };
};


export default useActivity;
