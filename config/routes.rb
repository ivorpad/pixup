Rails.application.routes.draw do

  devise_for :users
  root to: 'welcome#index'
# resources :projects, :path => '' in order to get example.com/:project_id

  resources :projects, except: [:show] do
    resources :category, controller: 'categories', as: :category, except: [:show, :index] do
        resources :asset, controller: 'assets', as: :assets, only: [:show, :index]
      end
  resources :asset, controller: 'assets', as: :assets, except: [:show, :index]
  end

  match '/projects/:project_id', to: 'projects#show', :via => [:get]
  match '/projects/:project_id/:category_id/:id', to: 'assets#show', :via => [:get]
  match '/projects/:project_id/:category_id', to: 'categories#show', :via => [:get]
  match '/projects/:project_id/:category_id/:asset_id', to: 'assets#show', :via => [:get]

end

# example.com/project/1/category/1
# example.com/asset/1
# example.com/project/1/asset/1/
# BAD: example.com/my-project/my-category/my-asset/
# OR example.com/my-project/images/cars/[:show]
# example.com/project-name/category-name/asset-name/
