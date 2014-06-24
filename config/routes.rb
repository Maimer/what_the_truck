Rails.application.routes.draw do
  root to: 'food_trucks#index'

  resources :food_trucks, only: [:index, :show, :new, :create] do
    resources :reviews, only: [:create]
  end
end
