Rails.application.routes.draw do
  root 'clients#index'
  
  resources :clients do
    collection do
      get :export_csv, defaults: { format: :csv }
      get :export_json, defaults: { format: :json }
    end
  end

  resources :clients do
    resources :savs, shallow: true
  end
  
  resources :savs, only: [:index] do
    collection do
      post :update_returned_today
    end
  end
end
