app = angular.module('app')


TaskCtrl = ($scope, Tasks, Task, CheckLogin, orderByFilter, toaster) ->
  CheckLogin()
  
  $scope.tasks = $scope.project.tasks
  angular.forEach $scope.tasks, (value, key) ->
    if value.deadline
       value.deadline = new Date(value.deadline)


  $scope.addTask = ->
    Tasks.create {
      project_id: $scope.project.id
      title: $scope.taskTitle
    }, (res) ->
      if res.message
        toaster.error res.message
      else
        $scope.tasks.push res.task
        $scope.taskTitle= ''

  $scope.updateTask = (data, id) ->
    Task.update {
      id: id
      title: data
    }, (res) ->
      if res.message
         toaster.error(res.message)


  $scope.updateDateTask = (data, id) ->
    Task.update
      id: id
      deadline: data

  $scope.removeTask = (id, key) ->
    Task.destroy { id: id }, ->
      $scope.tasks.splice key, 1

  $scope.toggleTaskStatus = (id, stat, key) ->
    Task.update {
      id: id
      status: !stat
    }, ->
      $scope.tasks[key].status = !stat

  $scope.activateTask = (task) ->
    $scope.activated_task = if $scope.activated_task == task then null else task

  $scope.sortableOptions = stop: (e, ui) ->
    angular.forEach $scope.tasks, (value, key) ->
      Task.update
        id: value.id
        position: key
  angular.forEach $scope.projects, (value, key) ->
    $scope.$watchCollection value, ->
      $scope.projects[key].tasks = orderByFilter($scope.projects[key].tasks, [ 'position' ])



app.controller 'TaskCtrl', [
  '$scope'
  'Tasks'
  'Task'
  'CheckLogin'
  'orderByFilter'
  'toaster'
  TaskCtrl
]
