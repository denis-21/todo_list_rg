require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:ability) { Ability.new(user) }

  before do
    allow(controller).to receive(:current_ability).and_return(ability)
    ability.can :manage, :all
    sign_in user
  end

  let(:task) { FactoryGirl.create(:task) }

  describe 'GET #index' do
    before { task; get :index }

    context 'cancan doesnt allow :index' do
      before do
        ability.cannot :index, Task
        get :index
      end
      it { expect(response).to redirect_to(root_path) }
    end

    it { expect(response).to have_http_status(200) }

    xit 'generate @tasks' do
      expect(assigns(:tasks)).not_to be_nil
    end

  end

  describe 'POST #create' do

    context 'cancan doesnt allow :create' do
      before do
        ability.cannot :create, Task
        post :create, title: task.title
      end
      it { expect(response).to redirect_to(root_path) }
    end

    context 'success save' do
      before { post :create, title: task.title }

      it 'generate @task' do
        expect(assigns(:task)).not_to be_nil
      end

      it '#save task' do
        expect(assigns(:task)).to receive(:save).and_return(true)
        post :create, title: task.title
      end
    end

    context 'invalid save' do
      before do
        post :create, title: nil
      end

      it 'generate fail message' do
        expect(response_body['message']).to eq I18n.t('task.error_save')
      end

    end

  end

  describe 'POST #update' do

    context 'success update' do
      before { patch :update, id: task.id, title: 'new name' }

      context 'cancan doesnt allow :update' do
        before do
          ability.cannot :update, Task
          patch :update, id: task.id, title: 'new name'
        end
        it { expect(response).to redirect_to(root_path) }
      end

      it 'generate @task' do
        expect(assigns(:task)).not_to be_nil
      end

      it '#update task' do
        expect(assigns(:task)).to receive(:update).with(title: task.title).and_return(true)
        patch :update, id: task.id, title: task.title
      end
    end

    context 'invalid update' do
      before do
        patch :update, id: task.id, title: nil
      end

      it 'generate fail message' do
        expect(response_body['message']).to eq I18n.t('task.error_update')
      end
    end
  end

  describe 'POST #destroy' do
    before { delete :destroy, id: task.id }

    context 'cancan doesnt allow :destroy' do
      before do
        ability.cannot :destroy, Task
        delete :destroy, id: task.id
      end
      it { expect(response).to redirect_to(root_path) }
    end

    it 'generate @task' do
      expect(assigns(:task)).not_to be_nil
    end

    it '#destroy task' do
      expect(assigns(:task)).to receive(:destroy).and_return(true)
      delete :destroy, id: task.id
    end

  end

  def response_body
    JSON.parse(response.body)
  end

end
