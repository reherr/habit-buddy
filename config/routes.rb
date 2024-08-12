Rails.application.routes.draw do
  root to: 'home#index'

  resources :habit_entries
  resources :habits
  devise_for :users

  authenticate :user, ->(user) { user.admin? } do
    mount RailsAdmin::Engine, at: "admin", as: "rails_admin"
  end

end
