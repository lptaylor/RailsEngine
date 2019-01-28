Rails.application.routes.draw do

  namespace :api do
    namespace :v1  do
      namespace :merchants do
        get 'find', to: 'search_functions#show'
        get 'find_all', to: 'search_functions#index'
        get 'random', to: 'random#show'
        get 'most_revenue', to: 'most_revenue#index'
      end
      resources :merchants, only: [:index, :show] do
        get 'items', to: 'items#index'
        get 'invoices', to: 'invoices#index'
      end
    end
  end
end
