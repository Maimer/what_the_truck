Rails.application.routes.draw do
  devise_for :users
  root to: 'food_trucks#index'

  resources :food_trucks, only: [:index, :show, :new, :create]

  resources :food_trucks do
    resources :reviews, only: [:create]
  end
end
