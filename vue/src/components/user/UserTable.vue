<template>
  <q-table
    bordered
    class="q-mt-lg"
    :rows="rows"
    :columns="columns"
    row-key="name"
    :rows-per-page-options="[10, 25, 50, 100]"
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
          </q-btn>
          <q-btn color="primary" icon="edit" @click="editUser(props.row)">
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
