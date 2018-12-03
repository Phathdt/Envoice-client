Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'invoices#index'

  scope '(:locale)', locale: /en|vi/ do
    devise_for :users, controllers: { passwords: 'user/passwords' }

    get '/', to: 'invoices#index'

    namespace :owner do
      resources :users, only: %i(index new create) do
        post :toggle, on: :member
      end
    end

    resources :companies, only: %i(update edit)
    resources :products, except: %i(show)
    resources :invoices do
      get :download, on: :member
      post :approve, on: :member
      post :multi_approve, on: :collection
      get :cancle, on: :member
    end
    resources :customers, except: %i(show) do
      post :search_tax, on: :collection
    end
  end
end
