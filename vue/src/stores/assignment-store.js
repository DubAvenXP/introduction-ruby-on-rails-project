import { defineStore } from 'pinia';
import { api } from 'src/boot/axios';


export const useAssignmentStore = defineStore('assignment', {

  state: () => ({
    isLoading: false,
  }),
  getters: {},

  actions: {
    async createAssignment(activityId, userId) {
      try {
        const assignment = {
          role_assignment: 'member',
          user_id: userId,
        };
        this.isLoading = true;
        await api.post(`/activities/${activityId}/assignments`, assignment);
        this.isLoading = false;
      } catch (error) {
        return error.response;
      }
    },
    async deleteAssignment(activityId, assignmentId) {
      try {
        this.isLoading = true;
        await api.delete(`/activities/${activityId}/assignments/${assignmentId}`);
        this.isLoading = false;
      } catch (error) {
        return error.response;
      }
    },
  },

});
