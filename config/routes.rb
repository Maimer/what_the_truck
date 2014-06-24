Rails.application.routes.draw do
  resources :food_trucks, only: [:index, :show, :new, :create]
end
