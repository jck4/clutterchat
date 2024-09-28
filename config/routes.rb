Rails.application.routes.draw do
  get "pages/auth_error"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :posts
  get 'auth_error', to: 'pages#auth_error'
  root to: 'home#index'
end
