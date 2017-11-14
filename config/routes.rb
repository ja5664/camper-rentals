Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :vans do
    resources :rentals
    resources :reviews
  end
end
