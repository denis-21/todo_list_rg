app = angular.module('app')

MainCtrl = ($scope, $state, Auth,$http) ->


  Auth.currentUser().then ((user) ->
    $state.go 'projects'
  ), (error) ->

  $scope.logout = ->
    config = headers: 'X-HTTP-Method-Override': 'DELETE'
    Auth.logout(config).then ((oldUser) ->
                                Auth.logout(config).then ((oldUser) ->
                                ), (error) ->
    ), (error) ->


  $scope.$on 'devise:logout', (event, oldCurrentUser) ->
    $state.go 'signin'

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
