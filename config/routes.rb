Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do 
      resources :users do 
        resources :lists
      end

      resources :lists, only: [:index] do 
        resources :items, only: [:create]
      end

      resources :items, only: [:update, :destroy]
  end

  devise_for :users
    resources :users 

  root to: 'welcome#index'
end
