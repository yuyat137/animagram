# == Route Map
#

Rails.application.routes.draw do
  resources :users, only: %i[new create destroy]
  resources :articles do
    resources :comments, only: %i[create destroy], shallow: true
    collection do
      get :favorites
    end
  end
  resources :favorites, only: %i[create destroy]

  root 'articles#index'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
