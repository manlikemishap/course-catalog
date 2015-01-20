Rails.application.routes.draw do
  root "home#index"
  match "/", to: "home#index", via: [:get, :post]
end