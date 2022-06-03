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

    <q-drawer v-model="drawer" show-if-above :width="200" :breakpoint="400">
      <q-scroll-area
        style="
          height: calc(100% - 150px);
          margin-top: 150px;
          border-right: 1px solid #ddd;
        "
      >
        <q-list padding>
          <q-item clickable v-ripple>
            <q-item-section avatar>
              <q-icon name="inbox" />
            </q-item-section>

            <q-item-section> Inbox </q-item-section>
          </q-item>

          <q-item active clickable v-ripple>
            <q-item-section avatar>
              <q-icon name="star" />
            </q-item-section>

            <q-item-section> Star </q-item-section>
          </q-item>

          <q-item clickable v-ripple>
            <q-item-section avatar>
              <q-icon name="send" />
            </q-item-section>

            <q-item-section> Send </q-item-section>
          </q-item>

          <q-item clickable v-ripple>
            <q-item-section avatar>
              <q-icon name="drafts" />
            </q-item-section>

            <q-item-section> Drafts </q-item-section>
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
          <div class="text-weight-bold">Razvan Stoenescu</div>
          <div>@rstoenescu</div>
        </div>
      </q-img>
    </q-drawer>

    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script>
import { useAppStore } from "src/stores/application-store";
import { defineComponent, ref } from "vue";
import { useRouter } from "vue-router";

const menuList = [
  {
    icon: "inbox",
    label: "Actividades",
    separator: false,
  },
  {
    icon: "send",
    label: "Outbox",
    separator: false,
  },
  {
    icon: "delete",
    label: "Trash",
    separator: false,
  },
  {
    icon: "error",
    label: "Spam",
    separator: true,
  },
  {
    icon: "settings",
    label: "Settings",
    separator: false,
  },
  {
    icon: "feedback",
    label: "Send Feedback",
    separator: false,
  },
  {
    icon: "help",
    iconColor: "primary",
    label: "Help",
    separator: false,
  },
];

export default defineComponent({
  name: "MainLayout",

  setup() {
    const drawer = ref(false);
    const store = useAppStore();
    const router = useRouter();
    return {
      drawer,
      toggleLeftDrawer() {
        drawer.value = !drawer.value;
      },
      menuList,
      logout() {
        store.logout();
        router.push("/login");
      },
    };
  },
});
</script>
