Rails.application.routes.draw do
  root "search#index"
  match "/", to: "search#index", via: [:get, :post]
  match "/search/lookup",  to: "search#lookup", via: [:get, :post]
end