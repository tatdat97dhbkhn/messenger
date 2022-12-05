Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  resources :users, only: :index
  resources :chat, only: :index
  resources :giphy, only: :index
  scope :chat do
    resources :channels, only: %i[] do
      collection do
        get :show_or_create
      end

      member do
        put :read_message_notifications
      end

      resources :messages, only: :create do
        resources :message_reactions, only: %i[index create]
        resources :message_notifications, only: :create
      end
    end
  end

  put '/rails/active_storage/disk/:encoded_token', to: 'upload#update'
end
