import { useQuasar } from "quasar";

const useNotify = () => {
  const $q = useQuasar();

  return {
    notifyError: (message) => {
      $q.notify({
        color: "negative",
        textColor: "white",
        message,
        position: "bottom-right",
      });
    },
    notifySuccess: (message) => {
      $q.notify({
        color: "positive",
        textColor: "white",
        message,
        position: "bottom-right",
      });
    },
  };
};


export default useNotify;
