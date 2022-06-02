<template>
  <q-list bordered class="q-pt-md participants">
    <span class="text-h4 q-pl-md">Participantes</span>
    <q-item clickable v-ripple v-for="i in 10" :key="i">
      <q-item-section avatar>
        <q-avatar>
          <img src="https://cdn.quasar.dev/img/boy-avatar.png" />
        </q-avatar>
      </q-item-section>
      <q-item-section>John Doe</q-item-section>
      <q-item-section>
        <q-item-label caption lines="1">Organizador</q-item-label>
        <q-item-label caption lines="2">Aporte: Q.500.00</q-item-label>
      </q-item-section>
    </q-item>
  </q-list>
</template>

<script>
import { defineComponent } from "vue";
export default defineComponent({
  name: "ActivitMembers",
  props: {
    activity: {
      type: Object,
      required: true,
    },
  },
});
</script>

<style lang="scss" scoped>
.participants {
  overflow-y: scroll;
}
</style>
