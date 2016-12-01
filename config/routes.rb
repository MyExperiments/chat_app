Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :home, only: [:index] do
    collection do
      get 'search_user'
    end
  end

  resources :users, only: [:index] do
    collection do
      get 'friend_request'
      get 'cancel_request'
      get 'accept_request'
      get 'unfriend_user'
      get 'user_relations'
      get 'mutual_friends'
      get 'user_profile'
      get 'friends_list'
      get 'users_list'
      get 'friend_requests'
      get 'update_location'
    end
  end

  resources :chat_rooms, only: [:show, :create] do
    collection do
      get 'chat_room_messages'
      get 'delete_conversation'
      post 'upload_attachment'
    end
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show]
      resources :chat_rooms, only: [:create]
    end
  end

  root 'home#index'

  mount ActionCable.server => '/cable'

  mount Apidoco::Engine, at: '/docs'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
