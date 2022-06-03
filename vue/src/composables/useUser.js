import { useUserStore } from "src/stores/user-store";
import { computed, ref } from "vue";

const useUser = () => {
  const store = useUserStore();

  const userConfirmModal = ref(false);
  const selectedUser = ref(null);
  return {
    fetchUsers: async () => {
      await store.fetchUsers();
    },
    userModal: ref(false),
    userConfirmModal,
    selectedUser,
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
      userConfirmModal.value = true;
      selectedUser.value = user;
    },
    editUser: (user) => {
      console.log(user);
    }

  };
};


export default useUser;
