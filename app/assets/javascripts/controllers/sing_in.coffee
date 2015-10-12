app = angular.module('app')


SignInCtrl = ($scope, $state, Auth, toaster) ->

  $scope.user =
      email: ''
      password: ''

  if Auth._currentUser
    $state.go 'projects'

  config = headers: 'X-HTTP-Method-Override': 'POST'
  Auth.currentUser().then ((user) ->
    $state.go 'signin'
  ), (error) ->

  $scope.login = ->
      Auth.login($scope.user, config).then ((user) ->
          toaster.success user.email + ' signed in successfully.'
  ), (error) ->
         toaster.error error.data.error

  $scope.$on 'devise:login', (event, currentUser) ->
    $state.go 'projects'
  $scope.$on 'devise:new-session', (event, currentUser) ->




app.controller 'SignInCtrl', [
  '$scope'
  '$state'
  'Auth'
  'toaster'
  SignInCtrl
]