Rails.application.routes.draw do

  root to: 'food_trucks#index'

  devise_for :users

  resources :food_trucks, only: [:index, :show, :new, :create, :destroy] do
    resources :reviews, only: [:create, :destroy] do
      resources :votes, only: [:create, :update, :destroy]
    end
  end
end
