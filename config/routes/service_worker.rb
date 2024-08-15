Rails.application.routes.draw do
  get '/manifest.json', to: 'service_worker#manifest'
end
