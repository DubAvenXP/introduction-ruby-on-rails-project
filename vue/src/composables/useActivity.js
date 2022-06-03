import { useActivityStore } from "src/stores/activity-store";

const useActivity = () => {
  const store = useActivityStore();
  return {
    getImage: type => store.getActivityImageByType(type),
    getStartDate: (start_date) => {
      const date = new Date(start_date);
      return `${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear()}`;
    },
    getEnrollmentStatus: (enrollment) => {
      if (enrollment) {
        return "Inscripciones abiertas";
      } else if (!enrollment) {
        return "Inscripciones cerradas";
      } else {
        return "Sin información";
      }
    },
    capitalize: (str) => {
      return str.charAt(0).toUpperCase() + str.slice(1);
    },
    getValue: (value, currency = 'Q.') => {
      // transform to decimal
      const decimal = parseFloat(value);
      return `${currency} ${decimal.toFixed(2)} `;
    },
    getRoleAssignment: (roleAssignment) => {
      if (roleAssignment === "owner") return "Organizador";
      if (roleAssignment !== "owner") return "Miembro";
    }

  };
};


export default useActivity;
