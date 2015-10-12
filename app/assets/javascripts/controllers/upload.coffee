app = angular.module('app')


UploadCtrl = ($scope, Upload, $timeout,toaster) ->

  $scope.uploadFiles = (files, comment_id) ->
    $scope.files = files
    angular.forEach files, (file) ->
      if file and !file.$error
        file.upload = Upload.upload(
          url: '/comments/' + comment_id + '/attach_files'
          file: file)
      file.upload.then ((response) ->
        file.result = response.data
        aray = response.data.comments
        $scope.comment.file_attachments.push(aray[aray.length - 1 ])
        toaster.success('File successfully uploaded')
      ), (response) ->
        if response.status > 0
          $scope.errorMsg = response.status + ': ' + response.data
      file.upload.progress (evt) ->
        file.progress = Math.min(100, parseInt(100.0 * evt.loaded / evt.total))



app.controller 'UploadCtrl', [
  '$scope'
  'Upload'
  '$timeout'
  'toaster'
  UploadCtrl
]