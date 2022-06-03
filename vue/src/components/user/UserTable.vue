<template>
  <q-table
    bordered
    class="q-mt-lg"
    :rows="rows"
    :columns="columns"
    row-key="name"
  >
    <template v-slot:body-cell-actions="props">
      <q-td>
        <div class="flex justify-center no-wrap">
          <q-btn
            color="red"
            icon="delete"
            class="q-mr-md"
            @click="deleteUser(props.row)"
          >
            <q-tooltip
              anchor="center left"
              self="center right"
              :offset="[10, 10]"
            >
              Eliminar
            </q-tooltip>
          </q-btn>
          <q-btn color="primary" icon="edit" @click="editUser(props.row)">
            <q-tooltip
              anchor="center right"
              self="center left"
              :offset="[10, 10]"
            >
              Editar
            </q-tooltip>
          </q-btn>
        </div>
      </q-td>
    </template>
  </q-table>
</template>

<script>
import { defineComponent } from "vue";
export default defineComponent({
  name: "UserTable",
  props: {
    rows: {
      type: Array,
      required: true,
    },
    columns: {
      type: Array,
      required: true,
    },
  },
  setup(_, { emit }) {
    return {
      editUser: (user) => {
        emit("edit-user", user);
      },
      deleteUser: (user) => {
        emit("delete-user", user);
      },
    };
  },
});
</script>

<style lang="scss" scoped></style>
