<template>
  <q-list bordered class="q-pt-md">
    <span class="text-h4 q-pl-md">Detalles</span>
    <q-item>
      <q-item-section>{{ activity.description }}</q-item-section>
    </q-item>
    <q-item>
      <q-item-section avatar>
        <q-avatar
          text-color="white"
          rounded
          color="primary"
          icon="calendar_month"
        />
      </q-item-section>
      <q-item-section
        ><strong>Comienza</strong> {{ activity.start_date }}</q-item-section
      >
    </q-item>
    <q-item>
      <q-item-section avatar>
        <q-avatar
          text-color="white"
          rounded
          color="primary"
          icon="calendar_month"
        />
      </q-item-section>
      <q-item-section
        ><strong>Termina</strong> {{ activity.end_date }}</q-item-section
      >
    </q-item>
    <q-item>
      <q-item-section avatar>
        <q-avatar text-color="white" rounded color="primary" icon="pin_drop" />
      </q-item-section>
      <q-item-section
        ><strong>Ubicación</strong> {{ activity.location }}</q-item-section
      >
    </q-item>
    <q-item>
      <q-item-section avatar>
        <q-avatar
          text-color="white"
          rounded
          color="primary"
          icon="person_add"
        />
      </q-item-section>
      <q-item-section
        ><strong>Inscripciones</strong>
        {{ activity.enrollment ? "Abiertas" : "Cerradas" }}</q-item-section
      >
    </q-item>
    <q-item>
      <q-item-section avatar>
        <q-avatar
          text-color="white"
          rounded
          color="primary"
          :icon="activity.access_level === 'public' ? 'public' : 'lock'"
        />
      </q-item-section>
      <q-item-section
        ><strong>Nivel de acceso</strong>
        {{
          activity.access_level == "public" ? "Público" : "Privado"
        }}</q-item-section
      >
    </q-item>
  </q-list>
</template>

<script>
import { defineComponent } from "vue";
export default defineComponent({
  name: "ActivityDetails",
  props: {
    activity: {
      type: Object,
      required: true,
    },
  },
});
</script>
