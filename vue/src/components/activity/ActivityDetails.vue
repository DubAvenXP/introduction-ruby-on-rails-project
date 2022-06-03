<template>
  <article class="q-py-md q-pr-md q-card--bordered">
    <div class="flex justify-between q-mb-md">
      <span class="text-h4 q-pl-md">Detalles</span>
      <q-btn color="primary" icon="edit" />
    </div>
    <q-list class="q-pt-md q-pr-md">
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
          <q-avatar
            text-color="white"
            rounded
            color="primary"
            icon="pin_drop"
          />
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
      <q-item>
        <q-item-section avatar>
          <q-avatar
            text-color="white"
            rounded
            color="primary"
            icon="payments"
          />
        </q-item-section>
        <q-item-section
          ><strong>Presupuesto</strong>
          {{ getValue(activity.budget) }}
        </q-item-section>
      </q-item>
    </q-list>
  </article>
</template>

<script>
import useActivity from "src/composables/useActivity";
import { defineComponent } from "vue";
export default defineComponent({
  name: "ActivityDetails",
  props: {
    activity: {
      type: Object,
      required: true,
    },
  },
  setup() {
    const { getValue } = useActivity();
    return {
      getValue,
    };
  },
});
</script>
