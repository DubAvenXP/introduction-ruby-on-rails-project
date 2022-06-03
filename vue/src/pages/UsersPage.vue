<template>
  <q-page class="q-py-lg q-px-md">
    <div class="flex justify-between items-center">
      <span class="text-h3">Usuarios</span>
      <q-btn color="primary" icon="add_circle" label="Nuevo usuario" />
    </div>
    <h1 v-if="isLoading">Cargando...</h1>
    <user-table
      v-else
      :rows="users"
      :columns="columns"
      @edit-user="editUser"
      @delete-user="deleteUser"
    ></user-table>
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
  },
  setup() {
    const {
      fetchUsers,
      editUser,
      deleteUser,
      columns,
      users,
      isLoading,
      user,
    } = useUser();
    fetchUsers();
    return {
      editUser,
      deleteUser,
      columns,
      users,
      user,
      isLoading,
    };
  },
});
</script>
<style lang="scss" scoped></style>
