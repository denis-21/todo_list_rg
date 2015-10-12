app = angular.module('app')


ProjectsCtrl = ($scope, $state, Auth, Projects, Project, CheckLogin, toaster) ->


  Projects.get (response) ->
    $scope.projects = response.projects

  $scope.new_project = ->
    $state.go 'new_project'

  $scope.create = ->
    Projects.create { title: $scope.title }, (res) ->
      if res.message
        toaster.error res.message
      else
        $state.go 'projects'

  $scope.updateProject = (data, id) ->
    Project.update {
      id: id
      title: data
    }, (res) ->
      if res.message
         toaster.error(res.message)


  $scope.removeProject = (id, key) ->
    Project.destroy { id: id }, ->
      $scope.projects.splice key, 1


app.controller 'ProjectsCtrl', [
  '$scope'
  '$state'
  'Auth'
  'Projects'
  'Project'
  'CheckLogin'
  'toaster'
  ProjectsCtrl
]