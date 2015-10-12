app = angular.module('app')

MainCtrl = ($scope, $state, Auth,$http,toaster) ->


  Auth.currentUser().then ((user) ->
    $state.go 'projects'
  ), (error) ->

  $scope.logout = ->
    config = headers: 'X-HTTP-Method-Override': 'DELETE'
    Auth.logout(config).then ((oldUser) ->
    ), (error) ->


  $scope.$on 'devise:logout', (event, oldCurrentUser) ->
    $state.go 'signin'

  $scope.$on 'devise:new-session', (event, currentUser) ->

  $scope.$on 'devise:unauthorized', (event, xhr, deferred) ->
      if $state.is('projects') || $state.is('new_project')
          $state.go 'signin'

app.controller 'MainCtrl', [
  '$scope'
  '$state'
  'Auth'
  '$http'
  'toaster'
  MainCtrl
]
