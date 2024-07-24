Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'users/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  root 'gifts#index'
  resources :payment_methods, path: 'metodos-de-pago'

  resources :gifts, path: 'regalos', only: [:index, :show]
  resources :catering, only: [:index]
  resources :merchandising, only: [:index]
  resources :events, path: 'eventos', only: [:index]

  resources :purchases, path: 'compras', only: [:new, :create, :index, :show] do
    get :confirmation, on: :collection
  end
  devise_for :users,
             controllers: { registrations: 'users/registrations', sessions: 'users/sessions',
                            passwords: 'users/passwords' }
end
