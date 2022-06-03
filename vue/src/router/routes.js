
const routes = [
  {
    path: '/',
    component: () => import('layouts/MainLayout.vue'),
    children: [
      {
        path: '',
        redirect: '/activities'
      },
      {
        path: '/activities',
        name: 'activities',
        component: () => import('pages/ActivitiesPage.vue'),
      },
      {
        path: '/activities/:id',
        name: 'activity',
        component: () => import('pages/ActivityPage.vue'),
      },
    ]
  },
  {
    path: '/login',
    name: 'login',
    component: () => import('src/pages/LoginPage.vue'),
  },
  {
    path: '/:catchAll(.*)*',
    component: () => import('pages/ErrorNotFound.vue')
  }
];

export default routes;
