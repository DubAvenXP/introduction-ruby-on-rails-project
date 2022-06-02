import { defineStore } from 'pinia';
import { api } from 'src/boot/axios';

export const useAppStore = defineStore('app', {

  state: () => ({
    isLoading: false,
    user: JSON.parse(localStorage.getItem('user')) || null,
    token: localStorage.getItem('token') || null,
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
    },
    logout() {
      localStorage.removeItem('token');
      localStorage.removeItem('user');
      this.user = null;
      this.token = null;
    }
  },

});
