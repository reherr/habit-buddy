Rails.application.routes.draw do
  resources :habit_entries
  resources :habits
  devise_for :users

  root to: 'home#index'
end
