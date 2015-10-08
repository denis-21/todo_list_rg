#= require spec_helper
describe 'ProjectsCtrl', ->
  beforeEach ->
    @controller('ProjectsCtrl', { $scope: @scope, $http: @http })
    @projects = { projects: [ { id: 1, title: 'first projects' } ] }

    @http.whenGET('/projects').respond(200, @projects)
    @http.flush()

  describe 'load', ->
    it 'sets up the list of projects', ->
      expect(@scope.projects.length).toEqual(1)

  describe 'createProject', ->
    beforeEach ->
      @scope.projectText = 'test project'

      it 'creates a new project', ->
        @http.expectPOST('/projects?title=test+project').respond(200, { id: 2, title: 'New Project' })
        @scope.create()
        @http.flush()

      it 'increased projects by 1', ->
        @http.whenPOST('/projects?title=New+Project').respond(200, { id: 2, title: 'New Project' })
        @scope.create()
        @http.flush()
        expect(@scope.projects.length).toEqual(2)

  describe 'updateProject', ->
    it 'updates a project and return nothing', ->
      @http.expectPATCH('/projects/1?title=new+name').respond(200, '')
      @scope.updateProject('new name', 1)
      @http.flush()

    it 'does not updates a project and return http status 200', ->
      @http.expectPATCH('/projects/1?title=').respond(200, '')
      @scope.updateProject('', 1)
      @http.flush()

  describe 'removeProject', ->
    beforeEach ->
      @key = 0

    it 'remove project', ->
      @http.expectDELETE('/projects/1').respond(200, '')
      @scope.removeProject(1, @key)
      @http.flush()

    it 'remove project from display list', ->
      @http.whenDELETE('/projects/1').respond(200, '')
      @scope.removeProject(1, @key)
      @http.flush()
      expect(@scope.projects.length).toEqual(0)