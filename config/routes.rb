
Rails.application.routes.draw do
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "images#index"
  # post 'images/mycourse'

  resources :images, only: [:create, :index, :show]
  resources :personal_details
end
