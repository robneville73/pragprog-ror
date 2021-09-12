Rails.application.routes.draw do

  root "movies#index"

  get "movies/filter/:filter" => "movies#index", as: :filtered_movies

  resources :movies do
    resources :reviews
    resources :favorites, only: [:create, :destroy]
  end

  resources :users
  resources :genres

  resource :session, only: [:new, :create, :destroy]

  get "signup" => "users#new"
  get "signin" => "sessions#new"

end
