<template>
  <q-layout view="hHh Lpr lFf">
    <q-header elevated>
      <q-toolbar class="flex justify-between">
        <q-btn
          flat
          dense
          round
          icon="menu"
          aria-label="Menu"
          @click="toggleLeftDrawer"
        />

        <span class="text-h6"> Lomax Technologies </span>

        <q-btn flat round icon="logout" @click="logout" />
      </q-toolbar>
    </q-header>

    <q-drawer v-model="drawer" show-if-above :width="225" :breakpoint="500">
      <q-scroll-area
        style="
          height: calc(100% - 150px);
          margin-top: 150px;
          border-right: 1px solid #ddd;
        "
      >
        <q-list padding>
          <q-item :to="{ name: 'activities' }" clickable v-ripple>
            <q-item-section avatar>
              <q-icon name="public" />
            </q-item-section>
            <q-item-section> Explorar </q-item-section>
          </q-item>

          <q-separator spaced />
          <q-item :to="{ name: 'users' }" clickable v-ripple>
            <q-item-section avatar>
              <q-icon name="group" />
            </q-item-section>
            <q-item-section> Usuarios </q-item-section>
          </q-item>

          <q-separator spaced />
          <q-item>
            <q-item-section> Actividades </q-item-section>
          </q-item>

          <q-item :to="{ name: 'create-activity' }" clickable v-ripple>
            <q-item-section avatar class="q-pl-md">
              <q-icon name="add_circle" />
            </q-item-section>
            <q-item-section> Crear </q-item-section>
          </q-item>

          <q-item :to="{ name: 'created-activities' }" clickable v-ripple>
            <q-item-section avatar class="q-pl-md">
              <q-icon name="archive" />
            </q-item-section>

            <q-item-section> Mis actividades </q-item-section>
          </q-item>

          <q-item :to="{ name: 'enrolled-activities' }" clickable v-ripple>
            <q-item-section avatar class="q-pl-md">
              <q-icon name="calendar_month" />
            </q-item-section>

            <q-item-section> Inscrito </q-item-section>
          </q-item>
        </q-list>
      </q-scroll-area>

      <q-img
        class="absolute-top"
        src="https://cdn.quasar.dev/img/material.png"
        style="height: 150px"
      >
        <div class="absolute-bottom bg-transparent">
          <q-avatar size="75px" class="q-mb-sm">
            <img src="https://cdn.quasar.dev/img/boy-avatar.png" />
          </q-avatar>
          <div class="text-weight-bold">{{ user?.name }}</div>
          <div>{{ user?.email }}</div>
        </div>
      </q-img>
    </q-drawer>

    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script>
import useAuth from "src/composables/useAuth";
import { defineComponent, ref } from "vue";

export default defineComponent({
  name: "MainLayout",

  setup() {
    const drawer = ref(false);
    const { user, logout } = useAuth();
    return {
      drawer,
      toggleLeftDrawer() {
        drawer.value = !drawer.value;
      },
      user,
      logout,
    };
  },
});
</script>
