<template>
  <q-card class="modal-form">
    <q-card-section class="row items-center q-pb-none">
      <div class="text-h6">
        {{ isEditable ? "Actualizar" : "Crear" }} usuario
      </div>
      <q-space />
      <q-btn icon="close" flat round dense v-close-popup />
    </q-card-section>

    <q-card-section>
      <q-form
        @submit.prevent="isEditable ? onUpdate(newUser) : onCreate(newUser)"
        class="q-gutter-md"
        ref="qForm"
        autocomplete="off"
      >
        <q-card-section>
          <q-input
            v-model="newUser.name"
            label="Nombre"
            lazy-rules
            :rules="[(val) => val.length > 0 || 'El nombre es requerido']"
          >
            <template v-slot:before>
              <q-icon name="person" />
            </template>
          </q-input>
          <q-select
            v-model="newUser.role"
            :options="roles"
            label="Rol"
            lazy-rules
            :rules="[(val) => val.length > 0 || 'El rol es requerido']"
          >
            <template v-slot:before>
              <q-icon name="badge" />
            </template>
          </q-select>
          <q-input
            v-model="newUser.email"
            type="email"
            label="Email"
            lazy-rules
            :rules="[(val) => val.length > 0 || 'El email es requerido']"
          >
            <template v-slot:before>
              <q-icon name="alternate_email" />
            </template>
          </q-input>
          <template v-if="!isEditable">
            <q-input
              v-model="newUser.password"
              :type="isVisiblePassword ? 'password' : 'text'"
              label="Contraseña"
              lazy-rules
              :rules="[
                (val) => val.length > 0 || 'La contraseña es requerida',
                (val) =>
                  val.length > 6 ||
                  'La contraseña debe tener mas de 6 caracteres',
              ]"
            >
              <template v-slot:before>
                <q-icon name="lock" />
              </template>
              <template v-slot:append>
                <q-btn
                  flat
                  round
                  dense
                  color="grey"
                  :icon="isVisiblePassword ? 'visibility' : 'visibility_off'"
                  @click="isVisiblePassword = !isVisiblePassword"
                />
              </template>
            </q-input>
            <q-input
              v-model="newUser.password_confirmation"
              :type="isVisiblePassword ? 'password' : 'text'"
              label="Confirma la contraseña"
              lazy-rules
              :rules="[
                (val) =>
                  val.length > 0 ||
                  'La confirmacion de contraseña es requerida',
                (val) =>
                  val == newUser.password || 'Las contraseñas no coinciden',
              ]"
            >
              <template v-slot:before>
                <q-icon name="lock" />
              </template>
              <template v-slot:append>
                <q-btn
                  flat
                  round
                  dense
                  color="grey"
                  :icon="isVisiblePassword ? 'visibility' : 'visibility_off'"
                  @click="isVisiblePassword = !isVisiblePassword"
                />
              </template>
            </q-input>
          </template>
        </q-card-section>
        <q-card-actions align="right">
          <q-btn flat color="dark" label="Cancelar" v-close-popup />
          <q-btn
            unelevated
            flat
            color="primary"
            :label="isEditable ? 'Actualizar' : 'Crear'"
            type="submit"
          >
            <template v-slot:loading>
              <q-spinner-facebook color="white" />
            </template>
          </q-btn>
        </q-card-actions>
      </q-form>
    </q-card-section>
  </q-card>
</template>

<script>
import useUser from "src/composables/useUser";
import { useUserStore } from "src/stores/user-store";
import { defineComponent, ref } from "vue";
export default defineComponent({
  name: "userForm",
  setup() {
    const store = useUserStore();
    const {
      newUser,
      isVisiblePassword,
      getPassword,
      getPasswordConfirmation,
      roles,
      onCreate,
      onUpdate,
    } = useUser();
    const isEditable = ref(false);

    if (store.user) {
      isEditable.value = true;
      newUser.value.id = store.user?.id;
      newUser.value.name = store.user?.name;
      newUser.value.email = store.user?.email;
      newUser.value.role = store.user?.role;
    }

    return {
      newUser,
      isVisiblePassword,
      getPassword,
      getPasswordConfirmation,
      isEditable,
      roles,
      onCreate,
      onUpdate,
    };
  },
});
</script>

<style lang="scss" scoped>
.modal-form {
  width: 500px;
}
</style>
