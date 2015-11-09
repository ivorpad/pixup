Rails.application.routes.draw do

  devise_for :users
  root to: 'welcome#index'

  # http://stackoverflow.com/questions/14731654/no-route-matches-action-show-controller-users
  # TODO: Not sure about this approach
  resources :projects do
    resources :category, controller: 'categories', as: :category do
        resources :asset, controller: 'assets', as: :assets, shallow: true
      end
  end
end

# localhost.com/projects/:project_id/asset/:id
# localhost.com/my-project/images/cars/image.jpg
