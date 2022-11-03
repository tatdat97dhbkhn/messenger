Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  resources :chat, only: :index
  scope :chat do
    resources :channels, only: %i[] do
      collection do
        get :show_or_create
      end
    end
  end
end
