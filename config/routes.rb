Rails.application.routes.draw do
  root to: redirect('/foods', status: 302)
  resources :recipe_foods
  resources :recipes, except: %i[edit update]
  resources :foods, except: %i[edit update]
  devise_for :users
end
