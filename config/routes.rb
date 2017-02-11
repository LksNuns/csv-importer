Rails.application.routes.draw do
  root 'sales#index'

  resources :sales, only: [:index] do
    post :import_csv, on: :collection
  end
end
