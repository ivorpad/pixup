Rails.application.routes.draw do

  devise_for :users
  root to: 'welcome#index'

  resources :projects do
    resources :category, controller: 'categories', as: :category do
        resources :asset, controller: 'assets', as: :assets, shallow: true
      end
  end
end

# example.com/project/1/category/1
# example.com/asset/1
# example.com/project/1/asset/1/
# BAD: example.com/project/1/category/1/asset/1/

# OR example.com/my-project/images/cars/[:show]


# example.com/project-name/category-name/asset-name/
