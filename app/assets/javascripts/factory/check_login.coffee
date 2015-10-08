app = angular.module('app')
app.factory 'CheckLogin', [
  'Auth'
  '$state'
  (Auth, $state) ->
    ->
      if !Auth.isAuthenticated()
        $state.go 'signin'

]