Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do

    # get 'authentication/login'
    # get 'authentication/logout'

    # get 'sessions/create'
    
    resources :sessions, only: [ :create ] do
      delete '/', on: :collection, action: :destroy
      get :status, on: :collection
    end

    resources :categories, only: [ :index, :create, :show, :update, :destroy ]
    resources :list_items, only: [ :index, :create, :show, :update, :destroy ]

    resources :lists, only: [ :index, :create, :show, :update, :destroy ] do
      post :like, on: :member
      delete :dislike, on: :member
      get :draft_lists, on: :collection
      get :published_lists, on: :collection
    end

    resources :users, only: [ :index, :create, :show, :update, :destroy ] do
      post :follow, on: :collection
      delete :unfollow, on: :collection
      get :followed_users, on: :collection
      get :followers, on: :collection
      get :followed_users_lists, on: :collection
      post :find_users, on: :collection
    end

  end

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
