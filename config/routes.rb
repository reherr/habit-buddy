# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'
  
  resources :habit_entries
  resources :habits
  devise_for :users
  
  authenticate :user, ->(user) { user.admin? } do
    mount Blazer::Engine, at: 'blazer'
    mount RailsAdmin::Engine, at: 'admin', as: 'rails_admin'
  end

  get '/service-worker.js', to: 'service_worker#service_worker'
  get '/manifest.json', to: 'service_worker#manifest'
end
