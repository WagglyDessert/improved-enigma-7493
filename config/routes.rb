Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  #joins-y approach per turing
  resources :dishes, only: [:show] do 
    resources :ingredients, only: [:create, :destroy], controller: "dish_ingredients"
  end

  #rails-y approach used with ingredients controller
  # resources :dishes, only: [] do 
  #   resources :ingredients, only: :create
  # end

  get "/chefs/:id", to: "chefs#show"

  get "chefs/:id/ingredients", to: "chef_ingredients#index"
end
