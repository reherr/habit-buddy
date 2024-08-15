Rails.application.routes.draw do
  draw :admin
  draw :service_worker
  root to: 'home#index'
  resources :habit_entries
  resources :habits
  devise_for :users
end
