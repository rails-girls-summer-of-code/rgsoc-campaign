require 'geo_ip'

Rails.application.routes.draw do

  root to: 'static#index'
  resources :applications
  resources :applications_imports
  resources :ratings
  resources :comments
  resources :coaches, only: :index

  resources :donations do
    post 'checkout', on: :collection
    get 'stats',     on: :collection
    get 'checkout',  on: :collection if Rails.env.development?
    get 'confirm',   on: :member
  end

  get 'donations.json', to: 'orders#index', as: :donors
  get 'geo_ip.json', to: GeoIP.new
end
