Rails.application.routes.draw do
  root to: 'home#index'

  resources :habit_entries
  resources :habits
  devise_for :users

end
