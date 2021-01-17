Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:show]
  resources :user_stocks, only: [:create, :destroy]
  resources :friendships, only: [:destroy, :create]

  root 'welcome#index'

  get '/my_portfolio', to: 'users#my_portfolio'
  get '/my_friends', to: 'users#my_friends'
  get '/search_stock', to: 'stocks#search'
  get '/search_user', to: 'users#search'
end
