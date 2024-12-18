Rails.application.routes.draw do
  devise_for :users
  root to: "animals#index"

  resources :animals, only: [:new, :create, :show, :index, :edit, :update, :destroy] do
    resources :bookings, only: [:new, :create]
    post :check_availability, on: :member
    member do
      delete :delete_photo, to: "animals#destroy_photo"
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "/animals/:id", to: "animals#show"
  get "/my_listings", to: "animals#my_listings"
  get "/search", to: "animals#search"

  #  get "bookings/:id/review", to: "reviews/show"
  # Defines the root path route ("/")
  # root "posts#index"

  # DISPLAYING BOOKINGS
  # get 'users/:id/bookings', to: 'users#index'
  resources :bookings, only: [:index, :show, :edit, :update, :destroy] do
    resources :reviews, only: [:index, :new, :create]
    member do
      patch :cancel
    end
  end
end
