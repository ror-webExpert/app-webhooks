Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :webhooks do
    resource :movies, only: [:create]
    resource :stripe, controller: :stripe, only: [:create]
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
