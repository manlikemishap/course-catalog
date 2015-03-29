Rails.application.routes.draw do
  root "search#index"
  match "/", to: "search#index", via: [:get, :post]
  match "/search/search", to: "search#search", via: [:get, :post]
  match "/search/lookup",  to: "search#lookup", via: [:get, :post]
  match "/search/info_for_result", to: "search#info_for_result", via: [:get, :post]
  match "/plan", to: "search#plan", via: [:get, :post]
end