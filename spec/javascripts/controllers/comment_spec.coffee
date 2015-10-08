#= require spec_helper
describe 'CommentCtrl', ->
  beforeEach ->
    @task_with_comments =  id: 1, title: 'first task', comments: [ { id: 1, text: 'first comments' }]
    @scope.task = @task_with_comments
    @controller('CommentCtrl', { $scope: @scope, $http: @http })

  describe 'addComments', ->
    beforeEach ->
      @scope.commentText = 'test comment'

      it 'create new comment', ->
        @http.expectPOST('/comments?text=test+comment&task_id=1').respond(200, '')
        @scope.addComments()
        @http.flush()

      it 'increased comments by 1', ->
        @http.whenPOST('/comments?text=New+comment&list_id=1').respond(200, '')
        @scope.addComments()
        @http.flush()
        expect(@scope.task.comments.length).toEqual(2)

  describe 'updateComment', ->
    it 'update comment by name', ->
      @new_name = 'NewCommentName'
      @http.expectPATCH('/comments/1?text=' + @new_name).respond(200, '')
      @scope.updateComment(@new_name, 1)
      @http.flush()

  describe 'removeComment', ->
    beforeEach ->
      @key = 0

    it 'remove comment', ->
      @http.expectDELETE('/comments/1').respond(200, '')
      @scope.removeComment(1, @key)
      @http.flush()

    it 'remove comment from display list', ->
      @http.whenDELETE('/comments/1').respond(200, '')
      @scope.removeComment(1, @key)
      @http.flush()
      expect(@scope.task.comments.length).toEqual(0)