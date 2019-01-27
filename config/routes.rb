Rails.application.routes.draw do

  namespace :api do
    namespace :v1  do
      resources :merchants, only: [:index, :show]
      namespace :merchants do
        get 'find', to: 'search_functions#show'
      end
    end
  end
end
