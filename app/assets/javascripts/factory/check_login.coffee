app = angular.module('app')
app.factory 'CheckLogin', [
  'Auth'
  '$state'
  (Auth, $state) ->
    ->
      if !Auth._currentUser
          $state.go 'signin'

]