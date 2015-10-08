Rails.application.routes.draw do

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks',sessions: 'users/sessions'}


  root 'home#index'

  resources :projects, except: [:new, :show]
  resources :tasks, except: [:new, :show]
  resources :comments, only: [:create, :update, :destroy] do
    member { post 'attach_files' }
  end


end
