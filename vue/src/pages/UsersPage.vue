<template>
  <q-page class="q-py-lg q-px-md">
    <div class="flex justify-between items-center">
      <span class="text-h3">Usuarios</span>
      <q-btn
        color="primary"
        icon="add_circle"
        label="Nuevo usuario"
        @click="userModal = true"
      />
    </div>
    <h1 v-if="isLoading">Cargando...</h1>
    <user-table
      v-else
      :rows="users"
      :columns="columns"
      @edit-user="editUser"
      @delete-user="deleteUser"
    ></user-table>
    <q-dialog v-model="userModal">
      <user-form></user-form>
    </q-dialog>
    <q-dialog v-model="userConfirmModal">
      <q-card>
        <q-card-section class="row items-center">
          <q-avatar icon="delete" color="primary" text-color="white" />
          <span class="q-ml-sm">
            ¿ Estas seguro que quieres eliminar a {{ selectedUser?.name }} ?
          </span>
        </q-card-section>

        <q-card-actions align="right">
          <q-btn flat label="Cancelar" color="primary" v-close-popup />
          <q-btn flat label="Eliminar" color="red" v-close-popup />
        </q-card-actions>
      </q-card>
    </q-dialog>
  </q-page>
</template>

<script>
import useUser from "src/composables/useUser";
import { defineAsyncComponent, defineComponent } from "vue";

export default defineComponent({
  name: "HomePage",
  components: {
    UserTable: defineAsyncComponent(() =>
      import("src/components/user/UserTable.vue")
    ),
    UserForm: defineAsyncComponent(() =>
      import("src/components/user/UserForm.vue")
    ),
  },
  setup() {
    const {
      fetchUsers,
      editUser,
      deleteUser,
      selectedUser,
      columns,
      users,
      isLoading,
      user,
      userModal,
      userConfirmModal,
    } = useUser();
    fetchUsers();
    return {
      editUser,
      deleteUser,
      selectedUser,
      columns,
      users,
      user,
      isLoading,
      userModal,
      userConfirmModal,
    };
  },
});
</script>
<style lang="scss" scoped></style>
