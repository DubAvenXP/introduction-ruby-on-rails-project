import { api } from 'src/boot/axios';

const isAuthenticatedGuard = async (_to, _from, next) => {

  const token = localStorage.getItem('token');

  if (!token) {
    localStorage.removeItem('token');
    localStorage.removeItem('user');
    next('/login');
    return;
  }

  try {
    const { data } = await api.post('/auth/verify');
    if (data.token) {
      localStorage.setItem('token', data.token);
      next();
    } else {
      localStorage.removeItem('token');
      localStorage.removeItem('user');
      next('/login');
    }
  } catch (error) {
    if (error) {
      localStorage.removeItem('token');
      localStorage.removeItem('user');
      next('/login');
    }
  }
};

export default isAuthenticatedGuard;
