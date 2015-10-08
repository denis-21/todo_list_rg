app = angular.module('app')
app.factory 'Comments', [
  '$resource'
  ($resource) ->
    $resource '/comments', {},
      'create':
        method: 'POST'
        params:
          task_id: '@task_id'
          text: '@text'
]
app.factory 'Comment', [
  '$resource'
  ($resource) ->
    $resource '/comments/:id', {},
      'update':
        method: 'PATCH'
        params:
          id: '@id'
          text: '@text'
      'destroy':
        method: 'DELETE'
        params: id: '@id'
]