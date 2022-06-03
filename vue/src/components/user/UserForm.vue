<template>
  <q-card class="modal-form">
    <q-card-section class="row items-center q-pb-none">
      <div class="text-h6">Crear usuario</div>
      <q-space />
      <q-btn icon="close" flat round dense v-close-popup />
    </q-card-section>

    <q-card-section>
      <q-form class="q-gutter-md" ref="qForm" autocomplete="off">
        <q-card-section>
          <q-input
            v-model="userForm.name"
            label="Nombre"
            lazy-rules
            :rules="[(val) => val.length > 0 || 'El nombre es requerido']"
          >
            <template v-slot:before>
              <q-icon name="person" />
            </template>
          </q-input>
          <q-select
            v-model="userForm.role"
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
            v-model="userForm.email"
            type="email"
            label="Email"
            lazy-rules
            :rules="[(val) => val.length > 0 || 'Email is required']"
          >
            <template v-slot:before>
              <q-icon name="alternate_email" />
            </template>
          </q-input>
          <q-input
            v-model="userForm.password"
            :type="isVisiblePassword ? 'password' : 'text'"
            label="Contraseña"
            lazy-rules
            :rules="[(val) => val.length > 0 || 'Password is required']"
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
            v-model="userForm.password_confirmation"
            :type="isVisiblePassword ? 'password' : 'text'"
            label="Confirma la contraseña"
            lazy-rules
            :rules="[(val) => val.length > 0 || 'Password is required']"
            placeholder="********"
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
        </q-card-section>
        <q-card-actions align="right">
          <q-btn flat color="dark" label="Cancelar" type="reset" />
          <q-btn
            unelevated
            flat
            color="primary"
            label="Crear"
            type="submit"
            :loading="isLoading"
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
import { defineComponent, ref } from "vue";
export default defineComponent({
  name: "UserForm",
  setup(_, { emit }) {
    const userForm = ref({
      name: "",
      email: "",
      password: "",
      password_confirmation: "",
      role: "",
    });
    return {
      userForm,
      isVisiblePassword: ref(true),
      roles: [
        {
          label: "Administrador",
          value: "super_administrator",
        },
        {
          label: "Usuario",
          value: "team_member",
        },
      ],
    };
  },
});
</script>

<style lang="scss" scoped>
.modal-form {
  width: 500px;
}
</style>
