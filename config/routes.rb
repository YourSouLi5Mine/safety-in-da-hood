Rails.application.routes.draw do
  get 'sessions/new'
  root 'home#index'
  resources :users, only: [:new, :show, :create]
end
