Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root 'pages#index'
  get 'token' => 'pages#token'
  get 'show' => 'pages#show'
  get 'unauthorized' => 'pages#unauthorized'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
