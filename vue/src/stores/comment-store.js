import { defineStore } from 'pinia';
import { api } from 'src/boot/axios';


export const useCommentStore = defineStore('comment', {

  state: () => ({
    isLoading: false,
  }),

  actions: {

    async createComment(activityId, description) {
      try {
        this.isLoading = true;
        await api.post(`/activities/${activityId}/comments`, { description });
        this.isLoading = false;
      } catch (error) {
        return error.response;
      }
    },
  },

});
