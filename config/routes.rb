Rails.application.routes.draw do
  root "search#index"
  match "/", to: "search#index", via: [:get, :post]
end