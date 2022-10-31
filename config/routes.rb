Rails.application.routes.draw do
  root 'chat#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  resources :chat, only: :index
end
