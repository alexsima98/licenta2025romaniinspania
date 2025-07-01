Rails.application.routes.draw do
  get "housings/index"
  get "housings/show"
  get "housings/new"
  get "housings/create"
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resource :profile, only: [:edit, :update], controller: :users
  resources :jobs do
    member do
      patch :publish
    end
  end

  resources :housings, only: [:index, :show, :new, :create] do
    member do
      patch :publish
    end
  end

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
