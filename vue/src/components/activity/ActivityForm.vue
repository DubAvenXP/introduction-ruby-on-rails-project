<script>
import useActivity from "src/composables/useActivity";
import { defineComponent } from "vue";

export default defineComponent({
  name: "ActivityForm",
  components: {},
  setup() {
    const {
      isLoading,
      newActivity,
      activity,
      isEditable,
      activityTypes,
      accessLevels,
      activityForm,
      onCreate,
      onReset,
      onUpdate,
    } = useActivity();

    if (isEditable && activity.value) {
      newActivity.value.name = activity.value.name;
      newActivity.value.description = activity.value.description;
      newActivity.value.activity_type = activity.value.activity_type;
      newActivity.value.access_level = activity.value.access_level;
      newActivity.value.start_date = activity.value.start_date;
      newActivity.value.end_date = activity.value.end_date;
      newActivity.value.location = activity.value.location;
      newActivity.value.budget = activity.value.budget;
    }

    return {
      isLoading,
      isEditable,
      newActivity,
      activityTypes,
      accessLevels,
      activityForm,
      onCreate,
      onReset,
      onUpdate,
    };
  },
});
</script>

<template>
  <q-form
    @submit.prevent="isEditable ? onUpdate() : onCreate()"
    @reset="onReset"
    class="q-gutter-md q-mt-md form"
    ref="activityForm"
  >
    <q-card>
      <q-card-section class="content">
        <q-input
          v-model="newActivity.name"
          type="text"
          label="Nombre"
          lazy-rules
          :rules="[(val) => val.length > 0 || 'El nombre es requerido']"
        >
          <template v-slot:before>
            <q-icon name="drive_file_rename_outline" />
          </template>
        </q-input>

        <q-input
          v-model="newActivity.description"
          type="textarea"
          label="Descripción"
          rows="2"
          maxlength="145"
          lazy-rules
          :rules="[(val) => val.length > 0 || 'La descripción es requerida']"
        >
          <template v-slot:before>
            <q-icon name="description" />
          </template>
        </q-input>

        <q-select
          v-model="newActivity.activity_type"
          :options="activityTypes"
          label="Tipo de actividad"
          lazy-rules
          :rules="[
            (val) => val.length > 0 || 'El tipo de actividad es requerido',
          ]"
        >
          <template v-slot:before>
            <q-icon name="assignment" />
          </template>
        </q-select>

        <q-select
          v-model="newActivity.access_level"
          :options="accessLevels"
          label="Nivel de acceso"
          lazy-rules
          :rules="[
            (val) => val.length > 0 || 'El nivel de acceso es requerido',
          ]"
        >
          <template v-slot:before>
            <q-icon name="public" />
          </template>
        </q-select>

        <q-input
          v-model="newActivity.location"
          type="text"
          label="Ubicación"
          lazy-rules
          :rules="[(val) => val.length > 0 || 'La ubicación es requerida']"
        >
          <template v-slot:before>
            <q-icon name="pin_drop" />
          </template>
        </q-input>

        <q-input
          v-model="newActivity.budget"
          type="number"
          label="Presupuesto"
          lazy-rules
          :rules="[
            (val) => val >= 0 || 'El presupuesto debe ser mayor o igual a 0',
          ]"
        >
          <template v-slot:before>
            <q-icon name="payments" />
          </template>
        </q-input>

        <div>
          <span class="text-dark text-subtitle1">Fecha y hora de inicio</span>
          <div class="flex q-mt-sm wrap">
            <q-input
              v-model="newActivity.start_date"
              lazy-rules
              :rules="[
                (val) =>
                  val.length > 0 || 'La fecha y hora de inicio es requerida',
              ]"
            >
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
          <span class="text-dark text-subtitle1">
            Fecha y hora de finalización
          </span>
          <div class="flex q-mt-sm wrap">
            <q-input
              v-model="newActivity.end_date"
              lazy-rules
              :rules="[
                (val) =>
                  val.length > 0 ||
                  'La fecha y hora de finalizacion es requerida',
              ]"
            >
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
        <q-btn v-if="!isEditable" type="reset" color="dark" label="Reiniciar" />
        <q-btn
          type="submit"
          color="primary"
          :label="isEditable ? 'Editar' : 'Crear'"
        />
      </q-card-actions>
    </q-card>
  </q-form>
</template>

<style lang="scss" scoped>
.form {
  max-width: 1080px;
}
.content {
  display: flex;
  flex-direction: column;
  gap: 4px;
}
</style>
