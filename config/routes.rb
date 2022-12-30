# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
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
    resources :channels, only: %i[show create update] do
      scope module: 'chat/channels' do
        resources :users, only: [] do
          collection do
            get :joined_users
            get :not_joined_users
          end

          member do
            post :add
            delete :kick
            delete :leave
          end
        end
      end
      member do
        put :read_message_notifications
        get :settings
      end

      resources :messages, only: :create do
        resources :message_reactions, only: %i[index create]
        resources :message_notifications, only: :create
      end
    end
  end

  put '/rails/active_storage/disk/:encoded_token', to: 'upload#update'
end
# rubocop:enable Metrics/BlockLength
