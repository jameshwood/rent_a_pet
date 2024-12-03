Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # resources :users, only: [ :show, :index ] do
  #   resources :animals, except: [ :destroy ]
  #   resources :bookings, except: [ :destroy ]
  #   resources :reviews, except: [ :destroy ]
  # end

  # resources :animals do
  #   resources :bookings
  # end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
