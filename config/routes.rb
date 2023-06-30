Rails.application.routes.draw do
  root to: redirect('/foods', status: 302)
  resources :general_shopping_list, only: %i[index]
  resources :recipe_foods, only: %i[new create destroy]
  resources :recipes, except: %i[edit update]
  resources :foods, except: %i[edit update]
  devise_for :users

  get '/public_recipes', to: 'recipes#public_recipes'
end
