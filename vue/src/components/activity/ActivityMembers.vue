<template>
  <article class="q-py-md q-pr-md q-card--bordered">
    <div class="flex justify-between q-mb-md">
      <span class="text-h4 q-pl-md">Participantes</span>
      <q-btn color="primary" icon="person_add" label="Asistir" />
    </div>
    <q-list class="q-pt-md q-pr-md">
      <q-item v-for="member in members" :key="member.id">
        <q-item-section avatar>
          <q-avatar>
            <img src="https://cdn.quasar.dev/img/boy-avatar.png" />
          </q-avatar>
        </q-item-section>
        <q-item-section>{{ member.user }}</q-item-section>
        <q-item-section>
          <q-item-label caption lines="1">{{
            getRoleAssignment(member.role_assignment)
          }}</q-item-label>
          <q-item-label caption lines="2">
            Aporte: {{ getValue(member.amount_to_pay) }}
          </q-item-label>
        </q-item-section>
        <q-item-section>
          <q-item-label class="flex justify-end" caption lines="1">
            <q-btn
              v-if="member.role_assignment !== 'owner'"
              round
              color="negative"
              icon="delete"
            />
          </q-item-label>
        </q-item-section>
      </q-item>
    </q-list>
  </article>
</template>

<script>
import useActivity from "src/composables/useActivity";
import { defineComponent } from "vue";
export default defineComponent({
  name: "ActivitMembers",
  props: {
    members: {
      type: Array,
      required: true,
    },
  },
  setup() {
    const { getRoleAssignment, getValue } = useActivity();
    return {
      getRoleAssignment,
      getValue,
    };
  },
});
</script>

<style lang="scss" scoped></style>
