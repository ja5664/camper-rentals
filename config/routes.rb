Rails.application.routes.draw do
  get 'pages/home'

  devise_for :users
  mount Attachinary::Engine => "/attachinary"
  root to: "pages#home"

  resources :vans do
    resources :rentals, only: [:index, :new, :create]
    resources :reviews, only: [:new, :create]
  end

  resources :rentals, only: [:show, :edit, :update, :destroy]
  resources :reviews, only: [:show, :edit, :update, :destroy]
end
