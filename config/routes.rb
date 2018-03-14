Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      namespace :invoices do
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/random', to: 'random#show'
      end
      resources :invoices, only: [:index, :show]

      namespace :merchants do
        get '/:id/revenue', to: 'merchant_revenue#index'
        get '/find', to: 'finder#show'
        get '/find_all', to: 'finder#index'
        get '/random', to: 'random#show'
        get '/most_revenue', to: "most_revenue#index"
      end

      resources :merchants, only: [:show, :index], module: :merchants do
        get '/items', to: 'merchant_items#index'
        get '/invoices', to: 'merchant_invoices#index'
      end

      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      resources :transactions, only: [:show, :index]

      namespace :customers do
        get 'find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      resources :customers, only: [:show, :index]
    end
  end
end
