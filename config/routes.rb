Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'dashboards#index'

  scope '(:locale)', locale: /en|vi/ do
    devise_for :users, controllers: { passwords: 'user/passwords' }

    get '/', to: 'dashboards#index'

    namespace :owner do
      resources :users, only: %i(index new create) do
        post :toggle, on: :member
      end
    end

    resources :dashboards, only: %i(index)
    resources :companies, only: %i(update edit)
    resources :products, except: %i(show)
    resources :invoices do
      get :download, on: :member
      post :approve, on: :member
      get :cancle, on: :member
    end
    resources :customers, except: %i(show)
  end
end
