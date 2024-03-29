# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users

  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
