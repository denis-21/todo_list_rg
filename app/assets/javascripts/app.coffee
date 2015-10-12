app = angular.module('app', [
  'ui.router'
  'templates'
  'xeditable'
  'ngResource'
  'Devise'
  'ngFileUpload'
  'toaster'
  'ui.sortable'
])
app.config [
  '$stateProvider'
  '$urlRouterProvider'
  ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise '/sign-in'
    $stateProvider
    .state 'signin',
      url: '/sign-in'
      templateUrl: 'sing_in.html'
      controller: 'SignInCtrl'
    .state 'signup',
      url: '/sign-up'
      templateUrl: 'sing_up.html'
      controller: 'SignUpCtrl'
    .state 'projects',
      url: '/projects'
      templateUrl: 'projects.html'
      controller: 'ProjectsCtrl'
    .state 'new_project',
      url: '/projects/new'
      templateUrl: 'new_project.html'
      controller: 'ProjectsCtrl'
    return
]

app.config [
  '$httpProvider'
  ($httpProvider) ->
    $httpProvider.defaults.withCredentials = true
]

app.config [
  'AuthInterceptProvider'
  (AuthInterceptProvider) ->
    AuthInterceptProvider.interceptAuth(true);
]

app.run(['$state','editableOptions','editableThemes',
  ($state, editableOptions, editableThemes) ->
    editableThemes.bs3.inputClass = 'input-sm'
    editableThemes.bs3.buttonsClass = 'btn-sm'
    editableOptions.theme = 'bs3'
])


app.directive 'project', ->
  { templateUrl: '_project.html' }
app.directive 'task', ->
  { templateUrl: '_task.html' }
app.directive 'comment', ->
  { templateUrl: '_comment.html' }
app.directive 'logout', ->
  { templateUrl: '_logout.html' }
