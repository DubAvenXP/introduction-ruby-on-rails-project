import { useQuasar } from 'quasar';
import { useAuthStore } from "src/stores/auth-store";
import { useRouter } from 'vue-router';
import { computed, ref } from "vue";

const useAuth = () => {
  const $q = useQuasar();
  const store = useAuthStore();
  const router = useRouter();
  const qForm = ref(null);
  const isVisiblePassword = ref(false);
  const loginForm = ref({
    email: "alejandrodubon88@gmail.com",
    password: "abc123#$%",
  });

  return {
    loginForm,
    qForm,
    isVisiblePassword,
    isLoading: store.isLoading,
    onSubmit: async () => {
      if (qForm.value) {
        const valid = await qForm.value.validate();
        if (valid) {

          $q.loading.show({
            delay: 400, // ms
            message: 'Iniciando sesión. Por favor, espera...',
            boxClass: 'bg-grey-2 text-grey-9',
            spinnerColor: 'primary',
          });

          const error = await store.login(loginForm.value);
          $q.loading.hide();

          if (!error) {
            router.push('/');
          } else {
            $q.notify({
              color: 'negative',
              message: 'Usuario o contraseña incorrectos',
              timeout: 2000,
              position: 'top-right',
            });
          }

        }
      }
    },
    onReset: () => {
      if (qForm.value) {
        loginForm.value = { email: '', password: '' };
        qForm.value.resetValidation();
      }
    },
    user: computed(() => store.user),
    logout: () => {
      store.logout();
      router.push("/login");
    }
  };

};

export default useAuth;
