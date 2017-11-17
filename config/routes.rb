Rails.application.routes.draw do
  get 'pages/home'

  devise_for :users
  mount Attachinary::Engine => "/attachinary"
  root to: "pages#home"

  resources :vans do
    resources :rentals, only: [:new, :create]
    resources :reviews, only: [:index, :new, :create]
  end

  resources :rentals, only: [:index, :show, :edit, :update, :destroy]
  resources :reviews, only: [:show, :edit, :update, :destroy]
end
