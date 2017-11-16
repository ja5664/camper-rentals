Rails.application.routes.draw do
  get 'pages/home'

  devise_for :users, controllers: { sessions: 'users/sessions' }
  mount Attachinary::Engine => "/attachinary"
  root to: "pages#home"

  resources :vans do
    resources :rentals, only: [:index, :new, :create]
    resources :reviews, only: [:index, :new, :create]
  end

  resources :rentals, only: [:show, :edit, :update, :destroy]
  resources :reviews, only: [:edit, :update, :destroy]
end
