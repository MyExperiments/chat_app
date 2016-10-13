Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :home, only: [:index]

  resources :chat_rooms, only: [:show, :create]

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show]
    end
  end

  root 'home#index'

  mount ActionCable.server => '/cable'

  mount Apidoco::Engine, at: '/docs'
end
