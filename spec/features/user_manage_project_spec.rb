require 'rails_helper'

feature 'project', js: true do
  given(:user) { FactoryGirl.create(:user) }
  given!(:project) { FactoryGirl.create(:project, user: user, title: 'test project') }

  before do
    login_as user, scope: :user
    visit '/#/projects'
  end

  scenario 'user press \'Add Project\' button and create new project' do
    find('.btn-add-project').click
    find('#new_project').set 'good project'
    click_button 'CREATE'
    expect(page).to have_content('good project')
  end

  scenario 'user can delete his projects' do
    find('.project-buttons .fa-trash').click
    expect(page).not_to have_content project.title
  end

  scenario 'user can edit project name' do
    find('.project-title').click
    find('.editable-input').set 'new name'
    within('.editable-buttons') do
      find('.btn-primary').click
    end
    expect(page).to have_content 'new name'
  end

  scenario 'user leave the project name field empty' do
    find('.project-title').click
    find('.editable-input').set ''
    within('.editable-buttons') do
      find('.btn-primary').click
    end
    expect(page).to have_content 'Project has not been updated'
  end

end