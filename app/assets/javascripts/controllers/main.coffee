app = angular.module('app')

MainCtrl = ($scope, $state, Auth,$http) ->

  Auth.currentUser().then ((user) ->
    $state.go 'projects'
  ), (error) ->

  $scope.logout = ->
    config = headers: 'X-HTTP-Method-Override': 'DELETE'
    Auth.logout(config).then ((oldUser) ->
                                $state.go 'signin'
    ), (error) ->


  $scope.$on 'devise:login', (event, currentUser) ->
    $state.go 'projects'
  $scope.$on 'devise:new-session', (event, currentUser) ->


  $scope.$on 'devise:logout', (event, oldCurrentUser) ->

  $scope.$on 'devise:new-session', (event, currentUser) ->

  $scope.$on 'devise:unauthorized', (event, xhr, deferred) ->
    if $state.is('projects')
        $state.go 'signin'

app.controller 'MainCtrl', [
  '$scope'
  '$state'
  'Auth'
  '$http'
  MainCtrl
]
