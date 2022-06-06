import isAuthenticatedGuard from './guards/auth';

const routes = [
  {
    path: '/',
    component: () => import('layouts/MainLayout.vue'),
    beforeEnter: [isAuthenticatedGuard],
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
        path: '/activities/create',
        name: 'create-activity',
        component: () => import('pages/NewActivityPage.vue'),
      },
      {
        path: '/activities/edit/:id',
        name: 'edit-activity',
        component: () => import('pages/NewActivityPage.vue'),
      },
      {
        path: '/activities/enrolled',
        name: 'enrolled-activities',
        component: () => import('pages/EnrolledActivitiesPage.vue'),
      },
      {
        path: '/activities/created',
        name: 'created-activities',
        component: () => import('pages/CreatedActivitiesPage.vue'),
      },
      {
        path: '/activities/:id',
        name: 'activity',
        component: () => import('pages/ActivityPage.vue'),
      },
      {
        path: '/users',
        name: 'users',
        component: () => import('pages/UsersPage.vue'),
      }
    ]
  },
  {
    path: '/login',
    name: 'login',
    component: () => import('src/pages/LoginPage.vue'),
  },
  {
    path: '/:catchAll(.*)*',
    name: 'not-found',
    component: () => import('pages/ErrorNotFound.vue')
  }
];

export default routes;
