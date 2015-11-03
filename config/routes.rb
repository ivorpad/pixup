Rails.application.routes.draw do

  devise_for :users
  root to: 'welcome#index'

  # http://stackoverflow.com/questions/14731654/no-route-matches-action-show-controller-users
  resources :projects do
    resources :asset, controller: 'assets', as: :assets
  end
end

# localhost.com/projects/:project_id/asset/:id
