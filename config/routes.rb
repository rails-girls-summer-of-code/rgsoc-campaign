require 'geo_ip'

Rgsoc::Application.routes.draw do
  match 'foo', to: 'applications#foo'

  resources :applications
  resources :applications_imports
  resources :ratings
  resources :comments

  resources :donations do
    post 'checkout', on: :collection
    get 'stats',     on: :collection
    get 'checkout',  on: :collection if Rails.env.development?
    get 'confirm',   on: :member
  end

  match 'donations.json', to: 'orders#index', as: :donors
  match 'geo_ip.json', to: GeoIP.new
end
