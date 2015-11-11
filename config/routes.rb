Rails.application.routes.draw do

  devise_for :users
  root to: 'welcome#index'
# resources :projects, :path => '' in order to get example.com/:project_id
  resources :projects do
    resources :category, controller: 'categories', as: :category do
        resources :asset, controller: 'assets', as: :assets, only: [:show, :index]
      end
  resources :asset, controller: 'assets', as: :assets, except: [:show, :index]
  end
end

# example.com/project/1/category/1
# example.com/asset/1
# example.com/project/1/asset/1/
# BAD: example.com/my-project/my-category/my-asset/

# OR example.com/my-project/images/cars/[:show]


# example.com/project-name/category-name/asset-name/
