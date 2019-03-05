Rails.application.routes.draw do
  root 'home#index'
  resources :users, only: [:new, :show, :create]
end
