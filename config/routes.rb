Rails.application.routes.draw do

  namespace :api do

    # get 'authentication/login'
    # get 'authentication/logout'

    # get 'sessions/create'
    
    resources :sessions, only: [ :create ] do
      delete '/', on: :collection, action: :destroy
    end

    resources :categories, only: [ :index, :create, :show, :update, :destroy ]
    resources :list_items, only: [ :index, :create, :show, :update, :destroy ]

    resources :lists, only: [ :index, :create, :show, :update, :destroy ] do
      post :like, on: :member
      delete :dislike, on: :member
    end

    resources :users, only: [ :index, :create, :show, :update, :destroy ] do
      post :follow, on: :collection
      delete :unfollow, on: :collection
      get :followed_users, on: :collection
      get :followers, on: :collection
      get :followed_users_lists, on: :collection
    end

  end

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
