Rails.application.routes.draw do
  root 'sales#index'

  resources :sales, only: [:index]
end
