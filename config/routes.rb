Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'user/registrations' }
  resources :users, shallow: true, only: [:index, :edit, :update, :show] do
    resources :posts
    resources :comments
    resources :stories, only: [:create, :destroy]
    resources :attachments, except:[:edit]
    resources :followings, only: [:destroy, :create, :index, :update]
    resources :likes, only: [:destroy, :create]
  end
  post '/get_comments', to: 'home#get_comments'
  post '/attachments/:id', to: 'attachments#update'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
end
