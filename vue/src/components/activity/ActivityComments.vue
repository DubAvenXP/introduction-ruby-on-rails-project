<template>
  <article class="q-py-md q-pr-md q-card--bordered">
    <div class="flex justify-between q-mb-md">
      <span class="text-h4 q-pl-md">Comentarios</span>
    </div>
    <div class="q-pl-md">
      <q-input
        bottom-slots
        type="textarea"
        rows="3"
        v-model="comment"
        label="Ingresa un comentario"
        counter
        maxlength="145"
        dense
      >
        <template v-slot:before>
          <q-avatar>
            <img src="https://cdn.quasar.dev/img/boy-avatar.png" />
          </q-avatar>
        </template>

        <template v-slot:after>
          <q-btn round flat color="primary" icon="send" />
        </template>
      </q-input>
    </div>

    <q-list class="q-pt-md">
      <q-item v-for="comment in comments" :key="comment.id">
        <q-item-section avatar>
          <q-avatar>
            <img src="https://cdn.quasar.dev/img/boy-avatar.png" />
          </q-avatar>
        </q-item-section>

        <q-item-section>
          <q-item-label lines="1">{{ comment.user }}</q-item-label>
          <q-item-label caption lines="3">
            {{ comment.description }}
          </q-item-label>
        </q-item-section>

        <q-item-section side top> 1 min ago </q-item-section>
      </q-item>
    </q-list>
  </article>
</template>

<script>
import useActivity from "src/composables/useActivity";
import { defineComponent, ref } from "vue";
export default defineComponent({
  name: "ActivityComments",
  props: {
    comments: {
      type: Array,
      required: true,
    },
  },
  setup() {
    const { getValue } = useActivity();
    const comment = ref("");
    return {
      getValue,
      comment,
    };
  },
});
</script>
