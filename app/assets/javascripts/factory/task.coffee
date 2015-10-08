app = angular.module('app')
app.factory 'Tasks', [
  '$resource'
  ($resource) ->
    $resource '/tasks', {},
      'create':
        method: 'POST'
        params:
          project_id: '@project_id'
          title: '@title'
          status: '@status'
]
app.factory 'Task', [
  '$resource'
  ($resource) ->
    $resource '/tasks/:id', {},
      'update':
        method: 'PATCH'
        params:
          id: '@id'
          title: '@title'
          status: '@status'
          deadline: '@deadline'
          position: '@position'
      'destroy':
        method: 'DELETE'
        params: id: '@id'
]