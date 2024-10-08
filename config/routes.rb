Rails.application.routes.draw do
  devise_for :users
  resources :comments
  resources :posts
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get 'admin_page', to: 'pages#admin_page'

  # Defines the root path route ("/")
  root "posts#index"
  resources :posts do
  resources :comments, only: [:create, :destroy]
   end

   resources :users do
    member do
      post 'add_role'
      delete 'remove_role'
    end
  end
end
