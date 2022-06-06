import { computed, ref } from "vue";
import { useRoute, useRouter } from "vue-router";

import { useActivityStore } from "src/stores/activity-store";
import { useAssignmentStore } from "src/stores/assignment-store";
import { useAuthStore } from "src/stores/auth-store";
import { useCommentStore } from "src/stores/comment-store";

import useNotify from "./useNotify";

const useActivity = () => {
  const store = useActivityStore();
  const assignmentStore = useAssignmentStore();
  const commentStore = useCommentStore();
  const authStore = useAuthStore();
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
    enrollment: '',
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
      enrollment: '',
    };
  };

  return {
    accessLevels: ['public', 'private'],
    activities: computed(() => store.activities),
    activity: computed(() => store.activity),
    activityForm,
    activityTypes: ['lunch', 'trip', 'party', 'recreational_outlet',],
    activityEnrollments: ['abiertas', 'cerradas'],
    confirmModalVisibility,
    currentActivity: computed(() => store.createdActivity),
    getImage: type => store.getActivityImageByType(type),
    isLoading: computed(() => store.isLoading),
    newActivity,
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
          newActivity.value.enrollment === 'abiertas' ?
            newActivity.value.enrollment = true :
            newActivity.value.enrollment = false;
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
    onCreateAssignment: async () => {
      const error = await assignmentStore.createAssignment(store.activity.id, authStore.user.id);
      if (error) {
        notifyError(error.data.error || 'Error al crear asignación');
        return;
      }
      store.fetchActivityById(store.activity.id);
      notifySuccess('Asignación creada correctamente');
    },
    onCreateComment: async (description) => {
      console.log(description);
      if (description === '') {
        notifyError('Comentario vacío');
        return;
      }

      const error = await commentStore.createComment(store.activity.id, description);

      if (error) {
        notifyError(error.data.error || 'Error al crear el comentario');
        return;
      }
      store.fetchActivityById(store.activity.id);
      notifySuccess('Comentario publicado correctamente');
    },
    onUpdate: async () => {
      if (activityForm.value) {
        const valid = await activityForm.value.validate();
        if (valid) {
          newActivity.value.enrollment === 'abiertas' ?
            newActivity.value.enrollment = true :
            newActivity.value.enrollment = false;
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
    onDeleteAssignment: async (assignmentId) => {
      const error = await assignmentStore.deleteAssignment(store.activity.id, assignmentId);
      if (error) {
        notifyError(error.data.error || 'Error al eliminar la asignación');
        return;
      }
      store.fetchActivityById(store.activity.id);
      notifySuccess('Asignación eliminada correctamente');
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
