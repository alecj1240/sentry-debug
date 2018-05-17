Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root 'pages#index'
  get 'token' => 'registrations#token'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
