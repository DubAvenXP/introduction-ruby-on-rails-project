import { useUserStore } from "src/stores/user-store";
import { computed } from "vue";

const useUser = () => {
  const store = useUserStore();
  return {
    fetchUsers: async () => {
      await store.fetchUsers();
    },
    users: computed(() => store.users),
    user: computed(() => store.user),
    isLoading: computed(() => store.isLoading),
    columns: [
      {
        name: "name",
        field: "name",
        label: "Nombre",
        align: "center",
      },
      {
        name: "email",
        field: "email",
        label: "Email",
        align: "center",
      },
      {
        name: "role",
        field: "role",
        label: "Rol",
        align: "center",
      },
      {
        name: "actions",
        label: "Acciones",
        align: "center",
      },
    ],
    deleteUser: (user) => {
      console.log(user);
    },
    editUser: (user) => {
      console.log(user);
    }

  };
};


export default useUser;
