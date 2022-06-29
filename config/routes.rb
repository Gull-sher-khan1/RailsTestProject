# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'user/registrations', confirmations: 'user/confirmations' }
  resources :users, shallow: true, only: %i[edit update show] do
    resources :posts, except: %i[index new show]
    resources :comments, except: %i[index new show]
    resources :stories, only: %i[create destroy]
    resources :attachments, only: %i[create update]
    resources :followings, only: %i[destroy create index update]
    resources :likes, only: %i[destroy create]
  end
  resources :home, only: [] do
    collection do
      get :get_comments
      get :show_story
      get :search
    end
  end
  root to: 'home#index'
end
