import { defineStore } from 'pinia';
import { api } from 'src/boot/axios';

export const useAppStore = defineStore('app', {

  state: () => ({
    isLoading: false,
    user: null,
    token: null,
  }),

  getters: {
    getUser: state => state.user,
    getToken: state => state.token,
    getIsLoading: state => state.isLoading,
  },

  actions: {
    async login(payload) {
      try {
        const { data } = await api.post('/auth/login', payload);
        if (data.token) {
          localStorage.setItem('token', data.token);
          localStorage.setItem('user', JSON.stringify(data.user));
        }
      } catch (error) {
        return error.response;
      }
    }
  },

});
