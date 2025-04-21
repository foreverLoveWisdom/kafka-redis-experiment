# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable'

  resources :transfers

  post '/notifications', to: 'notifications#create'
end
