require 'rails_helper'

feature 'comment', js: true do
  given(:user) { FactoryGirl.create(:user) }
  given!(:project) { FactoryGirl.create(:project, user: user, title: 'test project') }
  given!(:task) { FactoryGirl.create(:task, project: project) }
  given!(:comment) { FactoryGirl.create(:comment, task: task) }

  before do
    login_as user, scope: :user
    visit '/#/projects'
  end

  scenario 'user add new comment to task' do
    find('.task-buttons .fa-comments').click
    find('.new_comment').set 'test comment'
    click_button 'Add comment'
    expect(page).to have_content 'test comment'
  end

  scenario 'user can delete comment from project' do
    find('.task-buttons .fa-comments').click
    find('.remove_comment').click
    expect(page).not_to have_content comment.text
  end

  scenario 'user can edit comment' do
    find('.task-buttons .fa-comments').click
    find('.update_comment').click
    find('.editable-input').set 'new comment name'
    within('.editable-buttons') do
      find('.btn-primary').click
    end
    expect(page).to have_content 'new comment name'
  end

  scenario 'user leave the comment name field empty' do
    find('.task-buttons .fa-comments').click
    find('.update_comment').click
    find('.editable-input').set ''
    within('.editable-buttons') do
      find('.btn-primary').click
    end
    expect(page).to have_content 'Comment has not been updated'
  end

end