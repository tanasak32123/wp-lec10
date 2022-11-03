Rails.application.routes.draw do
  resources :inventories
  resources :items
  get 'main/login'
  get 'main/user_item'
  post 'main/login'
  post 'main/create'
  delete 'items/:id', to: 'items#destroy', as: 'delete_item'
  get 'items/new/:id', to: 'items#new_user_item', as: 'new_user_item'
  get 'shop/:id', to: 'main#shop'
  post 'main/buy/:id/:user_id', to: 'main#buy', as: "main_buy" 
  get 'main/inventories'
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
