import { defineStore } from 'pinia';
import { api } from 'src/boot/axios';


export const useActivityStore = defineStore('activity', {

  state: () => ({
    isLoading: false,
    activities: [],
    activity: null,
    createdActivity: null,
    isEditable: false,
    types: [
      { name: 'lunch', image: 'https://images.pexels.com/photos/821054/pexels-photo-821054.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1' },
      { name: 'trip', image: 'https://images.pexels.com/photos/8894329/pexels-photo-8894329.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1' },
      { name: 'party', image: 'https://images.pexels.com/photos/2034851/pexels-photo-2034851.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1' },
      { name: 'recreational_outlet', image: 'https://images.pexels.com/photos/9582593/pexels-photo-9582593.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1' },
    ],
  }),

  getters: {
    getActivities: state => state.activities,
    getActivity: state => state.activity,
    getActivityImageByType: state => type => state.types.find(item => item.name === type).image,
  },

  actions: {
    async fetchActivities(user_id) {
      try {
        this.isLoading = true;
        const { data } = await api.get('/activities', {
          params: {
            user_id,
          }
        });
        this.activities = data;
        this.isLoading = false;
      } catch (error) {
        return error.response;
      }
    },
    async fetchActivityById(id) {
      try {
        this.isLoading = true;
        const { data } = await api.get(`/activities/${id}`);
        this.activity = data;
        this.isLoading = false;
        return this.activity;
      } catch (error) {
        return error.response;
      }
    },
    async createActivity(activity) {
      try {
        this.isLoading = true;
        const { data } = await api.post('/activities', activity);
        this.createdActivity = data;
        this.fetchActivities();
        this.isLoading = false;
      } catch (error) {
        return error.response;
      }
    },
    async updateActivity(activity) {
      try {
        this.isLoading = true;
        const { data } = await api.put(`/activities/${this.activity.id}`, activity);
        this.createdActivity = data;
        this.isLoading = false;
      } catch (error) {
        return error.response;
      }
    },
    async deleteActivity(id) {
      try {
        this.isLoading = true;
        await api.delete(`/activities/${id}`);
        this.fetchActivities();
        this.isLoading = false;
      } catch (error) {
        return error.response;
      }
    }
  },

});
