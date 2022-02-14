# == Route Map
#

Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  resources :users, only: %i[new create destroy]
  resources :articles do
    resources :comments, only: %i[create destroy], shallow: true
  end
  resources :favorites, only: %i[index create destroy]

  root 'articles#index'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
