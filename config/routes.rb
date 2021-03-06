
Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  mount Sidekiq::Web => "/sidekiq"
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to=> "posts#index"
  
  resources :users, only: [:show, :index]

  resources :posts

  resources :comments

  resources :likes

  resources :friendships
  resources :conversations, only: [:create] do
    member do
      post :close
    end
    resources :messages, only: [:create]
  end
  get :chat, to: "home#index"
  resources :messages, only: [:create]
  get :pending_requests, to: 'friendships#pending'

end
