Rails.application.routes.draw do
  resources :recipe_foods
  resources :recipes
  resources :foods, except: [:edit, :update]
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # get '/foods/show', to: 'foods#show', as: 'show_food'
  # get '/foods/index', to: 'foods#index'

  # Defines the root path route ("/")
  # root "articles#index"
end
