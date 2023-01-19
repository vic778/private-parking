Rails.application.routes.draw do
  namespace :admin do
      resources :roles
      resources :users

      root to: "roles#index"
    end
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users
end
