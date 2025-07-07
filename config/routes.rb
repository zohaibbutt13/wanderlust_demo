Rails.application.routes.draw do
  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"

  resources :projects, only: [ :index, :new, :create ]
  resources :clients, only: [ :index ] do
    member do
      post :login
      delete :logout
    end
  end

  root "clients#index"
end
