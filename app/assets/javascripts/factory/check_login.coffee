app = angular.module('app')
app.factory 'CheckLogin', [
  'Auth'
  '$state'
  (Auth, $state) ->
    ->
      Auth.currentUser().then ((user) ->
      ), (error) ->
           $state.go 'signin'

]