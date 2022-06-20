Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'user/registrations' }
  resources :users, shallow: true, only: [:edit, :update, :show] do
    resources :posts
    resources :comments
    resources :stories
    resources :attachments, except:[:edit, :update]
    resources :followings, only: [:destroy, :create, :index]
    resources :likes, only: [:destroy, :create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
end
