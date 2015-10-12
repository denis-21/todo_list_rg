app = angular.module('app')


SignUpCtrl = ($scope, $state, Auth, toaster) ->

  if Auth._currentUser
    $state.go 'projects'
  $scope.user = {}



  $scope.signUp = ->

    if !$scope.user.email || !$scope.user.password || $scope.user.password_confirmation?
      config = headers: 'X-HTTP-Method-Override': 'POST'
      Auth.register($scope.user, config).then ((registeredUser) ->
                                                  console.log(registeredUser)
      ), (error) ->
        angular.forEach error.data.errors, (msg, fill) ->
          toaster.error fill + ' - ' + msg[0]
    else
      toaster.error 'password confirmation - doesnt empty'

  $scope.$on 'devise:new-registration', (event, currentUser) ->
    $state.go 'projects'



app.controller 'SignUpCtrl', [
  '$scope'
  '$state'
  'Auth'
  'toaster'
  SignUpCtrl
]