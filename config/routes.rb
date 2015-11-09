Rails.application.routes.draw do

  devise_for :users
  root to: 'welcome#index'

  # http://stackoverflow.com/questions/14731654/no-route-matches-action-show-controller-users
  # TODO: Not sure about this approach
  resources :projects, shallow: true do
    resources :category, controller: 'categories', as: :category do
      resources :asset, controller: 'assets', as: :assets
    end

  end
end

# localhost.com/projects/:project_id/asset/:id
# localhost.com/images/my-project/cars/1/image.jpg
