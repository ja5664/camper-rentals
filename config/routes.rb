Rails.application.routes.draw do
  devise_for :users
  root to: "vans#index"

  resources :vans do
    resources :rentals, only: [:index, :new, :create]
    resources :reviews, only: [:new, :create]
  end

  resources :rentals, only: [:show, :edit, :update, :destroy]
  resources :reviews, only: [:show, :edit, :update, :destroy]
end
