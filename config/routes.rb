Rails.application.routes.draw do
  get 'comments/create'
  root "static_pages#home"

  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users, except: [:new, :create]
  resources :reviews, only: [:show, :destroy]
  resources :tours, only: [:index, :show] do
    resources :reviews, only: [:new, :show, :create]
    resources :bookingtours, only: [:create, :new]
    resources :comments, only: :create
  end
  resources :comments, only: :create do
    resources :comments, only: :create
  end
end
