Rails.application.routes.draw do
  root 'home#index'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/me', to: 'users#show'
  get '/me/:id/edit', to: 'users#edit', as: 'edit_me'
  patch '/me/:id/edit', to: 'users#update'
  get 'me/:id/following', to: 'users#following', as: 'following_user'
  get 'me/:id/followers', to: 'users#followers', as: 'followers_user'
  get '/all', to: 'users#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :tweets, only: [:create, :destroy]
  resources :follows, only: [:create, :destroy]
end
