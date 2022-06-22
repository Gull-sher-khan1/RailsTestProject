# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'user/registrations' }
  resources :users, shallow: true, only: %i[index edit update show] do
    resources :posts
    resources :comments
    resources :stories, only: %i[create destroy]
    resources :attachments, except: [:edit]
    resources :followings, only: %i[destroy create index update]
    resources :likes, only: %i[destroy create]
  end
  post '/get_comments', to: 'home#get_comments'
  post '/show_story/:id', to: 'home#show_story'
  post '/attachments/:id', to: 'attachments#update'
  post '/posts/:id', to: 'posts#update'
  get '/search', to: 'home#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end
