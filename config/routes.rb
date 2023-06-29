Rails.application.routes.draw do
  root to: redirect('/foods', status: 302)
  resources :recipe_foods
  resources :recipes, except: %i[edit update]
  resources :foods, except: %i[edit update]
  devise_for :users

  get '/public_recipes', to: 'recipes#public_recipes'
  get '/general_shopping_list', to: 'recipe_foods#index'

end
