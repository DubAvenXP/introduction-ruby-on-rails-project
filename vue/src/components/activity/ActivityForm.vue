<template>
  <q-form class="q-gutter-md q-mt-md form">
    <q-card>
      <q-card-section class="content">
        <q-input v-model="newActivity.name" type="text" label="Nombre">
          <template v-slot:before>
            <q-icon name="drive_file_rename_outline" />
          </template>
        </q-input>

        <q-input
          v-model="newActivity.description"
          type="textarea"
          label="Descripción"
          rows="2"
        >
          <template v-slot:before>
            <q-icon name="description" />
          </template>
        </q-input>

        <q-select
          v-model="newActivity.activity_type"
          :options="activityTypes"
          label="Tipo de actividad"
        >
          <template v-slot:before>
            <q-icon name="assignment" />
          </template>
        </q-select>

        <q-select
          v-model="newActivity.access_level"
          :options="accessLevels"
          label="Nivel de acceso"
        >
          <template v-slot:before>
            <q-icon name="public" />
          </template>
        </q-select>

        <q-input v-model="newActivity.location" type="text" label="Ubicación">
          <template v-slot:before>
            <q-icon name="pin_drop" />
          </template>
        </q-input>

        <q-input v-model="newActivity.budget" type="number" label="Presupuesto">
          <template v-slot:before>
            <q-icon name="payments" />
          </template>
        </q-input>

        <div>
          <span class="text-dark text-subtitle1">Fecha y hora de inicio</span>
          <div class="flex q-mt-sm wrap">
            <q-input v-model="newActivity.start_date">
              <template v-slot:prepend>
                <q-icon name="event" class="cursor-pointer">
                  <q-popup-proxy
                    cover
                    transition-show="scale"
                    transition-hide="scale"
                  >
                    <q-date
                      v-model="newActivity.start_date"
                      mask="YYYY-MM-DD HH:mm"
                    >
                      <div class="row items-center justify-end">
                        <q-btn v-close-popup label="Close" flat />
                      </div>
                    </q-date>
                  </q-popup-proxy>
                </q-icon>
              </template>

              <template v-slot:append>
                <q-icon name="access_time" class="cursor-pointer">
                  <q-popup-proxy
                    cover
                    transition-show="scale"
                    transition-hide="scale"
                  >
                    <q-time
                      v-model="newActivity.start_date"
                      mask="YYYY-MM-DD HH:mm"
                      format12h
                    >
                      <div class="row items-center justify-end">
                        <q-btn v-close-popup label="Close" color="dark" flat />
                      </div>
                    </q-time>
                  </q-popup-proxy>
                </q-icon>
              </template>
            </q-input>
          </div>
        </div>

        <div>
          <span class="text-dark text-subtitle1"
            >Fecha y hora de finalización</span
          >
          <div class="flex q-mt-sm wrap">
            <q-input v-model="newActivity.end_date">
              <template v-slot:prepend>
                <q-icon name="event" class="cursor-pointer">
                  <q-popup-proxy
                    cover
                    transition-show="scale"
                    transition-hide="scale"
                  >
                    <q-date
                      v-model="newActivity.end_date"
                      mask="YYYY-MM-DD HH:mm"
                    >
                      <div class="row items-center justify-end">
                        <q-btn v-close-popup label="Close" flat />
                      </div>
                    </q-date>
                  </q-popup-proxy>
                </q-icon>
              </template>

              <template v-slot:append>
                <q-icon name="access_time" class="cursor-pointer">
                  <q-popup-proxy
                    cover
                    transition-show="scale"
                    transition-hide="scale"
                  >
                    <q-time
                      v-model="newActivity.end_date"
                      mask="YYYY-MM-DD HH:mm"
                      format12h
                    >
                      <div class="row items-center justify-end">
                        <q-btn v-close-popup label="Close" color="dark" flat />
                      </div>
                    </q-time>
                  </q-popup-proxy>
                </q-icon>
              </template>
            </q-input>
          </div>
        </div>
      </q-card-section>

      <q-card-actions align="right">
        <q-btn color="dark" label="Cancelar" />
        <q-btn color="primary" label="Crear" />
      </q-card-actions>
    </q-card>
  </q-form>
</template>

<script>
import useActivity from "src/composables/useActivity";
import { defineComponent } from "vue";

export default defineComponent({
  name: "ActivityForm",
  components: {},
  setup() {
    const { newActivity, activityTypes, accessLevels } = useActivity();
    return {
      newActivity,
      activityTypes,
      accessLevels,
    };
  },
});
</script>

<style lang="scss" scoped>
.form {
  max-width: 1080px;
}
.content {
  display: flex;
  flex-direction: column;
  gap: 16px;
}
</style>
