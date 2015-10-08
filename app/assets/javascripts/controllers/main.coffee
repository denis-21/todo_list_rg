app = angular.module('app')

MainCtrl = ($scope, $state, Auth) ->


  $scope.logout = ->
    config = headers: 'X-HTTP-Method-Override': 'DELETE'
    Auth.logout(config).then ((oldUser) ->
    ), (error) ->


  $scope.$on 'devise:logout', (event, oldCurrentUser) ->
    $state.go 'signin'


app.controller 'MainCtrl', [
  '$scope'
  '$state'
  'Auth'
  MainCtrl
]
