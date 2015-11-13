Rails.application.routes.draw do

  devise_for :users
  root to: 'welcome#index'

  resources :projects, except: [:show, :index] do
    resources :category, controller: 'categories', as: :category, except: [:index], path: '' do
        resources :asset, controller: 'assets', as: :assets, only: [:show, :new], path: ''
      end
  resources :asset, controller: 'assets', as: :assets, except: [:show, :index]
  end

  get '/projects', to: 'projects#index'
  get '/projects/:project_id', to: 'projects#show'
  get '/projects/:project_id/:category_id/:id', to: 'assets#show'
  get '/projects/:project_id/:category_id', to: 'categories#show'
  get '/projects/:project_id/:category_id/:asset_id', to: 'assets#show'
end
