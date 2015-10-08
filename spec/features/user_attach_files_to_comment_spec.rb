require 'rails_helper'

feature 'attach files', js: true do
  given(:user) { FactoryGirl.create(:user) }
  given!(:project) { FactoryGirl.create(:project, user: user, title: 'test project') }
  given!(:task) { FactoryGirl.create(:task, project: project) }
  given!(:comment) { FactoryGirl.create(:comment, task: task) }

  before do
    login_as user, scope: :user
    visit '/#/projects'
    @file = Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'test.txt'), 'text/plain')
  end

  scenario 'user attach files to comment' do
    find('.task-buttons .fa-comments').click
    find('.button_upload').set(@file)
    save_screenshot('./spec/screen/files.png')
  end

end