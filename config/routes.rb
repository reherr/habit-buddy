Rails.application.routes.draw do
  # get 'home/index'
  resources :habit_entries
  resources :habits
  devise_for :users

  root to: "home#index"

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:

  # get "/your_first_screen" => "pages#first"
  
end
