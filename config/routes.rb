require 'geo_ip'

Rgsoc::Application.routes.draw do
  resources :donations do
    post 'checkout', on: :collection
    get 'confirm', on: :member
  end

  match '/donations.json', to: 'orders#index', as: :donors
  match 'geo_ip.json', to: GeoIP.new
end
