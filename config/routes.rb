Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :home, only: [:index] do
    collection do
      get 'search_user'
    end
  end

  resources :users, only: [:index]

  resources :chat_rooms, only: [:show, :create]

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show]
      resources :chat_rooms, only: [:create]
    end
  end

  root 'home#index'

  mount ActionCable.server => '/cable'

  mount Apidoco::Engine, at: '/docs'
end
