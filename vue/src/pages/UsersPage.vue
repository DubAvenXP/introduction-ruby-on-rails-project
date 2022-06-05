<template>
  <q-page class="q-py-lg q-px-md">
    <div class="flex justify-between items-center">
      <span class="text-h3">Usuarios</span>
      <q-btn
        color="primary"
        icon="add_circle"
        label="Nuevo usuario"
        @click="displayUserModal"
      />
    </div>
    <h1 v-if="isLoading">Cargando...</h1>
    <user-table
      v-else
      :rows="users"
      :columns="columns"
      @edit-user="edit"
      @delete-user="displayConfirmModal"
    ></user-table>

    <q-dialog v-model="userModalVisibility">
      <user-form></user-form>
    </q-dialog>

    <q-dialog v-model="confirmModalVisibility">
      <q-card>
        <q-card-section class="row items-center">
          <q-avatar icon="delete" color="primary" text-color="white" />
          <span class="q-ml-sm">
            ¿ Estas seguro que quieres eliminar a {{ user?.name }} ?
          </span>
        </q-card-section>
        <q-card-actions align="right">
          <q-btn flat label="Cancelar" color="primary" v-close-popup />
          <q-btn flat label="Eliminar" color="red" @click="onDelete" />
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
      isLoading,
      users,
      user,
      columns,
      userModalVisibility,
      confirmModalVisibility,
      edit,
      fetchUsers,
      displayUserModal,
      displayConfirmModal,
      onDelete,
    } = useUser();
    fetchUsers();
    return {
      isLoading,
      users,
      user,
      columns,
      userModalVisibility,
      confirmModalVisibility,
      edit,
      displayUserModal,
      displayConfirmModal,
      onDelete,
    };
  },
});
</script>
<style lang="scss" scoped></style>
