<template>
  <q-layout view="hHh lpR fFf">
    <q-page-container>
      <q-page class="flex flex-center bg-primary">
        <q-card class="card q-pa-md">
          <img
            src="http://lomax.com.gt/wp-content/uploads/2019/02/logo-lomax-web-6.png"
            class="card-img"
          />
          <q-form
            class="q-gutter-md"
            ref="qForm"
            @submit.prevent="onSubmit"
            @reset="onReset"
          >
            <q-card-section>
              <q-input
                v-model="loginForm.email"
                type="email"
                label="Email"
                lazy-rules
                :rules="[(val) => val.length > 0 || 'Email is required']"
                placeholder="john.doe@gmail.com"
              >
                <template v-slot:before>
                  <q-icon name="alternate_email" />
                </template>
              </q-input>
              <q-input
                v-model="loginForm.password"
                :type="isVisiblePassword ? 'password' : 'text'"
                label="Password"
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
              <q-btn flat color="dark" label="Reset" type="reset" />
              <q-btn
                unelevated
                color="primary"
                label="Login"
                type="submit"
                :loading="isLoading"
              >
                <template v-slot:loading>
                  <q-spinner-facebook color="white" />
                </template>
              </q-btn>
            </q-card-actions>
          </q-form>
        </q-card>
      </q-page>
    </q-page-container>
  </q-layout>
</template>

<script>
import { defineComponent } from "vue";
import useValidations from "src/composables/useValidations";
import useAuth from "src/composables/useAuth";

export default defineComponent({
  name: "LoginPage",
  setup() {
    const { isValidEmail } = useValidations();
    const {
      isLoading,
      loginForm,
      qForm,
      isVisiblePassword,
      onSubmit,
      onReset,
    } = useAuth();

    return {
      loginForm,
      qForm,
      isVisiblePassword,
      isLoading,
      isValidEmail,
      onSubmit,
      onReset,
    };
  },
});
</script>

<style lang="scss" scoped>
.card {
  width: 400px;
  &-img {
    margin: 0 auto;
    width: 75%;
    height: auto;
  }
}
</style>
