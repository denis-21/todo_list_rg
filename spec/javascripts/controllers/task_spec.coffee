#= require spec_helper
describe 'TaskCtrl', ->
  beforeEach ->
    @project_with_task =  id: 1, title: 'first projects', tasks: [ { id: 1, title: 'first task' }]
    @scope.project = @project_with_task
    @controller('TaskCtrl', { $scope: @scope, $http: @http })



  it "has updateDateTask method", ->
    expect(@scope.updateDateTask).toBeDefined()

  it "has toggleTaskStatus method", ->
    expect(@scope.toggleTaskStatus).toBeDefined()

  it "has addTask method", ->
    expect(@scope.addTask).toBeDefined()

  it "has updateTask method", ->
    expect(@scope.updateTask).toBeDefined()

  it "has removeTask method", ->
    expect(@scope.removeTask).toBeDefined()

  describe 'load', ->
    it 'sets up the list of tasks', ->
      expect(@scope.project.tasks.length).toEqual(1)

    it 'sort task by position', ->
      @first_task = { id: 1, title: 'first task', position: '2' }
      @second_task = { id: 2, title: 'second task', position: '1' }
      @scope.projects = [ id: 1, title: 'first projects', tasks: [ @first_task , @second_task ] ]
      @controller('TaskCtrl', { $scope: @scope })
      expect(@scope.projects[0].tasks[0]).toEqual(@first_task)


  describe 'addTask', ->

    it 'creates a new task', ->
      @scope.taskTitle = 'title2'
      @http.expectPOST('/tasks?project_id=1&title=title2').respond(200, { task: id: 2, title: 'title2'})
      @scope.addTask()
      expect(@scope.project.tasks.length).toEqual(1)

  describe 'toggleTaskStatus', ->
    beforeEach ->
      @key = 0

    it 'update task status from true to false', ->
      @http.expectPATCH('/tasks/1?status=true').respond(200, '')
      @scope.toggleTaskStatus(1, false, @key)
      @http.flush()

    it 'update task status from false to true', ->
      @http.expectPATCH('/tasks/1?status=false').respond(200, '')
      @scope.toggleTaskStatus(1, true, @key)
      @http.flush()

    it 'switch status in display list', ->
      @http.whenPATCH('/tasks/1?status=false').respond(200, '')
      @scope.toggleTaskStatus(1, true, @key)
      @http.flush()
      expect(@scope.project.tasks[@key].status).toEqual(false)

  describe 'removeTask', ->
    beforeEach ->
      @key = 0

    it 'remove task', ->
      @http.expectDELETE('/tasks/1').respond(200, '')
      @scope.removeTask(1, @key)
      @http.flush()

    it 'remove task from display list', ->
      @http.whenDELETE('/tasks/1').respond(200, '')
      @scope.removeTask(1, @key)
      @http.flush()
      expect(@scope.project.tasks.length).toEqual(0)

  describe 'sortableOptions', ->
    it 'update all task', ->
      @key = 0
      @http.expectPATCH('/tasks/1?position=' + @key).respond(200, '')
      @scope.sortableOptions.stop()
      @http.flush()