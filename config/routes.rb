Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :customers do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end
      resources :customers, only: [:index, :show]

      namespace :invoice_items do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end
      resources :invoice_items, only: [:index, :show]

      namespace :invoices do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end
      resources :invoices, only: [:index, :show]

      namespace :items do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end
      resources :items, only: [:index, :show]

      namespace :merchants do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'most_revenue', to: 'revenue#index'
      end
      resources :merchants, only: [:index, :show] do
        get 'revenue', to: 'merchants/revenue#show'
        get 'favorite_customer', to: 'merchants/favorite#show'
      end

      namespace :transactions do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end
      resources :transactions, only: [:index, :show]
    end
  end
end
