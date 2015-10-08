app = angular.module('app')
app.factory 'Projects', [
  '$resource'
  ($resource) ->
    $resource '/projects', {},
      'get': method: 'GET'
      'create':
        method: 'POST'
        params: title: '@title'
]
app.factory 'Project', [
  '$resource'
  ($resource) ->
    $resource '/projects/:id', {},
      'update':
        method: 'PATCH'
        params:
          id: '@id'
          title: '@title'
      'destroy':
        method: 'DELETE'
        params: id: '@id'
]