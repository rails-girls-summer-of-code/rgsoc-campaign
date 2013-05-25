require 'geo_ip'

Rgsoc::Application.routes.draw do
  match 'donate/:package', as: :new_donation, to: 'donations#new'
  match 'subscriptions/:package', as: :new_subscription, to: 'orders#new', subscription: true
  match 'geo_ip.json', to: GeoIP.new

  resources :donations do
    get 'confirm', on: :member
  end

  match '/donations.json', to: 'orders#index', as: :donors

  # devise_for :users, controllers: { omniauth_callbacks: 'sessions' }
  # as :user do
  #   get 'users/sign_out', to: 'devise/sessions#destroy', as: :destroy_session
  # end
end
