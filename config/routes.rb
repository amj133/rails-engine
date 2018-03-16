Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      namespace :invoices do
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/random', to: 'random#show'
      end

      resources :invoices, only: [:index, :show], module: :invoices do
        get '/merchant', to: 'merchant#show'
        get '/customer', to: 'customer#show'
        get '/transactions', to: 'transactions#index'
        get '/invoice_items', to: 'invoice_items#index'
        get '/items', to: 'items#index'
      end

      namespace :items do
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/random', to: "random#show"
        get '/most_revenue', to: "items_by_revenue#index"
        get '/most_items', to: "most_items#index"
      end
      resources :items, only: [:index, :show], module: :items do
        get '/best_day', to: 'best_day#show'
        get '/invoice_items', to: 'invoice_items#index'
        get '/merchant', to: 'merchant#show'
      end

      namespace :merchants do
        get '/find', to: 'finder#show'
        get '/find_all', to: 'finder#index'
        get '/random', to: 'random#show'
        get '/most_revenue', to: "most_revenue#index"
        get '/revenue', to: "merchants_revenue#show"
        get '/most_items', to: "most_items#index"
      end
      resources :merchants, only: [:show, :index], module: :merchants do
        get '/revenue', to: 'revenue#show'
        get '/items', to: 'merchant_items#index'
        get '/invoices', to: 'merchant_invoices#index'
        get '/favorite_customer', to: 'merchant_customers#show'
      end

      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end

      resources :transactions, only: [:show, :index], module: :transactions do
        get '/invoice', to: 'transaction_invoice#show'
      end

      namespace :customers do
        get 'find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      resources :customers, only: [:show, :index], module: :customers do
        get '/invoices', to: 'customer_invoices#index'
        get '/transactions', to: 'customer_transactions#index'
        get '/favorite_merchant', to: 'favorite_merchant#show'
      end

      namespace :invoice_items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      resources :invoice_items, only: [:index, :show], module: :invoice_items do
        get '/item', to: 'item#show'
        get '/invoice', to: 'invoice#show'
      end
    end
  end
end
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
