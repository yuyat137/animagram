# == Route Map
#

Rails.application.routes.draw do
  resources :users, only: %i[new create destroy]
  resources :articles
    resources :comments, only: %i[create, destroy], shallow: true
  root 'static_pages#top'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
