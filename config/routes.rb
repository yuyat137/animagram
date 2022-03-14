# == Route Map
#

Rails.application.routes.draw do
  resources :users, only: %i[new create destroy]
  resources :articles do
    resources :comments, only: %i[create destroy], shallow: true
    resource :favorite, only: %i[create destroy]
    post :confirm_category, action: :confirm_category, on: :new
  end
  resources :favorite_articles, only: :index

  get 'category_list', to: 'articles#category_list'
  root 'articles#index'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'terms', to: 'settings#terms'
  get 'privacy_policy', to: 'settings#privacy_policy'
  get '*path', to: 'application#render404'
end
