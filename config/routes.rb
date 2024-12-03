Rails.application.routes.draw do
  get 'animals/new'
  get 'animals/create'
  devise_for :users
  root to: "animals#index"

  resources :animals, only: [:new, :create, :show, :index]


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
