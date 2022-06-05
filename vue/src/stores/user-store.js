import { defineStore } from 'pinia';
import { api } from 'src/boot/axios';


export const useUserStore = defineStore('user', {

  state: () => ({
    isLoading: false,
    users: [],
    user: null,
    confirmModalVisibility: false,
    userModalVisibility: false,
  }),

  getters: {
    getUsers: state => state.users,
    getIsLoading: state => state.isLoading,
    getUser: state => state.user,
    getConfirmModalVisibility: state => state.confirmModalVisibility,
    getUserModalVisibility: state => state.userModalVisibility,
  },

  actions: {
    async fetchUsers() {
      try {
        this.isLoading = true;
        const { data } = await api.get('/users');
        this.users = data;
        this.isLoading = false;
      } catch (error) {
        return error.response;
      }
    },
    async fetchUserById(id) {
      try {
        this.isLoading = true;
        const { data } = await api.get(`/users/${id}`);
        this.user = data;
        this.isLoading = false;
      } catch (error) {
        return error.response;
      }
    },
    async createUser(user) {
      try {
        this.isLoading = true;
        await api.post('/users', user);
        this.fetchUsers();
        this.isLoading = false;
      } catch (error) {
        return error.response;
      }
    },
    async updateUser({ id, ...user }) {
      try {
        this.isLoading = true;
        await api.put(`/users/${id}`, user);
        this.fetchUsers();
        this.isLoading = false;
      } catch (error) {
        console.log(error.response);
        return error.response;
      }
    },
    async deleteUser(id) {
      try {
        this.isLoading = true;
        await api.delete(`/users/${id}`);
        this.fetchUsers();
        this.isLoading = false;
      } catch (error) {
        return error.response;
      }
    }
  },

});
