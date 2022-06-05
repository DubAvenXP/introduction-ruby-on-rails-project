import { useUserStore } from "src/stores/user-store";
import { computed, ref } from "vue";
import useNotify from "./useNotify";

const useUser = () => {
  const store = useUserStore();
  const { notifyError, notifySuccess } = useNotify();
  const newUser = ref({
    id: null,
    name: "",
    email: "",
    password: "",
    password_confirmation: "",
    role: "",
  });
  const columns = [
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
  ];
  const roles = [
    "super_administrator",
    "team_member",
  ];

  return {
    roles,
    newUser,
    columns,
    userModalVisibility: computed({
      get: () => store.userModalVisibility,
      set: (value) => {
        store.userModalVisibility = value;
      }
    }),
    confirmModalVisibility: computed({
      get: () => store.confirmModalVisibility,
      set: (value) => {
        store.confirmModalVisibility = value;
      }
    }),
    isVisiblePassword: ref(true),
    users: computed(() => store.users),
    user: computed(() => store.user),
    isLoading: computed(() => store.isLoading),
    displayUserModal: () => {
      store.user = null;
      store.userModalVisibility = true;
    },
    displayConfirmModal: (user) => {
      store.confirmModalVisibility = true;
      store.user = user;
    },
    fetchUsers: async () => {
      await store.fetchUsers();
    },
    edit: (user) => {
      store.user = user;
      store.userModalVisibility = true;
    },
    onUpdate: async (user) => {
      delete user.password;
      delete user.password_confirmation;
      const error = await store.updateUser(user);
      if (error) {
        notifyError("Ocurrio un error al actualizar al usuario");
        return;
      }
      store.userModalVisibility = false;
      notifySuccess("Usuario actualizado correctamente");
    },
    onCreate: async (user) => {
      const error = await store.createUser(user);
      if (error) {
        notifyError("Ocurrio un error al crear al usuario");
        return;
      }
      store.userModalVisibility = false;
      notifySuccess("Usuario creado correctamente");
    },
    onDelete: async () => {
      const error = await store.deleteUser(store.user?.id);
      if (error) {
        notifyError("Ocurrio un error al eliminar al usuario");
        return;
      }
      store.confirmModalVisibility = false;
      notifySuccess("Usuario eliminado correctamente");
    },
  };
};


export default useUser;
