Rails.application.routes.draw do
  get 'pages/index'
  namespace :admin do
      resources :roles
      resources :users
      resources :parkings
      resources :slot_types
      resources :slots
      resources :reservations
      resources :bookings

      root to: "roles#index"
    end
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  root "pages#index"
  devise_for :users

  namespace :api do
      devise_scope :user do
        post 'login', to: 'sessions#create'
        put 'user', to: 'users#update'
      end
  end
end
