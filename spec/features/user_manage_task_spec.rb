require 'rails_helper'

feature 'task', js: true do
  given(:user) { FactoryGirl.create(:user) }
  given!(:project) { FactoryGirl.create(:project, user: user, title: 'test project') }
  given!(:task) { FactoryGirl.create(:task, project: project) }

  before do
    login_as user, scope: :user
    visit '/#/projects'
  end

  scenario 'user fill in task name and press \' Add task \' button' do
    find('.input_new_task').set 'new task'
    click_on('Add task')
    expect(page).to have_content 'new task'
    expect(page).to have_css('.fa-comments')
    expect(page).to have_css('.task-buttons .fa-trash')
  end

  scenario 'user can delete task from project' do
    find('.task-buttons .fa-trash').click
    expect(page).not_to have_content task.title
  end

  scenario 'user want to be able mark task as done' do
    find('#task_status').set true
    expect(page).to have_css('.done')
  end

  scenario 'user can edit task name' do
    find('.task-title').click
    find('.editable-input').set 'new task name'
    within('.editable-buttons') do
      find('.btn-primary').click
    end
    expect(page).to have_content 'new task name'
  end

  scenario 'user want set task deadline' do
    find('.task_deadline').click
    find('.editable-input').set '2015-01-01'
    within('.editable-buttons') do
      find('.btn-primary').click
    end
    expect(page).to have_content '01/01'
  end

  scenario 'user leave the task name field empty' do
    find('.task-title').click
    find('.editable-input').set ''
    within('.editable-buttons') do
      find('.btn-primary').click
    end
    expect(page).to have_content 'Task has not been updated'
  end

end