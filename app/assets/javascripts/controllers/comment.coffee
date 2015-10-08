app = angular.module('app')

CommentCtrl = ($scope, Comments, Comment, CheckLogin, toaster) ->
  CheckLogin()

  $scope.comments = $scope.task.comments

  $scope.addComments = ->
    Comments.create {
      task_id: $scope.task.id
      text: $scope.newComment
    }, (res) ->
      if !res.message
        $scope.newComment = ''
        $scope.comments.push(res.comment)


  $scope.updateComment = (data, id) ->
    Comment.update {
      id: id
      text: data
    }, (res) ->
      if res.message
         toaster.error(res.message)


  $scope.removeComment = (id, key) ->
    Comment.destroy { id: id }, ->
      $scope.comments.splice key, 1


app.controller 'CommentCtrl', [
  '$scope'
  'Comments'
  'Comment'
  'CheckLogin'
  'toaster'
  CommentCtrl
]