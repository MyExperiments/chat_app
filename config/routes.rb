Rails.application.routes.draw do
  devise_for :users

  resources :home, only: [:index]

  resources :chat_rooms, only: [:show, :create]

  root 'home#index'

  mount ActionCable.server => '/cable'
end
