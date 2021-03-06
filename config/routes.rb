Rails.application.routes.draw do

  root to: 'food_trucks#index'

  devise_for :users

  resources :food_trucks, only: [:index, :show, :new, :create] do
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: [] do
    resources :votes, only: [:create]
  end

  namespace :admin do
    root to: 'food_trucks#index'
    resources :food_trucks, only: [:index, :show, :destroy]
    resources :reviews, only: [:destroy]
  end
end
